import java.util.*;

Player p;
Slime s, s2;
String[] spriteNames;
String[] playerNames;
ArrayList<OverworldObject> roomSprites = new ArrayList<OverworldObject>();
ArrayList<Monster> m = new ArrayList<Monster>();
ArrayList<PImage> sprite = new ArrayList<PImage>();
ArrayList<PImage> assets = new ArrayList<PImage>();
void setup() {
  size(1000,1000);
  spriteNames = loadStrings("data/SpriteNames.txt");
  for (String str : spriteNames) {
     sprite.add(loadImage("data/sprites/" + str + ".png"));
  }
  s = new Slime(width/2, height/2, 50, 50, 1, 200.0, 4, 120, false);
  s2 = new Slime(200, 600, 50, 50, 1, 200.0, 4, 120, false);
  m.add(s);
  s.cHealth = 3;
  //m.add(s2);
  
  //Player assets:
  playerNames = loadStrings("player_assets/player_sprites.txt");
  for (String s : playerNames) {
    assets.add(loadImage("player_assets/" + s + ".png"));
  }
  //4 stands for # of sprites for each PHASE. Not the number of sprites in total. The value changes in differnet cases.
  p = new Player(40,40,300,300,4,assets);
  
  //Room assets:
}

void draw() {
  background(255);
  textSize(32);
  text(p.x_pos + " " + p.y_pos, 50, 50);
  fill(0, 102, 153);
  for (Monster mons : m) {
    mons.updateBehavior(p);
    mons.move(mons.currentDirection);
    mons.display();
    text("Monster health: " + mons.cHealth, 500, 50);
  }

  //if(p.isTouching(s)) System.out.print("hi");
  //System.out.print(p.x_pos + ",");
  //System.out.print(p.y_pos);
  //System.out.print(" " + s.x_pos + ",");
  //System.out.print(s.y_pos);
  p.move();
  p.display();
}

void keyPressed() {
  p.setMove(keyCode, true, m);
}

void keyReleased() {
  p.setMove(keyCode, false, m);
}
