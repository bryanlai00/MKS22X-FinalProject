abstract class Monster extends Thing implements Damageable, Movable{
  int num_sprites, delay = 0, frame = 0, pathTimer, pathTime, index, invulTimer, invulTime, healthTimer, deathTimer;
  float x_pos, y_pos, spawnX, spawnY, healthBarSize, currentDirection, speed, currentSpeed, sightDistance, damage, cHealth, mHealth;
  ArrayList<PImage> localSprite = new ArrayList<PImage>();
  ArrayList<String> localSpriteName = new ArrayList<String>();
  boolean isBoss, playerInRange;
  String currentDir;
  
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  int getDeathTimer() {return deathTimer;}
  
  Monster(float xcor, float ycor, float x_si, float y_si, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss) {
    super(x_si, y_si);
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
  }
  void display() {
    imageMode(CENTER);
    if (updateImageDir()) frame = 0;
    image(localSprite.get(frame + index), x_pos, y_pos, x_size, y_size);
    if (delay <= 10) delay ++;
    else {
      delay = 0;
      if (frame + 1 < num_sprites) frame ++;
      else frame = 0;
    }
    hBarDisplay();
  }
  void hBarDisplay() {
    if (healthTimer > 0) {
      healthTimer--;
      noStroke();
      fill(0,255,0);
      rect(x_pos - .5 * healthBarSize, y_pos - 50, healthBarSize * (cHealth / mHealth), 10);
      stroke(0,0,0);
      noFill();
      rect(x_pos - .5 * healthBarSize, y_pos - 50, healthBarSize, 10);
    }
  }
  void loseHealth(float num) {
    if (invulTimer == invulTime) {
      cHealth -= num;
      invulTimer = 0;
      healthTimer = 240;
    }
  }
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
  //void initiateDeath() {
  //  int count = 0;
  //  for (int i = 0; i < localSpriteName.size(); i++) {
  //   if (localSpriteName.get(i).contains("death")) count++;
  //  }
    
  //}
  boolean updateImageDir() {
    String temp = currentDir;
    if (cHealth <= 0) {currentDir = "death"; currentSpeed = 0; deathTimer--;}
    else if (currentDirection <= 45 && currentDirection > -45) currentDir = "right";
    else if (currentDirection <= 135 && currentDirection > 45) currentDir = "down";
    else if (currentDirection <= -135 || currentDirection > 135) currentDir = "left";
    else if (currentDirection <= -45 && currentDirection > -135)currentDir = "up";
    if (!temp.equals(currentDir)) {
      for (int i = 0; i < localSpriteName.size(); i++) {
        if (localSpriteName.get(i).contains(currentDir)) {
          index = i;
          return true;
        }
      }
    }
    return false;
  }
  void updateInvul() {
    if (invulTimer < invulTime) {
      invulTimer++;
      if (invulTimer % 10 < 5) tint(255, 0, 0);
      else noTint();
    }
    else noTint();
  }
  void update(Player p) {
    updateInvul();
    updateBehavior(p);
  }
  abstract void updateBehavior(Player p);
  abstract void attack(Thing other, float num);
  abstract void move(float direction);
}
