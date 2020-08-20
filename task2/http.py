import socket
import time

host = "stackoverflow.com"

request = "GET / HTTP/1.1\r\nHost:%s\r\n\r\n" % host

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((host, 80))
s.send(request.encode())
result = s.recv(10)
len_ = 0
flag_for_sleep = 0
while (len(result) > 0):
    if flag_for_sleep == 2:
        time.sleep(20)

    flag_for_sleep += 1
    len_ += len(result)
    print(result)
    if len_ > 740:
        break
    result = s.recv(10)

s.close()