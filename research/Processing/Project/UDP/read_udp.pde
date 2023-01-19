import java.net.*;
import java.io.*;
import java.util.Arrays;

DatagramSocket socket;
DatagramPacket packet;

byte[] buf = new byte[64]; //Set your buffer size as desired

void setup() {
  try {
    socket = new DatagramSocket(5005); // Set your port here
  }
  catch (Exception e) {
    e.printStackTrace(); 
    println(e.getMessage());
  }
}

void draw() {
  try {
    println("now receiving udp packets");
    DatagramPacket packet = new DatagramPacket(buf, buf.length);
    socket.receive(packet);
    InetAddress address = packet.getAddress();
    int port = packet.getPort();
    packet = new DatagramPacket(buf, buf.length, address, port);

    //If you wish to receive as String:
    String received = new String(packet.getData(), 0, packet.getLength());
    println(received);
  }
  catch (IOException e) {
    e.printStackTrace(); 
    println(e.getMessage());
  }
}
