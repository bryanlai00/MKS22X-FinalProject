public class Screen {
  PImage s;
  PImage cursor;
  float x_pos, y_pos, x_size, y_size;
  Screen(PImage scr, PImage c, float x, float y, float x_si, float y_si) {
     s = scr;
     cursor = c;
     x_pos = x;
     y_pos = y;
     x_size = x_si;
     y_size = y_si;
  }
  void display() {
    background(s);
    image(cursor, x_pos, y_pos, x_size, y_size); 
  }
}