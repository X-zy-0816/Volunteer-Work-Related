# -*- coding: utf-8 -*-
# @Author  : Ruihao
# @ProjectName:yolov5-pyqt5

class shareInfo:
    '''
    存取公用的界面名 # 参考自白月黑羽 www.python3.vip
    '''
    mainWin = None
    loginWin = None
    createWin = None

def fileWrite(id = 0):
    file_handle = open('./lib/1.txt', mode='w+')
    file_handle.write(str(id) + '\n')

def fileRead():
    file_handle = open('./lib/1.txt', mode='r+')
    id = file_handle.read()
    return id