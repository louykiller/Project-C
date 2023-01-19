import hypermedia.net.*;

int PORT_RX = 6000;                     // Source port
String HOST_IP = "192.168.129.137";     // IP Address of the PC
UDP udp;
String receivedFromUDP = "";

void setup() {
  size(400,400);
  // Create new UDP connection
  udp= new UDP(this,PORT_RX,HOST_IP);
  udp.log(true);
  udp.listen(true);
}

void draw() {
  background(0);
  // Write on the screen the data received
  text(receivedFromUDP, 50, 50);
}

// Default function to receive UDP packets
void receive(byte[] data) {
  // Get the data from the packets and print it
  receivedFromUDP ="";
  for (int i = 0; i < data.length; i++) {
    receivedFromUDP += str(data[i]) + " ";
  }
  println(data);
}
