import sys
import cv2
import time
import socket


HOST = '127.0.0.1' # 服务端ip地址
PORT = 8888  # 服务端端口号
ADDRESS = (HOST, PORT)
MSG_FLAG = 0

class TCPConnection():
    def __init__(self):
        self.TCPSocket = None
        self.flag = 0
        self.INFO = ''

    def connect(self):
        #创建套接字
        self.TCPSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            self.flag = self.TCPSocket.connect(ADDRESS)
        except Exception as e:
            print(e)
            self.flag = 0

        if self.flag == 0:
            print('[TCPServer][Connect]:Error')
        else:
            print('[TCPServer][Connect]:Success')

    '''
    @function: 处理不同类型数据，任务分派
    '''
    def dealWithMsgFlag(self):

        MSGFLAG = self.TCPSocket.recv(4)
        msg_flag = bytearray(MSGFLAG)
        message = int.from_bytes(msg_flag, byteorder='little')
        if message == 0: return
        print('[Server][MessageFlag]:', message);

        if message == 1:
            self.recvImage()
        elif message == 2:
            self.recvVideo()



    def sendImage(self, imagePath):
        start = time.perf_counter()

        # 以二进制方式读取图片

        picData = open(imagePath, 'rb')
        picBytes = picData.read()
        picSize = len(picBytes)
        arrBuf = bytearray(picSize.to_bytes(4, byteorder='little'))
        arrBuf += picBytes

        #发送标志
        global MSG_FLAG
        MSG_FLAG = 1
        print('[Server][MessageFlag]:',MSG_FLAG)
        self.TCPSocket.sendall(bytearray(MSG_FLAG.to_bytes(4, byteorder='little')))
        #发送图片
        self.TCPSocket.sendall(arrBuf)

        print("[Online][Image]:发送延时：" + str(int((time.perf_counter() - start) * 1000)) + "ms")

    def recvImage(self):
        #1. 整个包大小
        self.str = self.TCPSocket.recv(4)
        data = bytearray(self.str)
        allLen = int.from_bytes(data, byteorder='little')

        #2. 接整个包 包拼接
        curSize = 0
        allData = b''
        while curSize < allLen:
            data = self.TCPSocket.recv(1024)
            allData += data
            curSize += len(data)
        print("[Server][AllBag][Size]:", allLen)
        print('[Server][AllBag][Recv]:', len(allData))

        #3. 拆包 1. img size
        allLen = allData[0:3]
        size = bytearray(allLen)
        imgSize = int.from_bytes(size, byteorder='little')
        print("[Server][Image][Size]:", imgSize)

        #4. 取出图片部分
        imageData = allData[4:imgSize + 4]
        start = time.perf_counter()

        # 包拼接
        # curSize = 0
        # allData = b''
        # while curSize < allLen:
        #     data = self.TCPSocket.recv(1024)
        #     allData += data
        #     curSize += len(data)

        # """ 导致粘包
        #allData = self.TCPSocket.recv(allLen)

        #print("[Server][Image][Recv]:", len(allData))

        strImgFile = "./input/img_input/img.jpg"
        print("[Server][Image][Name]:", strImgFile)

        # 将图片数据保存到本地文件
        with open(strImgFile, 'wb') as f:
            f.write(imageData)
            print('[Server][Image][Save]:Done')
            f.close()


        #5. 读取信息大小
        allLen = allData[imgSize + 4:imgSize + 7]
        size = bytearray(allLen)
        infoSize = int.from_bytes(size, byteorder='little')
        print('[Server][Message][Size]:', infoSize)
        # 包拼接
        # curSize = 0
        # allData = b''
        # while curSize < infoSize:
        #     data = self.TCPSocket.recv(1024)
        #     allData += data
        #     curSize += len(data)
        # """ 粘包
        #self.INFO = self.TCPSocket.recv(infoSize)

        #6. 取出信息部分
        self.INFO =  allData[imgSize + 8:]
        print("[Server][Message][Recv]:", len(self.INFO))
        self.INFO = bytes.decode(self.INFO)


    def sendVideo(self, videoPath):

        #打开视频文件
        f = open(videoPath, 'rb')
        data = f.read()
        #发送文件
        videoSize = len(data)
        arrBuf = bytearray(videoSize.to_bytes(4, byteorder='little'))
        arrBuf += data
        #1. 发送标志位
        global MSG_FLAG
        MSG_FLAG = 2
        print('[Server][MessageFlag]:', MSG_FLAG)
        self.TCPSocket.sendall(bytearray(MSG_FLAG.to_bytes(4, byteorder='little')))
        #2. 发送数据包
        self.TCPSocket.sendall(arrBuf)

    def recvVideo(self):
        # 1. 整个包大小
        self.str = self.TCPSocket.recv(4)
        data = bytearray(self.str)
        allLen = int.from_bytes(data, byteorder='little')

        # 2. 接整个包 包拼接
        curSize = 0
        allData = b''
        while curSize < allLen:
            data = self.TCPSocket.recv(1024)
            allData += data
            curSize += len(data)
        print("[Server][AllBag][Size]:", allLen)
        print('[Server][AllBag][Recv]:', len(allData))


        strVideoFile = "./input/video_input/video.mp4"
        print("[Server][Video][Name]:", strVideoFile)

        # 将图片数据保存到本地文件
        with open(strVideoFile, 'wb') as f:
            f.write(allData)
            print('[Server][Video][Save]:Done')
            f.close()

    def close(self):
        self.TCPSocket.close()



    def initModel(self):
        flag = 3
        print('[Server][MessageFlag]:', flag)
        self.TCPSocket.sendall(bytearray(flag.to_bytes(4, byteorder='little')))



