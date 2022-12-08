class Point {
  float x;
  float y;
  // To change the size of the points
  int size = 5;

  Point(float x, float y) {
    move(x, y);
  }

  // This updates the position of the point
  void move(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void show() {
    // Fill the shape of the point with black
    fill(0, 0, 0);
    // and draw the circle
    ellipse(x, y, size, size);
  }
}
