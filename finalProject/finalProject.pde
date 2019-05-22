import java.util.*;

Player p;
Slime s, s2;
Piranha_Plant d;
String[] spriteNames;
ArrayList<Monster> m = new ArrayList<Monster>();
ArrayList<PImage> sprite = new ArrayList<PImage>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
int iT = 60;
void setup() {
  size(1000,1000);
  spriteNames = loadStrings("data/SpriteNames.txt");
  for (String str : spriteNames) {
     sprite.add(loadImage("data/sprites/" + str + ".png"));
  }
  d = new Piranha_Plant(500, 800, 100, 100, 2, 300.0, 10, 120, iT, 1, false);
  s = new Slime(width/2, height/2, 50, 50, 1, 200.0, 4, 120, iT, .5, false);
  s2 = new Slime(200, 600, 50, 50, 1, 200.0, 4, 120, iT, .5, false);
  m.add(s);
  m.add(s2);
  m.add(d);
  p = new Player(60,60,300,300,iT,loadImage("hollow_knight.jpg"));
}

void draw() {
  background(255);
  text(p.c_health + "", 50, 50);
  text("(" + d.getX() + "," + d.getY(), 100, 100);
  fill(0, 102, 153);
  for (Monster mons : m) {
    mons.update(p);
    mons.move(mons.currentDirection);
    mons.display();
  }
  for (Projectile pro : projectiles) {
    int temp = projectiles.size();
    pro.update();
    if (projectiles.size() < temp) {
     for (Projectile p : projectiles) p.setIndex(p.getIndex()-1); 
    }
    pro.move();
    pro.display();
  }
  //if(p.isTouching(s)) System.out.print("hi");
  //System.out.print(p.x_pos + ",");
  //System.out.print(p.y_pos);
  //System.out.print(" " + s.x_pos + ",");
  //System.out.print(s.y_pos);
  p.update();
  p.display();
  p.move();
}

void keyPressed() {
  p.setMove(keyCode, true);
}

void keyReleased() {
  p.setMove(keyCode, false);
}
