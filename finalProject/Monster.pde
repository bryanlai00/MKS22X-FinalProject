abstract class Monster extends Thing implements Damageable, Movable{
  /**
   * num_sprites = number of sprites in the current phase
   * delay = used for delay tracking between frames
   * frame = current frame to be displayed of a phase
   * pathTimer & pathTime = sets timers for intervals of monsters randomly wandering around their spawnpoint
   * index = keeps track of position of the current phase of sprites to use in the ArrayList of sprites
   * invulTimer & invulTime = timer for granting short invulnerability after getting damaged, determines flashing red when hit
   * healthTimer = keeps track of how long to display health bar
   * deathTimer = how long to display dying monster's animation before removing it
   * score = how much score to add when killed
   * currentDirection, currentSpeed, sightDistance, damage = monster stats and conditions
   * cHealth, mHealth = current health and max health
   * localSprite, localSpriteName = contains sprites and sprite names corresponding to the specific type of monster it is (i.e. if Dragon, only contains Dragon sprites)
   * if (isBoss) = monster is bigger, slower, has a larger hitbox, and does more damage (may also have more reach/sight where applicable)
   * playerInRange = boolean checking to see if player is in range of the monster and provide trigger for monster's behavior
   */
  int num_sprites, delay = 0, frame = 0, pathTimer, pathTime, index, invulTimer, invulTime, healthTimer, deathTimer, score;
  float x_pos, y_pos, spawnX, spawnY, healthBarSize, currentDirection, speed, currentSpeed, sightDistance, damage, cHealth, mHealth;
  ArrayList<PImage> localSprite = new ArrayList<PImage>();
  ArrayList<String> localSpriteName = new ArrayList<String>();
  boolean isBoss, playerInRange;
  String currentDir;
  //Getter methods
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  int getDeathTimer() {return deathTimer;}
  
  Monster(float xcor, float ycor, float x_si, float y_si, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss, int sco) {
    super(x_si, y_si);
    if (boss) {x_si *= 1.25; y_si *= 1.25; spe *= .85; sight *= 1.25; mH *= 2; dam *= 1.5;}
    x_size = x_si;
    y_size = y_si;
    healthBarSize = x_size;
    x_pos = xcor;
    y_pos = ycor;
    spawnX = xcor;
    spawnY = ycor;
    speed = spe;
    currentSpeed = spe;
    sightDistance = sight;
    mHealth = mH;
    cHealth = mH;
    num_sprites = numSprites;
    pathTimer = pT;
    pathTime = pT;
    damage = dam;
    invulTimer = iT;
    invulTime = iT;
    isBoss = boss;
    playerInRange = false;
    currentDir = "aosndoipanf";
    index = 0;
    deathTimer = 10 * numSprites;
    score = sco;
  }
  //Displays the health bar over monster's sprite for a certain duration of time after being damaged
  void hBarDisplay() {
    if (healthTimer > 0) {
      healthTimer--;
      noStroke();
      fill(0,255,0);
      if (cHealth < 0) cHealth = 0;
      rect(x_pos - .5 * healthBarSize, y_pos - 50, healthBarSize * (cHealth / mHealth), 10);
      stroke(0,0,0);
      noFill();
      rect(x_pos - .5 * healthBarSize, y_pos - 50, healthBarSize, 10);
    }
  }
  //Decreases the current health by num
  void loseHealth(float num) {
    if (invulTimer == invulTime) {
      cHealth -= num;
      invulTimer = 0;
      healthTimer = 240;
    }
  }
  //Default playerInRange updating method
  void checkForPlayer(Player p) {
    if (dist(p.x_pos,p.y_pos,x_pos,y_pos) < sightDistance) {
      playerInRange = true;
      currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
    }
    else playerInRange = false;
  }
  boolean isMoving() {
    return currentSpeed > 0;
  }
  //Updates invulnerability time after getting damaged, also determines flashing red
  void updateInvul() {
    if (invulTimer < invulTime) {
      invulTimer++;
      if (invulTimer % 10 < 5) tint(255, 0, 0);
      else noTint();
    }
    else noTint();
  }
  //Calls update methods
  void update(Player p) {
    updateInvul();
    updateBehavior(p);
  }
  //Moves the monster in direction at currentSpeed, keeps the monsters in bounds
  void move(float direction) {
    for(OverworldObject o : collideableRoomObjects) {
      if(isTouching(o)) {
        if(dist(x_pos + currentSpeed * (float) Math.cos(radians(direction)), y_pos + currentSpeed * (float) Math.sin(radians(direction)), o.getX(), o.getY())
        < dist(x_pos, y_pos, o.getX(), o.getY())) {
           direction = degrees((float)Math.atan2(o.getY() - y_pos, o.getX() - x_pos)) * -1;
         }
      }
    }  
      x_pos += currentSpeed * Math.cos(radians(direction));
      y_pos += currentSpeed * Math.sin(radians(direction));
  }
  abstract void display();
  abstract boolean updateImageDir();
  abstract void updateBehavior(Player p);
  abstract void attack(Thing other, float num);
}
