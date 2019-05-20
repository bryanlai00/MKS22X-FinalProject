import java.util.*;

Player p;
Slime s, s2;
String[] spriteNames;
ArrayList<Monster> m = new ArrayList<Monster>();
ArrayList<PImage> sprite = new ArrayList<PImage>();
void setup() {
  size(1000,1000);
  spriteNames = loadStrings("data/SpriteNames.txt");
  for (String str : spriteNames) {
     sprite.add(loadImage("data/sprites/" + str + ".png"));
  }
  s = new Slime(width/2, height/2, 50, 50, 1, 200.0, 4, 120, false);
  s2 = new Slime(200, 600, 50, 50, 1, 200.0, 4, 120, false);
  m.add(s);
  m.add(s2);
  p = new Player(60,60,300,300,loadImage("hollow_knight.jpg"));
}

void draw() {
  background(255);
  for (Monster mons : m) {
    mons.updateBehavior(p);
    mons.move(mons.currentDirection);
    mons.display();
  }
  //if(p.isTouching(s)) System.out.print("hi");
  //System.out.print(p.x_pos + ",");
  //System.out.print(p.y_pos);
  //System.out.print(" " + s.x_pos + ",");
  //System.out.print(s.y_pos);
  p.display();
  p.move();
}

void keyPressed() {
  p.setMove(keyCode, true);
}

void keyReleased() {
  p.setMove(keyCode, false);
}
