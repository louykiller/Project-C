#include <WiFiNINA.h>
#include <MQTT.h>
#include "arduino_secrets.h"




#define MAX_VALUE 7000

///////please enter your sensitive data in the Secret tab/arduino_secrets.h
char ssid[] = SECRET_SSID; // your network SSID (name)
char pass[] = SECRET_PASS; // your network password (use for WPA, or use as key for WEP)

const char mqtt_server[] = "testnumberone.cloud.shiftr.io";

WiFiClient net;
MQTTClient client;

char mic1_val[10];
char mic2_val[10];
char payload[20];
const char * separator="_"; 

unsigned long lastMillis = 0;

int value;


char switchWay='0';


void connect()
{
  Serial.print("\nconnecting to mqtt...");
  while (!client.connect("arduino", "testnumberone", "arduino_token"))
  {
    Serial.print(".");
    delay(1000);
  }

  Serial.println("\nconnected!");

  client.subscribe("hello");
}

void messageReceived(String &topic, String &payload)
{
  Serial.println(topic + ": " + payload);
}

void setup()
{
  // Initialize serial and wait for port to open:
  Serial.begin(9600);
  randomSeed(analogRead(0));

  while (!Serial)
  {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // WIFININA CONNECTION_________________________________________________________
  // attempt to connect to Wifi network:
  Serial.print("Attempting to connect to WPA SSID: ");
  Serial.println(ssid);
  while (WiFi.begin(ssid, pass) != WL_CONNECTED)
  {
    // failed, retry
    Serial.print(".");
    delay(1000);
  }

  Serial.println("You're connected to the network.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  // MQTT BROKER CONNECTION_____________________________________________________
  // start wifi and mqtt
  client.begin(mqtt_server, net);
  client.onMessage(messageReceived);

  connect();
}

int generateMicVal()
{
  int value;
  value = random(MAX_VALUE);
  return value;
}

void loop()
{ 
  if (Serial.available() > 0){
    switchWay = Serial.read();
  }
  
  //clear payload
  payload[0] = '\0';

  client.loop();
  delay(7);


  // check if connected
  if (!client.connected())
  {
    connect();
  }

  // publish a message roughly every 100th.
  if (millis() - lastMillis > 0.1)
  {
    lastMillis = millis();
    
    value=generateMicVal();
    
    itoa(value, mic1_val, 10);


    if(switchWay=='0'){
      itoa(value, mic2_val, 10);
    }else{
      itoa(MAX_VALUE-value, mic2_val, 10);
    }
    
    
    //arrange payload
    strcat(payload,mic1_val);
    strcat(payload,separator);
    strcat(payload,mic2_val);



    unsigned long publish_begin = millis();

    //send both values in a single topic

    client.publish("/mic_values", payload);
    Serial.println(payload);

    unsigned long publish_end = millis();

    Serial.println("Time taken to publish: ");
    Serial.println((publish_end - publish_begin));
    Serial.print("\n");

  }
}