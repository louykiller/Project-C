import socket
import random


def gen_mic_values():
    value1 = random.randint(0, 500)
    value2 = random.randint(0, 500)
    return str(value1)+"_"+str(value2)


hostname = socket.gethostname()
local_ip = socket.gethostbyname(hostname)

ip = local_ip
port = 5005

# Create socket for server
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, 0)
print("Do Ctrl+c to exit the program !!")

# Let's send data through UDP protocol
while True:
    send_data = gen_mic_values()
    s.sendto(send_data.encode('utf-8'), (ip, port))
    print("\n\n 1. Client Sent : ", send_data, "\n\n")
# close the socket
s.close()
