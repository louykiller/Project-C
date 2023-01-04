MQTTClient client;

void setup() {
   client = new MQTTClient(this);
   client.connect("mqtt://public:public@testnumberone.cloud.shiftr.io", "processing");
   client.subscribe("mic1");
   client.subscribe("mic2");
}

void draw() {}



void keyPressed() {
   //generate mic1 val
   float mic1_val = random(1,500);
   //generate mic2 val
   float mic2_val = random(1,500);
   //publish values
   client.publish("mic1", str(mic1_val));
   client.publish("mic2", str(mic2_val));
}

void messageReceived(String topic, byte[] payload) {
   println(topic + ": " + new String(payload));
}