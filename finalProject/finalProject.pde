import java.util.*;

Player p;
Slime s, s2;
Piranha_Plant d, d2;
HUD h;
String[] spriteNames, hudNames, assetNames, playerNames;
ArrayList<Monster> m = new ArrayList<Monster>();
ArrayList<OverworldObject> roomSprites = new ArrayList<OverworldObject>();
ArrayList<PImage> sprite = new ArrayList<PImage>();
ArrayList<PImage> assets = new ArrayList<PImage>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<PImage> hud = new ArrayList<PImage>();
int iT = 60;

void setup() {
  size(1000,1000);
  spriteNames = loadStrings("data/SpriteNames.txt");
  for (String str : spriteNames) {
     sprite.add(loadImage("data/sprites/" + str + ".png"));
  }
  hudNames = loadStrings("data/hudNames.txt");
  for (String str : hudNames) {
     hud.add(loadImage("data/hud/" + str + ".png"));
  }
  d = new Piranha_Plant(500, 800, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, false);
  d2 = new Piranha_Plant(500, 200, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, false);
  s = new Slime(width/2, height/2, 50, 50, 1, 200.0, 4, 4, 120, iT, .5, false);
  s2 = new Slime(200, 600, 50, 50, 1, 200.0, 1, 4, 120, iT, .5, false);
  m.add(s);
  m.add(s2);
  m.add(d);
  m.add(d2);

  //Player assets:
  playerNames = loadStrings("player_assets/player_sprites.txt");
  for (String s : playerNames) {
    assets.add(loadImage("player_assets/" + s + ".png"));
  }
  //4 stands for # of sprites for each PHASE. Not the number of sprites in total. The value changes in differnet cases.
  p = new Player(40,40,300,300,iT,4,assets);
  h = new HUD(p.m_health, 20, 20, 50);
  //Room assets:

}

void draw() {
  background(255);
  //text(p.c_health + "", 50, 50);
  //text(projectiles.toString(), 100, 100);
  //textSize(32);
  //text(p.x_pos + " " + p.y_pos, 50, 50);
  //textSize(32);
  //text(p.x_pos + " " + p.y_pos, 50, 50);
  //text(p.c_health + "", 50, 50);
  //text(projectiles.toString(), 100, 100);
  fill(0, 102, 153);
  for (int mons = m.size() - 1; mons >= 0; mons--) {
    m.get(mons).update(p);
    m.get(mons).move(m.get(mons).currentDirection);
    m.get(mons).display();
    for (int i = m.size() - 1; i >= 0; i--) {
      if (m.get(i).cHealth <= 0 && m.get(i).getDeathTimer() == 0) m.remove(i);
    }
  print(s2.num_sprites);
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
  p.update(h);
  p.move();
  p.display();
  h.update(p.c_health);
  h.display();
}

void keyPressed() {
  p.setMove(keyCode, true, m);
}

void keyReleased() {
  p.setMove(keyCode, false, m);
}
