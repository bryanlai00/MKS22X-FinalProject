import java.util.*;

//All constants and variables:
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
int iT = 60, spawnTime = 10, itemTime = 10;
String mode = "colosseum";
OverworldObject vortex = null, portal = null;
  
  
//Setup: Loads sprites and strings and then adds it to its specific ArrayList.
void setup() {
  size(1440,810);
  //Going through sprite names:
  spriteNames = loadStrings("data/SpriteNames.txt");
  for (String str : spriteNames) {
     sprite.add(loadImage("data/sprites/" + str + ".png"));
  }
  //Going through hud names:
  hudNames = loadStrings("data/hudNames.txt");
  for (String str : hudNames) {
     hud.add(loadImage("data/hud/" + str + ".png"));
  }
  //Going through screenNames:
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
  
  //Going through room and Overworld Objects. 
  objects = loadStrings("data/colosseum.txt");
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

  //Create vortex for monster-spawning area.
  vortex = roomObjects.get(roomObjects.size() - 1);
  portal = roomObjects.get(roomObjects.size() - 2);
  
  //Creates a new title screen.
  scr = new Screen(width/2 - 190, height - 115, width/2, 75, 75, "title");
  screens.add(scr);
  addMonsters();  

  //Player assets:
  playerNames = loadStrings("data/player_sprites.txt");
  for (String s : playerNames) {
    assets.add(loadImage("data/player_assets/" + s + ".png"));
  }
  //4 stands for # of sprites for each PHASE. Not the number of sprites in total. The value changes in differnet cases.
  //For dungeon: p = new Player(50,50, 700, 0,iT,4,assets);
  //Colosseum: 
  p = new Player(50, 50, 700, 175, iT, 4, assets);
  h = new HUD(p.m_health, 20, 20, 50);
}

void draw() {
    //Always displays screen if the array size > 0.
    if (screens.size() > 0) screens.get(0).display();
    //If the game is "running" which is determined by still having HP...
    else if(running){
      background(37,19,26);
      fill(0, 102, 153);
      for(int i = 0; i < roomObjects.size(); i++) {
        roomObjects.get(i).display();
      }

      //Creates null target in the beginning that will always be found later on.
      Monster target = null;
      if(spawnTime < 0 && m.size() < 5) {
            //Creates copy of a random monster chosen and adds it to an Array of monsters that are on the screen. Must be < 5 monsters.
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
      //Monster updates/calls. 
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
    }
    
    //Projectile Behavior.
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

      //Item behavior. (not iterating through array because Item behavior is different for potions. It's just randomny spawning.)
      if(itemTime == 0 && allItems.size() < 10) {
        Random rand = new Random();
        if(rand.nextInt(1) == 2) {
          allItems.add(new Item(((float)rand.nextInt(1000) + vortex.x_pos - 500), ((float)rand.nextInt(700) + vortex.y_pos - 200), 50, 50, loadImage("data/items/smallPotion.png"), 5)); 
        }
        else {
          allItems.add(new Item(((float)rand.nextInt(1000) + vortex.x_pos - 500), ((float)rand.nextInt(700) + vortex.y_pos - 200), 50, 50, loadImage("data/items/largePotion.png"), 6));
        }
        //Long time to spawn.
        itemTime = 500;
      }
      else {
        itemTime--;
      }
      
      //Display all items part of the arraylist above.
      for(Item i : allItems) {
        noTint();
        i.display();
      }
      
      //Player behavior:
      p.update(h);
      p.move();
      p.display();
      
      //HUD Behavior:
      h.update(p.c_health);
      h.display();
    }
    else {
      clear();
    }
}

void keyPressed() {
  //If key is pressed and certain reqs are made, it will restart the game or move your character in your designated direction.
  if (screens.size() > 0) {
    if(screens.get(0).select(keyCode) == true) {
      restart();
    }
  }
  else if(running) {
    p.setMove(keyCode, true, m);
  }
}

void keyReleased() {
  //De-registers key input.
  p.setMove(keyCode, false, m);
}

//Clears everything on the screen when reaching gameOver.
void clear() {
  if(p.c_health <= 0) screens.add(new Screen(width/2, height/2, width/2, 50, 50, "game_over"));
}

//Method called to restart the game with a title screen after pressing 'R' in gameover.
void restart() {
          p.c_health = p.m_health;
          p.xChange = 750;
          p.yChange = 750;
          p.x_pos = 750;
          p.y_pos = 750;
          h.score = 0;
          m.clear();
          mSpawn.clear();
          screens.clear();  
          screens.add(new Screen(width/2 - 190, height - 115, width/2, 75, 75, "title"));
          addMonsters();
          running = true;
}

//Adds new monsters to an ArrayList mSpawn. This is because vortex.x_pos changes when you move down or up as the player.
void addMonsters() {
  //Adds all monsters again because vortex.x_pos has changed.
  //Monster(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss, (float reach), int sco) {
          s = new Slime(vortex.x_pos, vortex.y_pos, 50, 50, 1, 200.0, 1, 4, 120, iT, .5, false, 50);
          s2 = new Slime(vortex.x_pos, vortex.y_pos, 50, 50, 1, 200.0, 1, 4, 180, iT, .5, true, 100);
          d = new Baby(vortex.x_pos, vortex.y_pos, 90, 90, 1.5, 250.0, 3, 10, 120, iT, .75, false, 75);
          d2 = new Baby(vortex.x_pos, vortex.y_pos, 75, 75, 1.5, 250.0, 3, 10, 120, iT, .75, true, 150);
          min = new Minotaur(vortex.x_pos, vortex.y_pos, 150, 150, 1.5, 300.0, 5, 4, 120, iT, 1, false, 150, 200);
          min2 = new Minotaur(vortex.x_pos, vortex.y_pos, 150, 150, 1.5, 300.0, 3.5, 4, 120, iT, 1, true, 150, 400);
          b = new Boar(vortex.x_pos, vortex.y_pos, 65, 65, 2.5, 300.0, 4, 8, 120, iT, .5, false, 100);
          b2 = new Boar(vortex.x_pos, vortex.y_pos, 65, 65, 2.5, 300.0, 4, 8, 120, iT, .5, true, 200);
          sp = new Spirit(vortex.x_pos, vortex.y_pos, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, false, 225);
          sp2 = new Spirit(vortex.x_pos, vortex.y_pos, 100, 100, 1.5, 300.0, 3, 10, 120, iT, 1, true, 450);
          g = new Griffin(vortex.x_pos, vortex.y_pos, 150, 150, 1.5, 300.0, 5, 10, 120, iT, .75, false, 150, 200);
          g2 = new Griffin(vortex.x_pos, vortex.y_pos, 150, 150, 1.5, 300.0, 5, 10, 120, iT, .75, true, 150, 400);
          dr = new Dragon(vortex.x_pos, vortex.y_pos, 100, 100, 1.5, 300.0, 5, 10, 120, iT, 1, false, 250);
          dr2 = new Dragon(vortex.x_pos, vortex.y_pos, 100, 100, 1.5, 300.0, 4, 10, 120, iT, .75, true, 500);
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
}
