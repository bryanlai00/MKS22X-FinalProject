public class Screen {
  PImage s, cursor;
  String codename;
  float x_pos, y_pos, mx_pos, my_pos, x_size, y_size;
  Screen(PImage scr, PImage c, float x, float y, float mirX, float x_si, float y_si, String code) {
     s = scr;
     cursor = c;
     x_pos = x;
     y_pos = y;
     mx_pos = mirX * 2 - x;
     x_size = x_si;
     y_size = y_si;
     codename = code;
  }
  void display() {
    if (codename.equals("start")) {
      background(255);
      image(s, 0, 0, width, height);
      image(cursor, x_pos, y_pos, x_size, y_size); 
      pushMatrix();
      translate(mx_pos, y_pos);
      scale(-1.0, 1.0);
      image(cursor, 0, 0, x_size, y_size); 
      popMatrix();
      textAlign(CENTER);
      text("press any button", width / 2, 3 * height / 4);
    }
    if(codename.equals("gameover")) {
      background(255);
      image(s,x_pos,y_pos,width,height);
      pushMatrix();
      translate(mx_pos, my_pos);
      scale(-1.0, 1.0);
      textAlign(CENTER);
      popMatrix();
    }
  }
  void select() {
    if (codename.equals("start")) screens.clear();
  }
}
