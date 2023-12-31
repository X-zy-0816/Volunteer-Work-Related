#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   detect_online.py
@Contact :   996852067@qq.com
@License :   (C)Copyright 2020-2021

@Modify Time           @Author    @Version    @Desciption
------------           -------    --------    -----------
2022/5/4 下午6:45     xuzhiyuan     1.0         本地识别
'''


import sys
import cv2
import time
import argparse
import random
import torch
import os
import numpy as np
import torch.backends.cudnn as cudnn

from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtGui import QPixmap
from PyQt5.QtWidgets import *
from PyQt5.QtCore import Qt

from utils.torch_utils import select_device
from models.experimental import attempt_load
from utils.general import check_img_size, non_max_suppression, scale_coords
from utils.datasets import letterbox
from utils.plots import plot_one_box2
from Mysql.dbmysql import DB_Mysql

from analyze_window import win_calanda
from UI.detect_ui import Ui_MainWindow # 导入detect_ui的界面
from UI.analyze_ui import Ui_Form_Analyze

now = None


class UI_Logic_Window(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        super(UI_Logic_Window, self).__init__(parent)
        self.timer_video = QtCore.QTimer() # 创建定时器
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.init_slots()
        self.cap = cv2.VideoCapture()
        self.num_stop = 1 # 暂停与播放辅助信号，note：通过奇偶来控制暂停与播放
        self.output_folder = 'output/'
        self.vid_writer = None
        self.didLoad = 0
        self.ui.radioButton.setChecked(True)
        self.conn = DB_Mysql('127.0.0.1', 3306, 'root', 'ilyzy081610', 'yolo_DataBase')
        #self.ui.label.setPixmap(QPixmap('./UI/UI_Resource/Footer_Logo.png'))
        #self.ui.label.setScaledContents(True)  # 设置图像自适应界面大小
        self.ui.label.setStyleSheet("background-color:transparent;background-image:url(./UI/UI_Resource/Footer_Logo.png);background-position:center;background-repeat:no-repeat;");
        #self.ui.lineEdit_url.setText('http://admin:admin@192.168.1.6:8081')

        # 权重初始文件名
        self.openfile_name_model = None

    # 控件绑定相关操作
    def init_slots(self):
        self.ui.pushButton_img.clicked.connect(self.button_image_open)
        self.ui.pushButton_video.clicked.connect(self.button_video_open)
        self.ui.pushButton_camer.clicked.connect(self.button_camera_open)
        self.ui.pushButton_weights.clicked.connect(self.open_model)
        self.ui.pushButton_init.clicked.connect(self.model_init)
        self.ui.pushButton_stop.clicked.connect(self.button_video_stop)
        self.ui.pushButton_finish.clicked.connect(self.finish_detect)
        self.ui.pushButton_Open_Output.clicked.connect(self.open_output)
        self.ui.pushButton_analyze.clicked.connect(self.analyze)

        #self.ui.pushButton_url.clicked.connect(self.url_button_detect)

        self.timer_video.timeout.connect(self.show_video_frame) # 定时器超时，将槽绑定至show_video_frame

    # 打开权重文件
    def open_model(self):
        self.openfile_name_model, _ = QFileDialog.getOpenFileName(self.ui.pushButton_weights, '选择weights文件',
                                                             'weights/')
        if not self.openfile_name_model:
            QtWidgets.QMessageBox.warning(self, u"Warning", u"打开权重失败", buttons=QtWidgets.QMessageBox.Ok,
                                          defaultButton=QtWidgets.QMessageBox.Ok)
        else:
            print('[Local][Weight][Location]：' + str(self.openfile_name_model))

    # 加载相关参数，并初始化模型
    def model_init(self):
        # 模型相关参数配置
        parser = argparse.ArgumentParser()
        parser.add_argument('--weights', nargs='+', type=str, default='weights/Mask_Detect_S.pt', help='model.pt path(s)')
        parser.add_argument('--source', type=str, default='data/images', help='source')  # file/folder, 0 for webcam
        parser.add_argument('--img-size', type=int, default=640, help='inference size (pixels)')
        parser.add_argument('--conf-thres', type=float, default=0.25, help='object confidence threshold')
        parser.add_argument('--iou-thres', type=float, default=0.45, help='IOU threshold for NMS')
        parser.add_argument('--device', default='cpu', help='cuda device, i.e. 0 or 0,1,2,3 or cpu')
        parser.add_argument('--view-img', action='store_true', help='display results')
        parser.add_argument('--save-txt', action='store_true', help='save results to *.txt')
        parser.add_argument('--save-conf', action='store_true', help='save confidences in --save-txt labels')
        parser.add_argument('--nosave', action='store_true', help='do not save images/videos')
        parser.add_argument('--classes', nargs='+', type=int, help='filter by class: --class 0, or --class 0 2 3')
        parser.add_argument('--agnostic-nms', action='store_true', help='class-agnostic NMS')
        parser.add_argument('--augment', action='store_true', help='augmented inference')
        parser.add_argument('--update', action='store_true', help='update all models')
        parser.add_argument('--project', default='runs/detect', help='save results to project/name')
        parser.add_argument('--name', default='exp', help='save results to project/name')
        parser.add_argument('--exist-ok', action='store_true', help='existing project/name ok, do not increment')
        self.opt = parser.parse_args()
        print(self.opt)
        # 默认使用opt中的设置（权重等）来对模型进行初始化
        source, weights, view_img, save_txt, imgsz = self.opt.source, self.opt.weights, self.opt.view_img, self.opt.save_txt, self.opt.img_size

        # 若openfile_name_model不为空，则使用此权重进行初始化
        if self.openfile_name_model:
            weights = self.openfile_name_model

        self.device = select_device(self.opt.device)
        self.half = self.device.type != 'cpu'  #选择硬件支持 CUDA/CPU

        cudnn.benchmark = True

        # Load model
        self.model = attempt_load(weights, map_location=self.device)  # load FP32 model
        stride = int(self.model.stride.max())  # model stride
        self.imgsz = check_img_size(imgsz, s=stride)  # check img_size
        if self.half:
          self.model.half()  # to FP16

        # Get names and colors
        self.names = self.model.module.names if hasattr(self.model, 'module') else self.model.names
        self.colors = [[random.randint(0, 255) for _ in range(3)] for _ in self.names]
        print("[Local][Model]:model initial done")
        # 设置提示框
        QtWidgets.QMessageBox.information(self, u"Notice", u"模型加载完成", buttons=QtWidgets.QMessageBox.Ok,
                                      defaultButton=QtWidgets.QMessageBox.Ok)
        self.didLoad = 1

    # 目标检测
    def detect(self, name_list, img):
        '''
        :param name_list: 文件名列表
        :param img: 待检测图片
        :return: info_show:检测输出的文字信息
        '''
        showimg = img
        with torch.no_grad():
            img = letterbox(img, new_shape=self.opt.img_size)[0]
            # Convert
            img = img[:, :, ::-1].transpose(2, 0, 1)  # BGR to RGB, to 3x416x416
            img = np.ascontiguousarray(img)
            img = torch.from_numpy(img).to(self.device)
            img = img.half() if self.half else img.float()  # uint8 to fp16/32
            img /= 255.0  # 0 - 255 to 0.0 - 1.0
            if img.ndimension() == 3:
                img = img.unsqueeze(0)
            # Inference
            pred = self.model(img, augment=self.opt.augment)[0]
            # Apply NMS
            pred = non_max_suppression(pred, self.opt.conf_thres, self.opt.iou_thres, classes=self.opt.classes,
                                       agnostic=self.opt.agnostic_nms)
            info_show = ""
            # Process detections
            for i, det in enumerate(pred):
                if det is not None and len(det):
                    # Rescale boxes from img_size to im0 size
                    det[:, :4] = scale_coords(img.shape[2:], det[:, :4], showimg.shape).round()
                    for *xyxy, conf, cls in reversed(det):
                        label = '%s %.2f' % (self.names[int(cls)], conf)
                        name_list.append(self.names[int(cls)])
                        single_info = plot_one_box2(xyxy, showimg, label=label, color=self.colors[int(cls)], line_thickness=2)
                        # print(single_info)
                        info_show = info_show + single_info + "\n"
        return  info_show

    def analyzeInfo(self, info_show):

        maskNum = info_show.count('mask')
        nomaskNum = info_show.count('no-mask')

        if nomaskNum == 0:
            maskNum = maskNum
            nomaskNum = nomaskNum
        else:
            maskNum =  maskNum - nomaskNum
            nomaskNum = nomaskNum
        info_show = '---------位置信息---------\n\n' + info_show
        info_show = info_show.replace('Position', '位置')
        info_show = info_show.replace('Obj and Confidence', '准确度')
        info_show += '---------------------------\n\n\n---------统计信息---------\n\n'
        info_show += '佩戴口罩的人数为：'
        info_show += str(maskNum)
        info_show += '\n'
        info_show += '未佩戴口罩的人数为：'
        info_show += str(nomaskNum)
        info_show += '\n---------------------------'
        self.ui.textBrowser.setText(info_show)
        if nomaskNum == 0:
            return maskNum, nomaskNum, info_show
        else:
            return maskNum - nomaskNum, nomaskNum, info_show

    # 打开图片并检测
    def button_image_open(self):
        if self.didLoad == 1:
            print('[Local][Image][Button]:Clicked')
            name_list = []
            try:
                img_name, _ = QtWidgets.QFileDialog.getOpenFileName(self, "打开图片", "data/images", "*.jpg;;*.png;;All Files(*)")
            except OSError as reason:
                print('文件打开出错啦！核对路径是否正确'+ str(reason))
            else:
                # 判断图片是否为空
                if not img_name:
                    QtWidgets.QMessageBox.warning(self, u"Warning", u"打开图片失败", buttons=QtWidgets.QMessageBox.Ok,
                                                  defaultButton=QtWidgets.QMessageBox.Ok)
                else:
                    img = cv2.imread(img_name)
                    print("img_name:", img_name)
                    info_show = self.detect(name_list, img)
                    print(info_show)

                    # 获取当前系统时间，作为img文件名
                    now_time = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
                    file_extension = img_name.split('.')[-1]
                    new_filename = now_time + '.' + file_extension # 获得文件后缀名
                    file_path = self.output_folder + 'img_output/' + new_filename
                    cv2.imwrite(file_path, img)

                    #returnAns = self.conn.insert(table="imageDecInfo", imageName=new_filename)

                    # 是否保存检测信息
                    if self.ui.radioButton.isChecked() == True:
                        info_fileName = now_time + '.txt'
                        file_path = self.output_folder + 'img_output/detail_Info/' + info_fileName
                        with open(file_path, 'w') as f:
                            f.write(info_show)
                            f.close()

                    # 检测信息显示在界面
                    self.analyzeInfo(info_show)

                    # 检测结果显示在界面
                    self.result = cv2.cvtColor(img, cv2.COLOR_BGR2BGRA)
                    self.result = cv2.resize(self.result, (640, 480), interpolation=cv2.INTER_AREA)
                    self.QtImg = QtGui.QImage(self.result.data, self.result.shape[1], self.result.shape[0], QtGui.QImage.Format_RGB32)
                    self.ui.label.setPixmap(QtGui.QPixmap.fromImage(self.QtImg))
                    self.ui.label.setScaledContents(True) # 设置图像自适应界面大小

        else:
            QtWidgets.QMessageBox.warning(self, u"Warning", u"请先加载模型", buttons=QtWidgets.QMessageBox.Ok,
                                          defaultButton=QtWidgets.QMessageBox.Ok)

    def set_video_name_and_path(self):
        # 获取当前系统时间，作为img和video的文件名
        global now
        now = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
        # if vid_cap:  # video
        fps = self.cap.get(cv2.CAP_PROP_FPS)
        w = int(self.cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        h = int(self.cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
        # 视频检测结果存储位置
        save_path = self.output_folder + 'video_output/' + now + '.mp4'
        return fps, w, h, save_path

    # 打开视频并检测
    def button_video_open(self):
        if self.didLoad == 1:
            video_name, _ = QtWidgets.QFileDialog.getOpenFileName(self, "打开视频", "data/", "*.mp4;;*.avi;;All Files(*)")
            flag = self.cap.open(video_name)
            if not flag:
                QtWidgets.QMessageBox.warning(self, u"Warning", u"打开视频失败", buttons=QtWidgets.QMessageBox.Ok,defaultButton=QtWidgets.QMessageBox.Ok)
            else:
                #-------------------------写入视频----------------------------------#
                fps, w, h, save_path = self.set_video_name_and_path()
                self.vid_writer = cv2.VideoWriter(save_path, cv2.VideoWriter_fourcc(*'mp4v'), fps, (w, h))

                self.timer_video.start(30) # 以30ms为间隔，启动或重启定时器
                # 进行视频识别时，关闭其他按键点击功能
                self.ui.pushButton_video.setDisabled(True)
                self.ui.pushButton_img.setDisabled(True)
                self.ui.pushButton_camer.setDisabled(True)
        else:
            QtWidgets.QMessageBox.warning(self, u"Warning", u"请先加载模型", buttons=QtWidgets.QMessageBox.Ok,
                                          defaultButton=QtWidgets.QMessageBox.Ok)

    # 打开摄像头检测
    def button_camera_open(self):
        if self.didLoad == 1:

            print("[Local][Camera]:Open camera to detect")
            # 设置使用的摄像头序号，系统自带为0
            camera_num = 0
            # 打开摄像头
            self.cap = cv2.VideoCapture(camera_num)
            # 判断摄像头是否处于打开状态
            bool_open = self.cap.isOpened()
            if not bool_open:
                QtWidgets.QMessageBox.warning(self, u"Warning", u"打开摄像头失败", buttons=QtWidgets.QMessageBox.Ok,
                                              defaultButton=QtWidgets.QMessageBox.Ok)
            else:
                fps, w, h, save_path = self.set_video_name_and_path()
                fps = 5 # 控制摄像头检测下的fps
                self.vid_writer = cv2.VideoWriter(save_path, cv2.VideoWriter_fourcc(*'mp4v'), fps, (w, h))

                #todo : 摄像头检测 开启计时器
                self.timer_video.start(30)
                self.ui.pushButton_video.setDisabled(True)
                self.ui.pushButton_img.setDisabled(True)
                self.ui.pushButton_camer.setDisabled(True)
        else:
            QtWidgets.QMessageBox.warning(self, u"Warning", u"请先加载模型", buttons=QtWidgets.QMessageBox.Ok,
                                          defaultButton=QtWidgets.QMessageBox.Ok)

    # 定义视频帧显示操作
    def show_video_frame(self):
        name_list = []
        flag, img = self.cap.read()
        if img is not None:
            info_show = self.detect(name_list, img) # 检测结果写入到原始img上
            self.vid_writer.write(img) # 检测结果写入视频
            print(info_show)

            # 是否保存检测信息
            if self.ui.radioButton.isChecked() == True:
                info_fileName = now + '.txt'
                file_path = self.output_folder + 'video_output/detail_Info/' + info_fileName
                with open(file_path, 'a+') as f:
                    timenow = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
                    f.write(timenow)
                    f.write(': ')
                    f.write(info_show)


            # 检测信息显示在界面
            #self.ui.textBrowser.setText(info_show)
            self.analyzeInfo(info_show)

            show = cv2.resize(img, (640, 480)) # 直接将原始img上的检测结果进行显示
            self.result = cv2.cvtColor(show, cv2.COLOR_BGR2RGB)
            showImage = QtGui.QImage(self.result.data, self.result.shape[1], self.result.shape[0],
                                     QtGui.QImage.Format_RGB888)
            self.ui.label.setPixmap(QtGui.QPixmap.fromImage(showImage))
            self.ui.label.setScaledContents(True)  # 设置图像自适应界面大小

        else:
            self.timer_video.stop()
            # 读写结束，释放资源
            self.cap.release() # 释放video_capture资源
            self.vid_writer.release() # 释放video_writer资源
            self.ui.label.clear()
            # 视频帧显示期间，禁用其他检测按键功能
            self.ui.pushButton_video.setDisabled(False)
            self.ui.pushButton_img.setDisabled(False)
            self.ui.pushButton_camer.setDisabled(False)

    # 暂停与继续检测
    def button_video_stop(self):
        self.timer_video.blockSignals(False)
        # 暂停检测
        # 若QTimer已经触发，且激活
        if self.timer_video.isActive() == True and self.num_stop%2 == 1:
            self.ui.pushButton_stop.setText(u'暂停检测') # 当前状态为暂停状态
            self.num_stop = self.num_stop + 1 # 调整标记信号为偶数
            self.timer_video.blockSignals(True)
        # 继续检测
        else:
            self.num_stop = self.num_stop + 1
            self.ui.pushButton_stop.setText(u'继续检测')

    # 结束视频检测
    def finish_detect(self):
        # self.timer_video.stop()
        self.cap.release()  # 释放video_capture资源
        self.vid_writer.release()  # 释放video_writer资源
        self.ui.label.clear() # 清空label画布
        # 启动其他检测按键功能
        self.ui.pushButton_video.setDisabled(False)
        self.ui.pushButton_img.setDisabled(False)
        self.ui.pushButton_camer.setDisabled(False)

        # 结束检测时，查看暂停功能是否复位，将暂停功能恢复至初始状态
        # Note:点击暂停之后，num_stop为偶数状态
        if self.num_stop%2 == 0:
            print("Reset stop/begin!")
            self.ui.pushButton_stop.setText(u'暂停/继续')
            self.num_stop = self.num_stop + 1
            self.timer_video.blockSignals(False)

    def open_output(self):
        start_directory = r'./output'
        os.system('open ./output')

    def analyze(self):
        analyzeStr = '共检测图片文件 ，视频文件 ，'
        self.subWindow = win_calanda()
        #self.subWindow.
        self.subWindow.show()

    # todo : 重写关闭事件
    def closeEvent(self, event):

        self.info_box(value='等待系统保存中', title='关闭程序')

        # msgBox = QtWidgets.QMessageBox()
        # msgBox.warning(self, u"Warning", u"等待系统保存中", buttons=QtWidgets.QMessageBox.Ok,
        #                               defaultButton=QtWidgets.QMessageBox.Ok)
        # #tWidgets.QMessageBox.warning(self, u"Warning", u"等待系统保存中", buttons=QtWidgets.QMessageBox.Ok,
        #                              # defaultButton=QtWidgets.QMessageBox.Ok)
        # msgBox.button(QMessageBox.Ok).animateClick(1000 * 2)
        # msgBox.exec()


    # def url_button_detect(self):
    #     print("[URL][Text]:", self.ui.lineEdit_url.text())
    #     tempStr = 'python detect.py --source ' + self.ui.lineEdit_url.text()
    #     print(tempStr)
    #     os.system(tempStr)
    def info_box(self, value='123', title='信息', widget=None, delay=1.5):
        """
        消息盒子
        :param value: 显示的信息内容
        :param title: 弹窗的标题
        :param widget: 父窗口
        :param delay: 弹窗默认关闭时间， 单位：秒
        """
        msgBox = QMessageBox(parent=widget)

        # 设置信息内容使用字体
        font = QtGui.QFont()
        font.setPointSize(16)
        font.setBold(True)
        font.setWeight(200)
        msgBox.setFont(font)

        msgBox.setWindowTitle(title)
        msgBox.setText(value)
        msgBox.setStandardButtons( QMessageBox.Cancel | QMessageBox.Ok)
        msgBox.setDefaultButton(QMessageBox.Ok)
        # 设置 QMessageBox 自动关闭时长
        msgBox.button(QMessageBox.Ok).animateClick(1000 * delay)
        msgBox.exec()

if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    current_ui = UI_Logic_Window()
    current_ui.show()
    sys.exit(app.exec_())