import java.util.*;

Player p;
Slime s, s2;
Piranha_Plant d, d2;
String[] spriteNames, hudNames;
String[] assetNames;
ArrayList<Monster> m = new ArrayList<Monster>();
ArrayList<PImage> sprite = new ArrayList<PImage>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<PImage> hud = new ArrayList<PImage>();
int iT = 60;
ArrayList<PImage> assets = new ArrayList<PImage>();

void setup() {
  size(1000,1000);
  spriteNames = loadStrings("data/SpriteNames.txt");
  for (String str : spriteNames) {
     sprite.add(loadImage("data/sprites/" + str + ".png"));
  }
  
  d = new Piranha_Plant(500, 800, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, false);
  d2 = new Piranha_Plant(500, 200, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, false);
  s = new Slime(width/2, height/2, 50, 50, 1, 200.0, 1, 4, 120, iT, .5, false);
  s2 = new Slime(200, 600, 50, 50, 1, 200.0, 1, 4, 120, iT, .5, false);
  m.add(s);
  m.add(s2);
  m.add(d);
  m.add(d2);
  //p = new Player(60,60,300,300,iT,loadImage("hollow_knight.jpg"));
  //m.add(s2);
  
  //Player and room assets:
  assetNames = loadStrings("player_room_assets/player_sprites.txt");
  for (String s : assetNames) {
    assets.add(loadImage("player_room_assets/" + s + ".png"));
  }
  //4 stands for # of sprites for each PHASE. Not the number of sprites in total. 
  p = new Player(70,70,300,300,4,assets);
}

void draw() {
  background(255);
  text(p.c_health + "", 50, 50);
  text(projectiles.toString(), 100, 100);
  textSize(32);
  text(p.x_pos + " " + p.y_pos, 50, 50);
  fill(0, 102, 153);
  for (Monster mons : m) {
    mons.update(p);
    mons.move(mons.currentDirection);
    mons.display();
    p.attack(mons, 1);
  }
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    projectiles.get(i).move();
    projectiles.get(i).display();
    projectiles.get(i).update(p);
  }
  //if(p.isTouching(s)) System.out.print("hi");
  //System.out.print(p.x_pos + ",");
  //System.out.print(p.y_pos);
  //System.out.print(" " + s.x_pos + ",");
  //System.out.print(s.y_pos);
  p.update();
  p.move();
  p.display();
}

void keyPressed() {
  p.setMove(keyCode, true);
}

void keyReleased() {
  p.setMove(keyCode, false);
}