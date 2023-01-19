import mqtt.*;

MQTTClient client;

//store values for both mics
String mic1_data;
String mic2_data;
int msgnum=0;


void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://public:public@testnumberone.cloud.shiftr.io", "processing");
  client.subscribe("mic1");
  client.subscribe("mic2");
}

void draw() {
}

void messageReceived(String topic, byte[] payload) {
  println(topic + ": " + new String(payload));
  msgnum++;
}


void keyPressed() {
  if (key==ESC) {
    key=0;
    println(msgnum);
    exit();
  }
}
