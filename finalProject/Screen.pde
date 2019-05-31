public class Screen {
  int frame = 0;
  ArrayList<PImage> localFrames = new ArrayList<PImage>();
  ArrayList<String> localFrameNames = new ArrayList<String>();
  PImage cursor;
  String codename;
  float x_pos, y_pos, mx_pos, my_pos, x_size, y_size;
  Screen(float x, float y, float mirX, float x_si, float y_si, String code) {
     x_pos = x;
     y_pos = y;
     mx_pos = mirX * 2 - x;
     x_size = x_si;
     y_size = y_si;
     codename = code;
     for (int i = 0; i < screenNames.length; i++) {
       if (screenNames[i].contains(code)) {
         localFrames.add(screenImages.get(i));
         localFrameNames.add(screenNames[i]);
       }
       if (screenNames[i].contains("cursor")) cursor = screenImages.get(i);
     }
  }
  void display() {
    image(localFrames.get(frame), 0, 0, width, height);
    
    if (codename.equals("title")) {
      image(cursor, x_pos, y_pos, x_size, y_size); 
      pushMatrix();
      translate(mx_pos, y_pos);
      scale(-1.0, 1.0);
      image(cursor, 0, 0, x_size, y_size); 
      popMatrix();
      textAlign(CENTER);
      text("Press Any Key", width / 2, 31 * height / 32);
    }
<<<<<<< HEAD
    if (frame < localFrames.size() - 1) frame++;
    else frame = 0;
=======
    if(codename.equals("gameover")) {
      background(255);
      image(s,x_pos,y_pos,width,height);
      pushMatrix();
      translate(mx_pos, my_pos);
      scale(-1.0, 1.0);
      textAlign(CENTER);
      popMatrix();
    }
>>>>>>> 3097c015cad945b18157b1e88567602f2e05799d
  }
  void select() {
    if (codename.equals("title")) screens.clear();
  }
}
