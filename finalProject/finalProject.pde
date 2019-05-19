<<<<<<< HEAD
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
=======
Player p;

void setup() {
  size(800, 600);
   p = new Player(60,60,300,300,loadImage("hollow_knight.jpg"));
 }
 
void draw() {
  p.display();
  p.move();
}

void keyPressed() {
  p.setMove(keyCode, true);
}

void keyReleased() {
  p.setMove(keyCode, false);
>>>>>>> 8a78e3f534dab5270b5c21ba314ceaab4f8c29d6
}
