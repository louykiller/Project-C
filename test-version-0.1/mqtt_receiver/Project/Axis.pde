class Axis {
  int ref;

  Axis(int ref) {
    this.ref = ref;
  }

  void show() {
    // Draw the line in black
    stroke(0, 0, 0);
    // If it's 0 it's the horizontal line (x axis)
    if (ref == 0) {
      line(0, height/2, width, height/2);
    }
    // If it's 1 it's the vertical axis (y axis)
    else if (ref == 1) {
      line(width/2, 0, width/2, height);
    }
  }
}
