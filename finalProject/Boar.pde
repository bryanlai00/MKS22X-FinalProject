class Boar extends Monster {
  String phase;
  float playerGenDir, reach, range = 100;;
  int cooldown, chargeTimer = 0, stopTimer = 0;
  Boar(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss) {
     super(xcor, ycor, x_size, y_size, spe, sight, mH, numSprites, pT, iT, dam, boss);
     for (int i = 0; i < spriteNames.length; i++) {
       if (spriteNames[i].contains("boar")) {
         localSprite.add(sprite.get(i));
         localSpriteName.add(spriteNames[i]);
       }
     }
     phase = "aoksdpok";
     chargeTimer = 45;
     stopTimer = -1;
     deathTimer = 40;
  }
  void attack(Thing target, float num) {
    if (cHealth > 0) ((Player)target).loseHealth(num);
  }
  void display() {
    imageMode(CENTER);
    if (updateImageDir()) frame = 0;
    if (playerInRange) {
      if (playerGenDir > 90 || playerGenDir < -90) {
        pushMatrix();
        translate(x_pos, y_pos);
        scale(-1.0, 1.0);
        image(localSprite.get(frame + index), 0,0);
        popMatrix();
      }
      else image(localSprite.get(frame + index), x_pos, y_pos);
    }
    else {
      if (currentDirection >= 90 || currentDirection < -90 || (currentDirection >= 90 && currentDirection < 270)) {
        pushMatrix();
        translate(x_pos, y_pos);
        scale(-1.0, 1.0);
        image(localSprite.get(frame + index), 0,0);
        popMatrix();
      }
      else image(localSprite.get(frame + index), x_pos, y_pos);
    }
    if (delay <= 5) delay ++;
    else {
      delay = 0;
      if (frame + 1 < num_sprites) frame ++;
      else frame = 0;
    }
    hBarDisplay();
  }
  void checkForPlayer(Player p) {
    if (dist(p.x_pos,p.y_pos,x_pos,y_pos) < sightDistance) {
      playerInRange = true;
    }
    else {playerInRange = false;}
  }
  void move(float direction) {
      x_pos += currentSpeed * Math.cos(radians(direction));
      y_pos += currentSpeed * Math.sin(radians(direction));
  }
  boolean updateImageDir() {
    String temp = phase;
    if (cHealth <= 0) {phase = "death"; deathTimer--;}
    else if (playerInRange) {
      if (chargeTimer == 90) currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos))); stopTimer--;
      if (chargeTimer == 0) {stopTimer = 80; playerGenDir = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos))); chargeTimer--;}
      else chargeTimer--;
      if (stopTimer == 0) {chargeTimer = 90;}
      else stopTimer--;
      if (chargeTimer > 0) phase = "move";
      if (stopTimer > 0) phase = "stop";
    }
    else if (isMoving()) phase = "move";
    else phase = "idle";
    if (!playerInRange) {chargeTimer = 90; stopTimer = -1;}
    if (!temp.equals(phase)) {
      for (int i = 0; i < localSpriteName.size(); i++) {
        if (localSpriteName.get(i).contains(phase)) {
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
        if (chargeTimer > 0){
          currentSpeed = speed * 2;
          if (isTouching(p)) attack(p, damage);
        }
        else if (stopTimer > 0) currentSpeed = .5 * speed;
        else currentSpeed = 0;
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
