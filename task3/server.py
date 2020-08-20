import socket

HEADERSIZE = 10

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

s.bind((socket.gethostname(), 9999))
s.listen(1)
clientsocket, address = s.accept()
clientsocket.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, True)
# clientsocket.getsockopt()
print(f"Connection from {address} has been established.")

msg1 = "Hello!"
msg1 = f"{len(msg1):<{HEADERSIZE}}" + msg1

clientsocket.send(bytes(msg1, "utf-8"))
clientsocket.send(bytes(msg1, "utf-8"))
clientsocket.send(bytes(msg1, "utf-8"))
clientsocket.send(bytes(msg1, "utf-8"))

