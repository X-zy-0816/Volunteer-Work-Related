# -*- coding: utf-8 -*-
# @Modified by: Ruihao
# @ProjectName:yolov5-pyqt5
import re
import sys
from datetime import datetime

from PyQt5 import QtWidgets
from PyQt5 import QtCore
from PyQt5.QtGui import QPixmap
from PyQt5.QtWidgets import *
from utils.id_utils import get_id_info, sava_id_info # 账号信息工具函数
from lib.share import * # 公共变量名
from captcha.image import ImageCaptcha # 验证码模块
import string, random
import socket

# 导入QT-Design生成的UI
from UI.login_ui import Ui_Form
from UI.register_ui import Ui_Dialog
from Mysql.dbmysql import DB_Mysql
# 导入设计好的检测界面
from detect_logical import UI_Logic_Window
from detect_online import UI_Online_Window

"""
    QtDesigner  /Users/xuzhiyuan/opt/miniconda3/envs/yolo5/lib/python3.8/site-packages/qt5_applications/Qt/bin/Designer.app
    
    pyuic5      cd /Users/xuzhiyuan/opt/miniconda3/envs/yolo5/bin/
                ./pyuic5 -o ~/Desktop/detect_ui.py ~/Desktop/detect_ui.ui 
"""

# 界面登录
class win_Login(QMainWindow):
    def __init__(self, parent = None):
        super(win_Login, self).__init__(parent)
        self.ui_login = Ui_Form()
        self.ui_login.setupUi(self)
        self.init_slots()
        self.hidden_pwd()
        self.chars = ''
        self.setVerify()
        self.conn = DB_Mysql('127.0.0.1', 3306, 'root', 'ilyzy081610', 'yolo_DataBase')


    #验证码生成
    def setVerify(self):
        # 实例化
        img = ImageCaptcha()
        # 生成字母和数字
        lettersAndNumbers = string.ascii_letters + string.digits

        # 随机选择4个字符生产验证码
        self.chars = ''.join(random.sample(lettersAndNumbers, k=4))
        # 随机颜色,color和background是接受rgb(0,0,0)这样的参数的
        # 所以可以使用random生成即可
        rgb = (random.randint(0, 256), random.randint(0,256), random.randint(0, 256))
        b_rgb = (random.randint(0,256), random.randint(0,256), random.randint(0, 256))
        im = img.create_captcha_image(chars=self.chars, color=rgb, background=b_rgb)
        # 图片保存的路径
        path = r'UI/UI_Resource/' + 'varify' + '.png'
        im.save(path)
        self.ui_login.label.setPixmap(QPixmap(path))
        self.ui_login.label.setScaledContents(True)  # 设置图像自适应界面大小

    # 密码输入框隐藏
    def hidden_pwd(self):
        self.ui_login.edit_password.setEchoMode(QLineEdit.Password)

    # 绑定信号槽
    def init_slots(self):
        self.ui_login.btn_login.clicked.connect(self.onSignIn) # 点击按钮登录
        self.ui_login.edit_password.returnPressed.connect(self.onSignIn) # 按下回车登录
        self.ui_login.btn_regeist.clicked.connect(self.create_id)
        self.ui_login.btn_regeist_2.clicked.connect(self.setVerify)

    # 跳转到注册界面
    def create_id(self):
        shareInfo.createWin = win_Register()
        shareInfo.createWin.show()

    # 保存登录日志
    def sava_login_log(self, username):
        with open('login_log.txt', 'r+', encoding='utf-8') as f:
            f.write(username + '\t log in at' + datetime.now().strftimestrftime+ '\r')

    # 登录
    def onSignIn(self):
        print("[Main][Window]:Sign In Button")
        # 从登陆界面获得输入账户名与密码
        username = self.ui_login.edit_username.text().strip()
        password = self.ui_login.edit_password.text().strip()
        # print(self.chars)
        # print(self.ui_login.edit_password_verify.text().strip())
        # print(re.search(self.chars, self.ui_login.edit_password_verify.text().strip(), re.IGNORECASE))
        # 获得账号信息
        USER_PWD = get_id_info()
        # print(USER_PWD)
        if username not in USER_PWD.keys():
            replay = QMessageBox.warning(self,"登陆失败!", "账号或密码输入错误", QMessageBox.Yes)
        else:
            # 若登陆成功，则跳转主界面
            if USER_PWD.get(username) == password:
                if re.search(self.chars, self.ui_login.edit_password_verify.text().strip(), re.IGNORECASE) == None:
                    #print(self.chars)
                    #print(self.ui_login.edit_password_verify.text().strip())
                    self.ui_login.edit_password_verify.clear()
                    QMessageBox.warning(self, "!", "验证码错误", QMessageBox.Yes)

                    return
                print("[Main][Window]:Jump to main window")

                #登陆服务器端
                if self.ui_login.checkBox_Online.checkState() == QtCore.Qt.Checked:
                    fileWrite(username)
                    shareInfo.mainWin = UI_Online_Window()
                    shareInfo.mainWin.show()
                    hostname = socket.gethostname()
                    ip = socket.gethostbyname(hostname)
                    returnAns = self.conn.insert(table="loginInfo", userId=username, isOnline = 1, ipAddress=ip, currentState='在线')
                    if returnAns == None:
                        whereStr = 'userId=' + str(username)

                        self.conn.update(table='loginInfo', isOnline=1, ipAddress=ip, currentState='在线', where=whereStr)

                #登陆本地端
                else:
                    shareInfo.mainWin = UI_Logic_Window()
                    shareInfo.mainWin.show()
                    returnAns = self.conn.insert(table="loginInfo", userId=username, isOnline = 0, ipAddress='本地登陆', currentState='本地登陆')
                    if returnAns == None:
                        whereStr = 'userId=' + str(username)
                        self.conn.update(table = 'loginInfo', isOnline=0, ipAddress='本地登陆', currentState='本地登陆', where=whereStr)
                        fileWrite(username)
                # 关闭当前窗口
                self.close()
            else:
                replay = QMessageBox.warning(self, "!", "账号或密码输入错误", QMessageBox.Yes)

# 注册界面
class win_Register(QDialog):
    def __init__(self, parent = None):
        super(win_Register, self).__init__(parent)
        self.ui_register = Ui_Dialog()
        self.ui_register.setupUi(self)
        self.init_slots()
        self.chars = ''
        self.setVerify()
        self.conn = DB_Mysql('127.0.0.1', 3306, 'root', 'ilyzy081610', 'yolo_DataBase')

    # 绑定槽信号
    def init_slots(self):
        self.ui_register.pushButton_regiser.clicked.connect(self.new_account)
        self.ui_register.pushButton_cancer.clicked.connect(self.cancel)
        self.ui_register.pushButton_verify.clicked.connect(self.setVerify)

    # 创建新账户
    def new_account(self):
        print("Create new account")
        USER_PWD = get_id_info()
        # print(USER_PWD)
        new_username = self.ui_register.edit_username.text().strip()
        new_password = self.ui_register.edit_password.text().strip()
        # 判断用户名是否为空
        if new_username == "":
            replay = QMessageBox.warning(self, "!", "账号不准为空", QMessageBox.Yes)
        else:
            # 判断账号是否存在
            if new_username in USER_PWD.keys():
                replay = QMessageBox.warning(self, "!", "账号已存在", QMessageBox.Yes)
            else:
                # 判断密码是否为空
                if new_password == "":
                    replay = QMessageBox.warning(self, "!", "密码不能为空", QMessageBox.Yes)
                else:
                    # 注册成功
                    if re.search(self.chars, self.ui_register.edit_verify.text().strip(), re.IGNORECASE) == None:
                        # print(self.chars)
                        # print(self.ui_login.edit_password_verify.text().strip())
                        self.ui_register.edit_verify.clear()
                        QMessageBox.warning(self, "!", "验证码错误", QMessageBox.Yes)

                        return

                    print("Successful!")
                    sava_id_info(new_username, new_password)
                    replay = QMessageBox.information(self,  "!", "注册成功！", QMessageBox.Yes)
                    self.conn.insert(table="userInfo", userId=new_username, userPassword=new_password)
                    # 关闭界面
                    self.close()

    # 验证码生成
    def setVerify(self):
        # 实例化
        img = ImageCaptcha()
        # 生成字母和数字
        lettersAndNumbers = string.ascii_letters + string.digits

        # 随机选择4个字符生产验证码
        self.chars = ''.join(random.sample(lettersAndNumbers, k=4))
        # 随机颜色
        # 使用random生成
        rgb = (random.randint(0, 256), random.randint(0, 256), random.randint(0, 256))
        b_rgb = (random.randint(0, 256), random.randint(0, 256), random.randint(0, 256))
        im = img.create_captcha_image(chars=self.chars, color=rgb, background=b_rgb)
        # 图片保存的路径
        path = r'UI/UI_Resource/' + 'varify_register' + '.png'
        im.save(path)
        self.ui_register.label_verify.setPixmap(QPixmap(path))
        self.ui_register.label_verify.setScaledContents(True)  # 设置图像自适应界面大小


    # 取消注册
    def cancel(self):
        self.close() # 关闭当前界面

# def fileWrite(id = '', state = ''):
#     file_handle = open('./lib/1.txt', mode='w+')
#     file_handle.write(id + '\n')
#     file_handle.write(state)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    # 利用共享变量名来实例化对象
    shareInfo.loginWin = win_Login() # 登录界面作为主界面
    shareInfo.loginWin.show()
    sys.exit(app.exec_())
