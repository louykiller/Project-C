#include <WiFiNINA.h>         // Wifi library
#include <WiFiUdp.h>          // UDP library

// WiFi variables (was using mobile hotspot to test)
char ssid[] = "ArduinoTest";       //  ENTER Wifi SSID (network name) BETWEEN QUOTES
char pass[] = "ArduinoTest";        // ENTER Wifi password BETWEEN QUOTES
// UDP Variables
const char* computerIP = "192.168.129.137";         // ENTER YOUR COMPUTER'S IP BETWEEN QUOTES
const unsigned int port = 6000;                     // Destination Port


int status = WL_IDLE_STATUS;            // Status of WiFi connection
WiFiSSLClient client;                   // Instantiate the Wifi client
WiFiUDP Udp;                                    // Instantiate UDP class

// Byte Arrays to send
byte value[4];

void setup() 
{
  //Initialize serial and wait for port to open:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // check for the WiFi module:
  if (WiFi.status() == WL_NO_MODULE) {
    Serial.println("Communication with WiFi module failed!");
    // don't continue
    while (true);
  }

  // attempt to connect to WiFi network:
  while (status != WL_CONNECTED) {
    Serial.print("Attempting to connect to WPA SSID: ");
    Serial.println(ssid);
    // Connect to WPA/WPA2 network:
    status = WiFi.begin(ssid, pass);

    // wait 10 seconds for connection:
    delay(10000);
  }

  Serial.println("You're connected to the network");
  // print your board's IP address and port:
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);
  Serial.print("Port: ");
  Serial.println(port);
  // To get random numbers
  randomSeed(analogRead(0));
}


void loop() 
{
  delay(5000);
  generateRandomNumbers();
  Serial.println(value[0]);
  // Send data over UDP
  Udp.beginPacket(computerIP, port);
  Udp.write(value, 4);
  Udp.endPacket();

}

void generateRandomNumbers(){
  // Generate random values
  long rand = random(128);

  for(int i = 0; i < 4; i++){
    value[i] = (rand >> i*8) & 0xFF;
  }
}


