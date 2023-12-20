#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   detect_online.py    
@Contact :   996852067@qq.com
@License :   (C)Copyright 2020-2021

@Modify Time           @Author    @Version    @Desciption
------------           -------    --------    -----------
2022/5/4 下午6:45   xuzhiyuan     1.0         云端检测识别
'''

import sys
import cv2
import time


from lib.share import * # 公共变量名

from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import *
from Mysql.dbmysql import DB_Mysql
from TCPNet.TCPConnetion import TCPConnection

from UI.detect_ui_Online import Ui_MainWindow_Online

# 服务端ip地址
HOST = '127.0.0.1'
# 服务端端口号
PORT = 8888
ADDRESS = (HOST, PORT)

class UI_Online_Window(QtWidgets.QMainWindow):
    #初始化
    def __init__(self, parent=None):
        super(UI_Online_Window, self).__init__(parent)
        self.ui = Ui_MainWindow_Online()
        self.ui.setupUi(self)
        self.timer_video = QtCore.QTimer()  # 创建定时器
        self.init_slots()
        self.cap = cv2.VideoCapture()
        self.tcpConnection = TCPConnection()
        self.id = fileRead()
        self.flag = 0

        self.ui.label.setStyleSheet("background-color:transparent;background-image:url(./UI/UI_Resource/Footer_Logo.png);background-position:center;background-repeat:no-repeat;");

    #信号与槽
    def init_slots(self):
        self.ui.pushButton_connectServer.clicked.connect(self.connectServer)
        self.ui.pushButton_img.clicked.connect(self.selectImage)
        self.ui.pushButton_modelInit.clicked.connect(self.initModel)
        self.ui.pushButton_video.clicked.connect(self.selectVideo)
        self.timer_video.timeout.connect(self.OpenFrame)


    def connectServer(self):

        self.tcpConnection.connect()
        if self.tcpConnection.flag == 0:
            #Offline
            #设置checkbox
            self.ui.checkBox_Offline.setEnabled(True)
            self.ui.checkBox_Online.setChecked(False)
            self.ui.checkBox_Online.setEnabled(False)
            self.ui.checkBox_Offline.setCheckable(True)
            self.ui.checkBox_Offline.setChecked(True)

            #设置button
            self.ui.pushButton_img.setEnabled(False)
            self.ui.pushButton_video.setEnabled(False)
            self.ui.pushButton_modelInit.setEnabled(False)

        else:
            #Online
            # 设置checkbox
            self.ui.checkBox_Online.setEnabled(True)
            self.ui.checkBox_Offline.setEnabled(False)
            self.ui.checkBox_Offline.setChecked(False)
            self.ui.checkBox_Online.setCheckable(True)
            self.ui.checkBox_Online.setChecked(True)

            # 设置button
            self.ui.pushButton_img.setEnabled(True)
            self.ui.pushButton_video.setEnabled(True)
            self.ui.pushButton_modelInit.setEnabled(True)

    def selectImage(self):

        if self.tcpConnection.flag != 0:
            if self.flag == 0:
                QtWidgets.QMessageBox.warning(self, u"Warning", u"请先初始化服务器模型", buttons=QtWidgets.QMessageBox.Ok,
                                              defaultButton=QtWidgets.QMessageBox.Ok)
                return
            name_list = []
            try:
                print('[Online][Image]:Button clicked')
                img_name, _ = QtWidgets.QFileDialog.getOpenFileName(self, "打开图片", "data/images",
                                                                    "*.jpg;;*.png;;All Files(*)")
                print('[Online][Image][Path]:', img_name)
            except OSError as reason:
                print('[Online][Image]:' + str(reason))
            else:
                # 判断图片是否为空
                if not img_name:
                    QtWidgets.QMessageBox.warning(self, u"Warning", u"打开图片失败", buttons=QtWidgets.QMessageBox.Ok,
                                                  defaultButton=QtWidgets.QMessageBox.Ok)
                # 发送图片至服务器
                else:
                    self.tcpConnection.sendImage(img_name)
                    self.tcpConnection.dealWithMsgFlag()

                    # 检测结果显示在界面
                    img = cv2.imread('./input/img_input/img.jpg')
                    self.result = cv2.cvtColor(img, cv2.COLOR_BGR2BGRA)
                    self.result = cv2.resize(self.result, (640, 480), interpolation=cv2.INTER_AREA)
                    self.QtImg = QtGui.QImage(self.result.data, self.result.shape[1], self.result.shape[0],
                                              QtGui.QImage.Format_RGB32)
                    self.ui.label.setPixmap(QtGui.QPixmap.fromImage(self.QtImg))
                    self.ui.label.setScaledContents(True)  # 设置图像自适应界面大小
                    self.ui.textBrowser.setText(self.tcpConnection.INFO)

        else:
            print('[Online][Image]:Server Offline, Please connect to server first')
            QtWidgets.QMessageBox.warning(self, u"Warning", u"请先连接服务器", buttons=QtWidgets.QMessageBox.Ok,
                                          defaultButton=QtWidgets.QMessageBox.Ok)

    def selectVideo(self):
        if self.tcpConnection.flag != 0:
            if self.flag == 0:
                QtWidgets.QMessageBox.warning(self, u"Warning", u"请先初始化服务器模型", buttons=QtWidgets.QMessageBox.Ok,
                                              defaultButton=QtWidgets.QMessageBox.Ok)
                return
            video_name, _ = QtWidgets.QFileDialog.getOpenFileName(self, "打开视频", "data/", "*.mp4;;*.avi;;All Files(*)")
            flag = self.cap.open(video_name)
            if not flag:
                QtWidgets.QMessageBox.warning(self, u"Warning", u"打开视频失败", buttons=QtWidgets.QMessageBox.Ok,
                                              defaultButton=QtWidgets.QMessageBox.Ok)
            else:
                #发送视频
                self.tcpConnection.sendVideo(video_name)
                time.sleep(8)
                self.tcpConnection.dealWithMsgFlag()
                #'input/video_input/video.mp4'
                self.cap.open('input/video_input/video.mp4')
                self.timer_video.start(50)

                #显示在label上面


                # self.timer_video.start(30)  # 以30ms为间隔，启动或重启定时器
                # # 进行视频识别时，关闭其他按键点击功能
                # self.ui.pushButton_video.setDisabled(True)
                # self.ui.pushButton_img.setDisabled(True)
                # self.ui.pushButton_camer.setDisabled(True)

        else:
            print('[Online][Image]:Server Offline, Please connect to server first')
            QtWidgets.QMessageBox.warning(self, u"Warning", u"请先连接服务器", buttons=QtWidgets.QMessageBox.Ok,
                                        defaultButton=QtWidgets.QMessageBox.Ok)

    def OpenFrame(self):
        ret, image = self.cap.read()
        if image is not None:
            show = cv2.resize(image, (640, 480))  # 直接将原始img上的检测结果进行显示
            self.result = cv2.cvtColor(show, cv2.COLOR_BGR2RGB)
            showImage = QtGui.QImage(self.result.data, self.result.shape[1], self.result.shape[0],
                                     QtGui.QImage.Format_RGB888)
            self.ui.label.setPixmap(QtGui.QPixmap.fromImage(showImage))
            self.ui.label.setScaledContents(True)  # 设置图像自适应界面大小
        else:
            self.cap.release()
            self.timer_video.stop()

    def selectCamera(self):
        if self.tcpConnection.flag != 0:
            print("[Online][Camera]:Open camera to detect")
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
                fps = 5  # 控制摄像头检测下的fps，Note：保存的视频，播放速度有点快，我只是粗暴的调整了FPS
                self.vid_writer = cv2.VideoWriter(save_path, cv2.VideoWriter_fourcc(*'mp4v'), fps, (w, h))
                self.timer_video.start(30)
                self.ui.pushButton_video.setDisabled(True)
                self.ui.pushButton_img.setDisabled(True)
                self.ui.pushButton_camer.setDisabled(True)
        else:
            print('[Online][Camera]:Server Offline, Please connect to server first')
            QtWidgets.QMessageBox.warning(self, u"Warning", u"请先连接服务器", buttons=QtWidgets.QMessageBox.Ok,
                                          defaultButton=QtWidgets.QMessageBox.Ok)

    def initModel(self):
        if self.tcpConnection.flag != 0: #离线状态
            self.tcpConnection.initModel()
            self.flag = 1
            QtWidgets.QMessageBox.information(self, u"Warning", u"服务器模型初始化完成", buttons=QtWidgets.QMessageBox.Ok,
                                          defaultButton=QtWidgets.QMessageBox.Ok)
        else:
            print('[Online][Camera]:Server Offline, Please connect to server first')
            QtWidgets.QMessageBox.warning(self, u"Warning", u"请先连接服务器", buttons=QtWidgets.QMessageBox.Ok,
                                          defaultButton=QtWidgets.QMessageBox.Ok)

    # todo : 重写关闭事件
    def closeEvent(self, event):
        self.conn = DB_Mysql('127.0.0.1', 3306, 'root', 'ilyzy081610', 'yolo_DataBase')
        whereStr = 'currentState=' + '\'在线\'' + ' and ' + 'userId=' + str(self.id)
        self.conn.update(table='loginInfo', userId=int(self.id), isOnline=1, currentState = '离线', where=whereStr)
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
        msgBox.setStandardButtons(QMessageBox.Cancel | QMessageBox.Ok)
        msgBox.setDefaultButton(QMessageBox.Ok)
        # 设置 QMessageBox 自动关闭时长
        msgBox.button(QMessageBox.Ok).animateClick(1000 * delay)
        msgBox.exec()

    def set_video_name_and_path(self):
        # 获取当前系统时间，作为img和video的文件名
        now = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
        # if vid_cap:  # video
        fps = self.cap.get(cv2.CAP_PROP_FPS)
        w = int(self.cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        h = int(self.cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
        # 视频检测结果存储位置
        save_path = self.output_folder + 'video_output/' + now + '.mp4'
        return fps, w, h, save_path


if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    current_ui = UI_Online_Window()
    current_ui.show()
    sys.exit(app.exec_())
