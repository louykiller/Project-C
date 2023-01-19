// To have lines change this to true
boolean showAxis = true;
// Change this for the max number of points
int maxPoints = 100;
int count = 0;
// The x and y axis
Axis[] axis = new Axis[2];
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
    points[i] = new Point(-10, -10);
  }
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
  // Recieve the data and update the points
  recieveData();
  // Show the points
  for (int i = 0; i < maxPoints; i++) {
    points[i].show();
  }
}

void recieveData() {
  // TODO: Recieve the UDP packets
  
  // ========================== TEST DATA ====================================
  delay(1);
  // I dont know why but this makes it work
  float r = random(-10, 10);
  // Alfa is maped to be between 0 and 2PI from the mouseX
  float alfa = map(mouseX, 0, width, 0, 2 * PI);
  // Move and show the point
  // These calculations are just to center the results because the coordinate (0, 0) is in the top left corner and the point (width, height) is in the bottom right corner
  float x = width/2 + cos(r) * (width - 100) / 2;
  float y = height/2 + -cos(alfa + r) * (height - 100) / 2;
  // ========================== TEST DATA ====================================
  
  // Update the point and the count variable
  points[count].update(x, y);
  count++;
  if(count == maxPoints){
    count = 0; 
  }
}
