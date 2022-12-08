// The x and y axis
Line[] axis = new Line[2];
// The array of points
Point[] points = new Point[200];
// To have lines cahnge this to true
boolean lines = true;

void setup() {
  // Set the window size
  size(800, 800);
  // Initiate the axis
  if (lines) {
    for (int i = 0; i < axis.length; i++) {
      axis[i] = new Line(i);
    }
  }
  // Initiate the points
  for (int i = 0; i < points.length; i++) {
    points[i] = new Point(width/2, height/2);
  }
}


void draw() {
  // Set the background color to white
  background(255, 255, 255);
  // Show the axis
  if (lines) {
    for (int i = 0; i < axis.length; i++) {
      axis[i].show();
    }
  }
  // Update the points
  for (int i = 0; i < points.length; i++) {
    // I dont know why but this makes it work
    float r = random(-10, 10);
    // Alfa is maped to be between 0 and 2PI from the mouseX
    float alfa = map(mouseX, 0, width, 0, 2 * PI);
    // Move and show the point
    // These calculations are just to center the results because the coordinate (0, 0) is in the top left corner and the point (width, height) is in the bottom right corner
    points[i].move(width/2 + cos(r) * (width - 100) / 2, height/2 + -cos(alfa + r) * (height - 100) / 2);
    points[i].show();
  }
}
