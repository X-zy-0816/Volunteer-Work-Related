import socketserver
import os
import sys
import time
import threading

ip_port = ("127.0.0.1", 8888)


class MyServer(socketserver.BaseRequestHandler):
    def handle(self):
        print("conn is :", self.request)  # conn
        print("addr is :", self.client_address)  # addr

        while True:
            # 请求图片数据大小
            self.str = self.request.recv(4)
            data = bytearray(self.str)
            allLen = int.from_bytes(data, byteorder='little')
            print("Image Size", allLen)

            # 包拼接
            curSize = 0
            allData = b''
            while curSize < allLen:
                data = self.request.recv(1024)
                allData += data
                curSize += len(data)

            print("recv data len is ", len(allData))

            imgData = allData
            strImgFile = "2.jpg"
            print("img file name is ", strImgFile)

            # 将图片数据保存到本地文件
            with open(strImgFile, 'wb') as f:
                f.write(imgData)
                f.close()


if __name__ == "__main__":
    s = socketserver.ThreadingTCPServer(ip_port, MyServer)
    print("Server Running")
    s.serve_forever()

