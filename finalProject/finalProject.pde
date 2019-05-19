import java.util.*;

Player p;
Slime s;
String[] sp;
void setup() {
  size(1000,1000);
  sp = loadStrings("data/SpriteNames.txt");
  s = new Slime(width/2, height/2, 50, 50, 3, 15, 4, 120, false);
  p = new Player(width/2, height/2, 50, 50);
  System.out.print(Arrays.toString(sp));
}

void draw() {
  background(255);
  s.display();
  s.update();
  s.move(s.currentDirection);
}
