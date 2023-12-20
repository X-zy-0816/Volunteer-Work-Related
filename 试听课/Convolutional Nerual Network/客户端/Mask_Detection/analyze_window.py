import sys
import os
import re
import cv2

from PyQt5.QtCore import QDate
from UI.analyze_ui import Ui_Form_Analyze
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import *
from PyQt5.QtGui import  QStandardItemModel,QStandardItem
from Mysql.dbmysql import DB_Mysql



class win_calanda(QtWidgets.QMainWindow):
    def __init__(self, parent = None):
        super(win_calanda, self).__init__(parent)
        self.ui = Ui_Form_Analyze()
        self.ui.setupUi(self)
        self.ui.calendarWidget.clicked[QDate].connect(self.showData)
        self.conn = DB_Mysql('127.0.0.1', 3306, 'root', 'ilyzy081610', 'yolo_DataBase')


    def showData(self):
        data = self.ui.calendarWidget.selectedDate()
        year = data.year()
        month = data.month()
        day = data.day()

        # 处理month
        dealMonth = ''
        if month < 10:
            dealMonth = '0' + str(month)
        else:
            dealMonth = str(month)

        #处理day
        dealDay = ''
        if day < 10:
            dealDay = '0' + str(day)
        else:
            dealDay = str(day)

        #拼接匹配串
        selectStr = str(year) + '-' + dealMonth + '-' + dealDay

        imageDirPath = 'output/img_output'
        detailDirPath = 'output/img_output/detail_Info/'

        #处理图片信息
        count = 0
        if os.path.exists(imageDirPath):
            dirs = os.listdir(imageDirPath)
            for dirc in dirs:
                if re.match(selectStr, dirc) != None :
                    count += 1
            print('image match count', count)

        else:
            print("dir not exists")

        #处理detail信息
        allNum = 0
        maskNum = 0
        nomaskNum = 0
        maskStr = 'mask'
        nomaskStr = 'no-mask'
        temp_db_use = ''
        if os.path.exists(detailDirPath):
            dirs = os.listdir(detailDirPath)
            for dirc in dirs:
                if re.match(selectStr, dirc) != None:
                    temp_db_use = dirc
                    temp_db_use = temp_db_use.replace(".txt", '.jpg')
                    temp_db_peopleCount = 0
                    temp_db_maskCount = 0
                    temp_db_nomaskCount = 0
                    print("--------", temp_db_use)
                    dirc = 'output/img_output/detail_Info/' + dirc
                    with open(dirc, 'r') as f:
                        for content in f.readlines():
                            info = str(content)
                            #print(info)
                            if info.find(maskStr) != -1:
                                allNum += 1
                                temp_db_peopleCount += 1
                            if info.find(nomaskStr) != -1:
                                nomaskNum += 1
                                temp_db_nomaskCount += 1
                    self.conn.insert(table="imageDecInfo", imageName=temp_db_use, peopleCount=temp_db_peopleCount, maskCount=temp_db_peopleCount - temp_db_nomaskCount,
                                                 nomaskCount=temp_db_nomaskCount)
        else:
            print("dir not exists")
        maskNum = allNum - nomaskNum
        #print(allNum, maskNum, nomaskNum)

        STR = '           图片检测信息      共' + str(count) + "个图片文件"
        self.ui.label.setText(STR)

        #4行2列
        self.model = QStandardItemModel(1, 4)
        ##
        self.model.setHorizontalHeaderLabels(['检测图片数量', '检测人数', '佩戴口罩人数', '未佩戴口罩人数'])
        self.model.setItem(0, 0, QtGui.QStandardItem(str(count)))
        self.model.setItem(0, 1, QtGui.QStandardItem(str(allNum)))
        self.model.setItem(0, 2, QtGui.QStandardItem(str(maskNum)))
        self.model.setItem(0, 3, QtGui.QStandardItem(str(nomaskNum)))
        self.ui.tableView_image.setModel(self.model)
        # #todo 优化1 表格填满窗口
        # #水平方向标签拓展剩下的窗口部分，填满表格
        self.ui.tableView_image.horizontalHeader().setStretchLastSection(True)
        # #水平方向，表格大小拓展到适当的尺寸
        self.ui.tableView_image.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)


        #todo 数据库添加



        #self.model.item(0, 0).setForeground(QtGui.QBrush(QtGui.QColor(255, 0, 0)))
        #self.model.item(0, 0).setFont(QtGui.QFont("Times", 10, QtGui.QFont.Black))
        #self.model.item(, 1).setBackground(QtGui.QBrush(QtGui.QColor(255, 255, 0)))

        #///// video part
        videoDirPath = 'output/video_output'


        # 处理视频信息

        self.model = QStandardItemModel(1, 3)
        ##
        self.model.setHorizontalHeaderLabels(['视频名称', '视频时长', '视频大小'])

        count = 0
        if os.path.exists(videoDirPath):
            dirs = os.listdir(videoDirPath)
            for dirc in dirs:
                temp_db_use = dirc
                if re.match(selectStr, dirc) != None:
                    self.model.setItem(count, 0, QtGui.QStandardItem(str(dirc)))
                    dirc = 'output/video_output/' + dirc
                    #print(dirc)
                    length = str(video_duration_3(dirc) + 's')
                    size = getDocSize(dirc)
                    self.conn.insert(table="videoDecInfo", videoName=temp_db_use, videoSize=size, videoLength=length)
                    self.model.setItem(count, 1, QtGui.QStandardItem(str(video_duration_3(dirc) + ' 秒')))
                    self.model.setItem(count, 2, QtGui.QStandardItem(str(getDocSize(dirc))))
                    count += 1
            print('video match file', count)
        else:
            print("dir not exists")
        STR = '           视频检测信息      共' + str(count) + "个视频文件"
        self.ui.label_2.setText(STR)
        self.ui.tableView_image_2.setModel(self.model)
        # #todo 优化1 表格填满窗口
        # #水平方向标签拓展剩下的窗口部分，填满表格
        self.ui.tableView_image_2.horizontalHeader().setStretchLastSection(True)
        # #水平方向，表格大小拓展到适当的尺寸
        self.ui.tableView_image_2.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)

        #周三 5月 11 2022
        #2022 - 05 - 10 - 18 - 15 - 05
        print('data selected is', selectStr)

    def showWindow(self):
        self.ui.show()

def video_duration_3(filename):
    cap = cv2.VideoCapture(filename)
    if cap.isOpened():
        rate = cap.get(5)
        frame_num = cap.get(7)
        duration = frame_num / rate
        duration = format(duration,'.2f')
        return duration
    return -1


def formatSize(bytes):
    try:
        bytes = float(bytes)
        kb = bytes / 1024
    except:
        print("传入的字节格式不对")
        return "Error"

    if kb >= 1024:
        M = kb / 1024
        if M >= 1024:
            G = M / 1024
            return "%.4f G" % (G)
        else:
            return "%.4f M" % (M)
    else:
        return "%.4f kb" % (kb)


# 获取文件大小
def getDocSize(path):
    try:
        size = os.path.getsize(path)
        return formatSize(size)
    except Exception as err:
        print(err)


# 获取文件夹大小
def getFileSize(path):
    sumsize = 0
    try:
        filename = os.walk(path)
        for root, dirs, files in filename:
            for fle in files:
                size = os.path.getsize(path + fle)
                sumsize += size
        return formatSize(sumsize)
    except Exception as err:
        print(err)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    # 利用共享变量名来实例化对象
    loginWin = win_calanda() # 登录界面作为主界面
    loginWin.show()
    sys.exit(app.exec_())
