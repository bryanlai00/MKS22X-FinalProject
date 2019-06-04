import java.util.*;

Screen scr;
Player p;
Slime s, s2;
Baby d, d2;
Minotaur min, min2;
Boar b, b2;
Spirit sp, sp2;
Griffin g, g2;
Dragon dr, dr2;
HUD h;
boolean running = true;
ArrayList<OverworldObject> roomObjects = new ArrayList<OverworldObject>();
ArrayList<OverworldObject> collideableRoomObjects = new ArrayList<OverworldObject>();
ArrayList<OverworldObject> harming = new ArrayList<OverworldObject>();
ArrayList<Item> allItems = new ArrayList<Item>();
String[] objects, spriteNames, hudNames, assetNames, playerNames, screenNames, itemNames, effectNames;
ArrayList<Monster> m = new ArrayList<Monster>();
ArrayList<Monster> mSpawn = new ArrayList<Monster>();
ArrayList<PImage> sprite = new ArrayList<PImage>();
ArrayList<PImage> assets = new ArrayList<PImage>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<PImage> hud = new ArrayList<PImage>();
ArrayList<PImage> screenImages = new ArrayList<PImage>();
ArrayList<Screen> screens = new ArrayList<Screen>();
ArrayList<PImage> effectSprites = new ArrayList<PImage>();
int iT = 60, spawnTime = 10, screenDelay = 0;
String mode = "colosseum";

void setup() {
  size(1440,810);
  spriteNames = loadStrings("data/SpriteNames.txt");
  for (String str : spriteNames) {
     sprite.add(loadImage("data/sprites/" + str + ".png"));
  }
  hudNames = loadStrings("data/hudNames.txt");
  for (String str : hudNames) {
     hud.add(loadImage("data/hud/" + str + ".png"));
  }
  screenNames = loadStrings("data/screenNames.txt");
  for (String str : screenNames) {
     screenImages.add(loadImage("data/screens/" + str + ".png"));
  }
  //Going through items.txt:
  itemNames = loadStrings("data/itemNames.txt");
  for(int i = 0; i < itemNames.length; i++) {
    String[] params = itemNames[i].split(",");
    allItems.add(new Item(Float.valueOf(params[0]), Float.valueOf(params[1]), Float.valueOf(params[2]), Float.valueOf(params[3]), loadImage("data/items/" + params[4] + ".png"), Float.valueOf(params[5])));
  }
  //Going through effects folder:
  effectNames = loadStrings("data/effectNames.txt");
  for(int i = 0; i < effectNames.length; i++) {
    String[] params = effectNames[i].split(" ");
    float spriteAmt = Float.valueOf(params[1]);
    for(int s = 0; s < spriteAmt; s++) {
     effectSprites.add(loadImage("data/effects/" + params[0] + "_" + s + ".png"));
    }
  }
  
  //Room assets:
  objects = loadStrings("data/colosseum.txt");
  OverworldObject vortex = null; 
  for(int i = 0; i < objects.length; i++) {
    //If the line/string does not contain Room...
    if(!objects[i].contains("Room")) {
      String[] params = objects[i].split(" ");
      //print(Arrays.toString(params)) Using these parameters, add to room sprites.
      for(int copies = 0; copies < Float.valueOf(params[5]); copies++) {
        for(int yCopies = 0; yCopies < Float.valueOf(params[6]); yCopies++) {
          //If the overworldobject is not animated (length == 8):
          if(params.length == 8) {
            roomObjects.add(new OverworldObject(Float.valueOf(params[1]) + copies * Float.valueOf(params[3]), Float.valueOf(params[2]) + yCopies * Float.valueOf(params[4]) , Float.valueOf(params[3]), Float.valueOf(params[4]), loadImage("data/room_assets/" + params[0] + ".png"), Boolean.valueOf(params[7])));
            if(Boolean.valueOf(params[7])) {
              collideableRoomObjects.add(new OverworldObject(Float.valueOf(params[1]) + copies * Float.valueOf(params[3]), Float.valueOf(params[2]) + yCopies * Float.valueOf(params[4]) , Float.valueOf(params[3]), Float.valueOf(params[4]), loadImage("data/room_assets/" + params[0] + ".png"), Boolean.valueOf(params[7])));
            }
          }
          else {
            ArrayList<PImage> more_sprites = new ArrayList<PImage>();
            float spriteAmt = Float.valueOf(params[8]);
            for(int s = 0; s < spriteAmt; s++) {
              more_sprites.add(loadImage("data/room_assets/" + params[0] + "_" + s + ".png"));
            }
            OverworldObject over = new OverworldObject(Float.valueOf(params[1]) + copies * Float.valueOf(params[3]), Float.valueOf(params[2]) + yCopies * Float.valueOf(params[4]) , Float.valueOf(params[3]), Float.valueOf(params[4]), more_sprites, Boolean.valueOf(params[7]), Float.valueOf(params[8]));
            roomObjects.add(over);
            if(Boolean.valueOf(params[7])) {
              collideableRoomObjects.add(over);
            }
            if(params[0].equals("peaks")) {
              harming.add(over);
            }
        }
      }
    }
  }
}
  vortex = roomObjects.get(roomObjects.size() - 1);

  scr = new Screen(width/2 - 190, height - 115, width/2, 75, 75, "title");
  screens.add(scr);
  //Create vortex for spawning area.
  //Slime(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss, int sco)
  s = new Slime(vortex.x_pos, vortex.y_pos, 50, 50, 0, 200.0, 2, 4, 120, iT, .5, false, 50);
  s2 = new Slime(vortex.x_pos, vortex.y_pos, 50, 50, 1, 200.0, 1, 4, 120, iT, .5, true, 50);
  d = new Baby(vortex.x_pos, vortex.y_pos, 90, 90, 1.5, 300.0, 3, 10, 120, iT, 1, false, 100);
  d2 = new Baby(vortex.x_pos, vortex.y_pos, 90, 90, 1.5, 300.0, 3, 10, 120, iT, 1, true, 100);
  min = new Minotaur(vortex.x_pos, vortex.y_pos, 150, 150, 1.5, 400.0, 5, 4, 120, iT, .5, false, 150, 250);
  min2 = new Minotaur(vortex.x_pos, vortex.y_pos, 150, 150, 1.5, 400.0, 5, 4, 120, iT, .5, true, 150, 250);
  b = new Boar(vortex.x_pos, vortex.y_pos, 50, 50, 2, 300.0, 1, 8, 120, iT, .5, false, 150);
  b2 = new Boar(vortex.x_pos, vortex.y_pos, 50, 50, 2, 300.0, 1, 8, 120, iT, .5, true, 150);
  sp = new Spirit(vortex.x_pos, vortex.y_pos, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, false, 200);
  sp2 = new Spirit(vortex.x_pos, vortex.y_pos, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, true, 200);
  g = new Griffin(vortex.x_pos, vortex.y_pos, 150, 150, 1.5, 400.0, 5, 10, 120, iT, .5, false, 150, 250);
  g2 = new Griffin(vortex.x_pos, vortex.y_pos, 150, 150, 1.5, 400.0, 5, 10, 120, iT, .5, true, 150, 250);
  dr = new Dragon(vortex.x_pos, vortex.y_pos, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, false, 300);
  dr2 = new Dragon(vortex.x_pos, vortex.y_pos, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, true, 300);
  //Array List of possible monsters that may spawn:
  mSpawn.add(s);
  mSpawn.add(s2);
  mSpawn.add(d);
  mSpawn.add(d2);
  mSpawn.add(min);
  mSpawn.add(min2);
  mSpawn.add(b);
  mSpawn.add(b2);
  mSpawn.add(sp);
  mSpawn.add(sp2);
  mSpawn.add(g);
  mSpawn.add(g2);
  mSpawn.add(dr);
  mSpawn.add(dr2);

  //Player assets:
  playerNames = loadStrings("data/player_sprites.txt");
  for (String s : playerNames) {
    assets.add(loadImage("data/player_assets/" + s + ".png"));
  }
  //4 stands for # of sprites for each PHASE. Not the number of sprites in total. The value changes in differnet cases.
  //For dungeon: p = new Player(50,50, 700, 0,iT,4,assets);
  //Colosseum: 
  p = new Player(50, 50, 750, 575, iT, 4, assets);
  //Adding items already to player: (If colosseum mode:)
  h = new HUD(p.m_health, 20, 20, 50);
  //Room assets:
}

void draw() {
    //Room assets:
    if (screens.size() > 0) screens.get(0).display();
    else if(running){
      background(37,19,26);
      fill(0, 102, 153);
      for(int i = 0; i < roomObjects.size(); i++) {
        roomObjects.get(i).display();
      }

      Monster target = null;
      if(spawnTime < 0 && m.size() < 5) {
            Monster chosen = mSpawn.get((int)(Math.random() * mSpawn.size()));
            if(chosen instanceof Griffin) {
              m.add(new Griffin((Griffin)chosen));
            }
            if(chosen instanceof Dragon) {
              m.add(new Dragon((Dragon)chosen));
            }
            if(chosen instanceof Baby) {
              m.add(new Baby((Baby)chosen));
            }
            if(chosen instanceof Boar) {
              m.add(new Boar((Boar)chosen));
            }
            if(chosen instanceof Slime) {
              m.add(new Slime((Slime)chosen));
            }
            if(chosen instanceof Spirit) {
              m.add(new Spirit((Spirit)chosen));
            }
            if(chosen instanceof Minotaur) {
              m.add(new Minotaur((Minotaur)chosen));
            }
            spawnTime = 100;
      }
      else {
        spawnTime--;
      }
      for (int mons = m.size() - 1; mons >= 0; mons--) {
        m.get(mons).update(p);
        m.get(mons).move(m.get(mons).currentDirection);
        m.get(mons).display();
        //Continue to keep adding monsters:
        if(target != null) {
          if(dist(p.x_pos, p.y_pos, target.getX(), target.getY()) > dist(p.x_pos, p.y_pos, m.get(mons).getX(), m.get(mons).getY())) {
            target = m.get(mons);
          }
        }
        else if(m.size() > 0) {
            target = m.get(mons);
        }
        for (int i = m.size() - 1; i >= 0; i--) {
          if (m.get(i).cHealth <= 0 && m.get(i).getDeathTimer() == 0) {h.increaseScore(m.get(i).score); m.remove(i);}
        }
        //finds closest monster:
    }
    //Added projectile stuff for player as well.
      for (int i = projectiles.size() - 1; i >= 0; i--) {
        Projectile proj = projectiles.get(i);
        proj.move();
        proj.display();
        if(proj.target.equals("player")) {
          proj.update(p);
        }
        if(proj.target.equals("monster")) {
          if(target != null) {
            proj.update(target);
          }
        }
      }
      for(Item i : allItems) {
        i.display();
      }
      p.update(h);
      p.move();
      p.display();
      h.update(p.c_health);
      h.display();
    }
    else {
      clear();
    }
}

void keyPressed() {
  if (screens.size() > 0) {
    if(screens.get(0).select(keyCode) == true) {
      draw();
    }
  }
  if(screenDelay == 0) {
    if(running) p.setMove(keyCode, true, m);
  }
  else {
    screenDelay--;
  }
}

void keyReleased() {
  if(running) p.setMove(keyCode, false, m);
}
//Clears everything on the screen when reaching gameOver.
void clear() {
  if(p.c_health <= 0) screens.add(new Screen(width/2, height/2, width/2, 50, 50, "game_over"));
}
