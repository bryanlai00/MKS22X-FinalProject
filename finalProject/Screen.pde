public class Screen {
  int frame = 0;
  //contains the frames and their names for Screens only
  ArrayList<PImage> localFrames = new ArrayList<PImage>();
  ArrayList<String> localFrameNames = new ArrayList<String>();
  PImage cursor;
  String codename; //Determines what type of screen it is and how to display it
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
  //Displays the screen based on its codename
  void display() {    
    if(codename.equals("game_over")) {
      background(255);
      imageMode(CORNER);
   }
    if(codename.equals("instruct")) {
      background(255);
      imageMode(CORNER);
    }
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
    if (frame < localFrames.size() - 1) frame++;
    else frame = 0;    
    //Specific for gameover because we need to display text over the image.
    if(codename.equals("game_over")) {
      image(loadImage("data/screens/Restart.png"), width/5, 3 * height/4);  
      text("SCORE: " + h.score, width/2, 15 * height/ 16);
    }
  }
  //Determines actions for screens
  boolean select(int k) {
    if (codename.equals("title")) screens.clear();
    else if(codename.equals("game_over") && k == 'R') {
      return true;
     }
     return false;
  }
}
