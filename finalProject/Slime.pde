class Slime extends Monster {
  Slime(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss, int sco) {
     super(xcor, ycor, x_size, y_size, spe, sight, mH, numSprites, pT, iT, dam, boss, sco);
     for (int i = 0; i < spriteNames.length; i++) {
       if (spriteNames[i].contains("slime")) {
         localSprite.add(sprite.get(i));
         localSpriteName.add(spriteNames[i]);
       }
     }
     deathTimer = 40;
  }
  void display() {
    imageMode(CENTER);
    if (updateImageDir()) frame = 0;
    image(localSprite.get(frame + index), x_pos, y_pos, x_size, y_size);
    if (delay <= 5) delay ++;
    else {
      delay = 0;
      if (frame + 1 < num_sprites) frame ++;
      else frame = 0;
    }
    hBarDisplay();
  }
  void attack(Thing target, float num) {
    if (cHealth > 0) ((Player)target).loseHealth(num);
  }
  boolean updateImageDir() {
    String temp = currentDir;
    if (cHealth <= 0) {currentDir = "death"; currentSpeed = 0; deathTimer--; num_sprites = 8;}
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
  void updateBehavior(Player p) {
    if (cHealth <= 0) currentSpeed = 0;
    else {
      checkForPlayer(p);
      if (playerInRange) {
        if (isTouching(p)){
          currentSpeed = 0;
          attack(p, damage);
        }
        else {
          currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
          currentSpeed = speed;
        }
      }
      else {
        if (pathTimer <= pathTime && pathTimer > pathTime/2) currentSpeed = speed;
        else if (pathTimer <= 0 && pathTimer > -pathTime/2) {
          currentSpeed = speed;
          currentDirection = (float)Math.toDegrees(Math.atan2((double)(spawnY - y_pos), (double)(spawnX - x_pos)));
        }
        else if ((pathTimer <= pathTime/2 && pathTimer > 0) || (pathTimer <= -pathTime/2 && pathTimer > -pathTime)) currentSpeed = 0;
        else  {
          pathTimer = pathTime;
          currentDirection = (float)(Math.random() * 360 - 180);
        }
        pathTimer--;
      }
    }
  }
}
