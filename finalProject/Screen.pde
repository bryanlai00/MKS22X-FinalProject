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
    if(codename.equals("game_over")) {
      background(255);
      imageMode(CORNER);
   }
    if(codename.equals("instruct")) {
      background(255);
      imageMode(CORNER);
      text("Press R to restart!", width/2, height/2);
    }
    image(localFrames.get(frame), 0, 0, width, height);
    if (frame < localFrames.size() - 1) frame++;
    else frame = 0;
    //Specific for gameover because we need to display text over the image.
    if(codename.equals("game_over")) {
      image(loadImage("data/screens/Restart.png"), width/5, 3 * height/4);  
    }
  }
  boolean select(int k) {
    if (codename.equals("title")) screens.clear();
    if(codename.equals("game_over") && k == 'R') {
        for(int i = 0; i < screens.size(); i++) {
        if(screens.get(i).codename.equals("game_over")) {
          running = true;
          p.c_health = p.m_health;
          p.xChange = 750;
          p.yChange = 750;
          p.x_pos = 750;
          p.y_pos = 750;
          h.score = 0;
          m.clear();
          screens.clear();  
        }
      }
      screens.add(new Screen(width/2 - 190, height - 115, width/2, 75, 75, "title"));
      return true;
     }
     return false;
  }
}
