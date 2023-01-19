import mqtt.*;
MQTTClient client;
String url = "mqtt://testnumberone:processing_reader@testnumberone.cloud.shiftr.io";
// Store values for number of messages recieved and for both mics
int msgNum = 0;
float x, y;
// The max amplitude of the microphones
int maxAmplitude = 7000;

// To have lines change this to true
boolean showAxis = true;
// The x and y axis
Axis[] axis = new Axis[2];
// Change this for the max number of points
int maxPoints = 150;
int count = 0;
// The array of points
Point[] points = new Point[maxPoints];

void setup() {
  // Set the window size
  size(800, 800);
  // Initiate the axis
  if (showAxis) {
    for (int i = 0; i < 2; i++) {
      axis[i] = new Axis(i);
    }
  }
  // Initiate the points outside of the window
  for (int i = 0; i < maxPoints; i++) {
    points[i] = new Point(-100, -100);
  }
  // Start the connection
  client = new MQTTClient(this);
  client.connect(url, "processing");
  client.subscribe("mic_values");
}

void draw() {
  // Set the background color to white
  background(255, 255, 255);
  // Show the axis
  if (showAxis) {
    for (int i = 0; i < 2; i++) {
      axis[i].show();
    }
  }
  // Translate the origin of the axis and flip it on the x axis
  translate(50, height - 50);
  scale(1, -1);
  // Show the points
  for (int i = 0; i < maxPoints; i++) {
    points[i].show();
  }
}

void messageReceived(String topic, byte[] payload) {
  int aux = 0;
  // Get the numbers recieved
  for (int i = 0; i < payload.length; i++) {
    // If it recieved a '_' then the first number is completed
    if (payload[i] == '_') {
      x = aux;
      aux = 0;
    } else {
      aux = aux * 10 + int(payload[i] - '0');
    }
  }
  // In the end of the loop the second number is completed
  y = aux;
  // Map the values to fit the map
  x = map(x, 0, maxAmplitude, 0, width - 100);
  y = map(y, 0, maxAmplitude, 0, height - 100);

  // Update the point and other variables
  points[count].update(x, y);
  count++;
  msgNum++;
  if (count == maxPoints) {
    count = 0;
  }
}

// When the window is closed it says the stats
void keyPressed() {
  if (key==ESC) {
    key=0;
    float average = msgNum * 2 / (millis()/1000);
    println("Number of messages recieved: " + msgNum);
    println("Seconds passed: " + (millis()/1000));
    println("Message/s: " + average);
    exit();
  }
}
