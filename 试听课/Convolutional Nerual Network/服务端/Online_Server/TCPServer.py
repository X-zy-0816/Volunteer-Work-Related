import socketserver
import os
import sys
import threading
import os
import cv2
import time
import argparse
import random
import torch
import numpy as np
import torch.backends.cudnn as cudnn

from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import *

from utils.torch_utils import select_device
from models.experimental import attempt_load
from utils.general import check_img_size, non_max_suppression, scale_coords
from utils.datasets import letterbox
from utils.plots import plot_one_box2
from utils.datasets import LoadStreams

ip_port = ("127.0.0.1", 8888)
opt = None
device = None
half = None
model = None
names = None
colors = None

MSG_FLAG = 0

def initModel():
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
    global opt
    opt = parser.parse_args()
    print(opt)
    # 默认使用opt中的设置（权重等）来对模型进行初始化
    source, weights, view_img, save_txt, imgsz = opt.source, opt.weights, opt.view_img, opt.save_txt, opt.img_size
    global device
    global half
    device = select_device(opt.device)
    half = device.type != 'cpu'  # half precision only supported on CUDA
    cudnn.benchmark = True
    # Load model
    global model
    global names
    global colors
    model = attempt_load(weights, map_location=device)  # load FP32 model
    stride = int(model.stride.max())  # model stride
    imgsz = check_img_size(imgsz, s=stride)  # check img_size
    if half:
        model.half()  # to FP16
    # Get names and colors
    names = model.module.names if hasattr(model, 'module') else model.names
    colors = [[random.randint(0, 255) for _ in range(3)] for _ in names]
    print("[Yolo][Modle]:Init Success")


def detect(name_list, img):
    '''
    :param name_list: 文件名列表
    :param img: 待检测图片
    :return: info_show:检测输出的文字信息
    '''
    showimg = img
    with torch.no_grad():
        img = letterbox(img, new_shape=opt.img_size)[0]
        # Convert
        img = img[:, :, ::-1].transpose(2, 0, 1)  # BGR to RGB, to 3x416x416
        img = np.ascontiguousarray(img)
        img = torch.from_numpy(img).to(device)
        img = img.half() if half else img.float()  # uint8 to fp16/32
        img /= 255.0  # 0 - 255 to 0.0 - 1.0
        if img.ndimension() == 3:
            img = img.unsqueeze(0)
        # Inference
        pred = model(img, augment=opt.augment)[0]
        # Apply NMS
        pred = non_max_suppression(pred, opt.conf_thres, opt.iou_thres, classes=opt.classes,
                                   agnostic=opt.agnostic_nms)
        info_show = ""
        # Process detections
        for i, det in enumerate(pred):
            if det is not None and len(det):
                # Rescale boxes from img_size to im0 size
                det[:, :4] = scale_coords(img.shape[2:], det[:, :4], showimg.shape).round()
                for *xyxy, conf, cls in reversed(det):
                    label = '%s %.2f' % (names[int(cls)], conf)
                    name_list.append(names[int(cls)])
                    single_info = plot_one_box2(xyxy, showimg, label=label, color=colors[int(cls)],
                                                line_thickness=2)
                    # 返回检测信息
                    info_show = info_show + single_info + "\n"
    return info_show

class MyServer(socketserver.BaseRequestHandler):

    def handle(self):
        #print("conn is :", self.request)  # conn
        print("[Server][Connected]:Addr Is :", self.client_address)  # addr

        while True:
            # 请求收据类型
            self.MSG_FLAG = self.request.recv(4)
            self.msg_flag = bytearray(self.MSG_FLAG)
            message = int.from_bytes(self.msg_flag, byteorder='little')
            if message == 0 : return
            print('[Server][MessageFlag]:', message);

            if message == 1:
                self.dealImage()
            elif message == 2:
                self.dealVideo()
            elif message == 3:
                initModel()


    def dealImage(self):
        # 请求图片数据大小
        self.str = self.request.recv(4)
        data = bytearray(self.str)
        allLen = int.from_bytes(data, byteorder='little')
        #if allLen == 0: return

        print("[Image][Recv]:Pre Image Size", allLen)
        start = time.perf_counter()

        # 包拼接
        curSize = 0
        allData = b''
        while curSize < allLen:
            data = self.request.recv(1024)
            allData += data
            curSize += len(data)


        print("[Image][Recv]:Actual Recv Size", len(allData))

        imgData = allData
        strImgFile = "img.jpg"
        # print("img file name is ", strImgFile)

        # 将图片数据保存到本地文件
        with open(strImgFile, 'wb') as f:
            f.write(imgData)
            f.close()

            # 图片检测
            # os.system('python detect.py')
            file_name = os.path.abspath('img.jpg')
            name_list = []
            img = cv2.imread(file_name)
            print("[Image][Recv][Name]:", file_name)
            info_show = detect(name_list, img)
            # print(info_show)
            # 获取当前系统时间，作为img文件名
            now = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
            file_extension = file_name.split('.')[-1]
            new_filename = now + '.' + file_extension  # 获得文件后缀名
            file_path = 'Image_Output/' + new_filename
            cv2.imwrite(file_path, img)

            # 以二进制方式读取图片
            picData = open(file_path, 'rb')
            picBytes = picData.read()

            # 图片大小
            picSize = len(picBytes)

            # 信息发送
            infoSize = len(info_show)

            # 组合数据包

            #1. 发送标志位
            global MSG_FLAG
            MSG_FLAG= 1
            self.request.sendall(bytearray(MSG_FLAG.to_bytes(4, byteorder='little')))

            #2. 发送数据包
            arrBuf = bytearray(picSize.to_bytes(4, byteorder='little'))
            arrBuf += picBytes
            arrBuf += bytearray(infoSize.to_bytes(4, byteorder='little'))
            arrBuf += info_show.encode("utf-8")
            bagSize = len(arrBuf)
            bagBuf = bytearray(bagSize.to_bytes(4, byteorder='little'))
            bagBuf += arrBuf

            print('[Image][Size]:', picSize)
            print('[Image][Message][Size]:', infoSize)
            print('[Image][AllBag][Size]:', bagSize)

            self.request.sendall(bagBuf)
        print("[Online][Image]:处理延迟：" + str(int((time.perf_counter() - start) * 1000)) + "ms")

    def dealVideo(self):

        # 1. 请求视频文件大小
        str = self.request.recv(4)
        data = bytearray(str)
        videoSize = int.from_bytes(data, byteorder='little')
        print("[Video][Recv]:Pre Video Size", videoSize)

        # 2. 接受视频文件
        start = time.perf_counter()

        #      包拼接
        curSize = 0
        allData = b''
        while curSize < videoSize:
            data = self.request.recv(1024)
            allData += data
            curSize += len(data)
        print("[Video][Recv]:Actual Video Size", videoSize)

        # 3.保存视频文件
        strVideoFile = "Video.mp4"
        with open(strVideoFile, 'wb') as f:
            f.write(allData)
            f.close()


        os.system('python detect.py --source Video.mp4 --weights weights/Mask_Detect_S.pt --name ./ --project ./Video_Output')
        file_path = 'Video_Output/Video.mp4'

        # 以二进制方式读取视频
        picData = open(file_path, 'rb')
        picBytes = picData.read()
        # 视频大小
        picSize = len(picBytes)
        global MSG_FLAG
        MSG_FLAG = 2
        self.request.sendall(bytearray(MSG_FLAG.to_bytes(4, byteorder='little')))
        arrBuf = bytearray(picSize.to_bytes(4, byteorder='little'))
        arrBuf += picBytes
        print('[Video][Size]:', picSize)
        self.request.sendall(arrBuf)

        os.system('rm -rf ./Video_Output')


        # 4.识别视频
        if videoSize == 0:
            name_list = []
            flag, img = self.cap.read()
            if img is not None:
                info_show = self.detect(name_list, img)  # 检测结果写入到原始img上
                self.vid_writer.write(img)  # 检测结果写入视频
                print(info_show)
                # 检测信息显示在界面
                self.ui.textBrowser.setText(info_show)

                show = cv2.resize(img, (640, 480))
                self.result = cv2.cvtColor(show, cv2.COLOR_BGR2RGB)
                showImage = QtGui.QImage(self.result.data, self.result.shape[1], self.result.shape[0],
                                         QtGui.QImage.Format_RGB888)

            else:
                self.timer_video.stop()
                # 读写结束，释放资源
                self.cap.release()  # 释放video_capture资源
                self.vid_writer.release()  # 释放video_writer资源
                # 视频帧显示期间，禁用其他检测按键功能


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

def initModel():
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
    global opt
    opt = parser.parse_args()
    print(opt)
    # 默认使用opt中的设置（权重等）来对模型进行初始化
    source, weights, view_img, save_txt, imgsz = opt.source, opt.weights, opt.view_img, opt.save_txt, opt.img_size
    global device
    global half
    device = select_device(opt.device)
    half = device.type != 'cpu'  # half precision only supported on CUDA
    cudnn.benchmark = True
    # Load model
    global model
    global names
    global colors
    model = attempt_load(weights, map_location=device)  # load FP32 model
    stride = int(model.stride.max())  # model stride
    imgsz = check_img_size(imgsz, s=stride)  # check img_size
    if half:
        model.half()  # to FP16
    # Get names and colors
    names = model.module.names if hasattr(model, 'module') else model.names
    colors = [[random.randint(0, 255) for _ in range(3)] for _ in names]
    print("[Yolo][Modle]:Init Success")


def detect(name_list, img):
    '''
    :param name_list: 文件名列表
    :param img: 待检测图片
    :return: info_show:检测输出的文字信息
    '''
    showimg = img
    with torch.no_grad():
        img = letterbox(img, new_shape=opt.img_size)[0]
        # Convert
        img = img[:, :, ::-1].transpose(2, 0, 1)  # BGR to RGB, to 3x416x416
        img = np.ascontiguousarray(img)
        img = torch.from_numpy(img).to(device)
        img = img.half() if half else img.float()  # uint8 to fp16/32
        img /= 255.0  # 0 - 255 to 0.0 - 1.0
        if img.ndimension() == 3:
            img = img.unsqueeze(0)
        # Inference
        pred = model(img, augment=opt.augment)[0]
        # Apply NMS
        pred = non_max_suppression(pred, opt.conf_thres, opt.iou_thres, classes=opt.classes,
                                   agnostic=opt.agnostic_nms)
        info_show = ""
        # Process detections
        for i, det in enumerate(pred):
            if det is not None and len(det):
                # Rescale boxes from img_size to im0 size
                det[:, :4] = scale_coords(img.shape[2:], det[:, :4], showimg.shape).round()
                for *xyxy, conf, cls in reversed(det):
                    label = '%s %.2f' % (names[int(cls)], conf)
                    name_list.append(names[int(cls)])
                    single_info = plot_one_box2(xyxy, showimg, label=label, color=colors[int(cls)],
                                                line_thickness=2)
                    # 返回检测信息
                    info_show = info_show + single_info + "\n"
    return info_show


if __name__ == "__main__":
    #initModel()
    s = socketserver.ThreadingTCPServer(ip_port, MyServer)
    print("[Server]:Running")
    s.serve_forever()


