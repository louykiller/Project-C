class Line {
  int ref;

  Line(int ref) {
    this.ref = ref;
  }

  void show() {
    // Draw the lines in black
    stroke(0, 0, 0);
    // If 0 it's the horizontal line (x axis)
    if (ref == 0) {
      // Draw a line from point (0, height/2) to point (width, height/2)
      line(0, height/2, width, height/2);
    } 
    // If it's 1 it's the vertical axis (y axis)
    else if (ref == 1) {
      // Draw a line from point (width/2, 0) to point (width/2, height)
      line(width/2, 0, width/2, height);
    }
  }
}
