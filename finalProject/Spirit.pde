class Spirit extends Monster {
  boolean safe;
  PImage projectile;
  String phase;
  float sRF, playerGenDir;
  int cooldown;
  Spirit(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss) {
     super(xcor, ycor, x_size, y_size, spe, sight, mH, numSprites, pT, iT, dam, boss);
  for (int i = 0; i < spriteNames.length; i++) {
     if (spriteNames[i].contains("spirit")) {
       localSprite.add(sprite.get(i));
       localSpriteName.add(spriteNames[i]);
     }
     else if (spriteNames[i].contains("shadowball")) {
       projectile = sprite.get(i);
     }
  }
  sRF = sight/3;
  phase = "aoksdpok";
  cooldown = 0;
  deathTimer = 55;
  }
  void attack(Thing target, float num) {
    projectiles.add(0, new Projectile(x_pos, y_pos, 35, 35, num, 5, 60, projectile, (Player)target, 0));
    projectiles.add(0, new Projectile(x_pos, y_pos, 35, 35, num, 5, 60, projectile, (Player)target, 45));
    projectiles.add(0, new Projectile(x_pos, y_pos, 35, 35, num, 5, 60, projectile, (Player)target, -45));
  }
  void move(float direction) {
      imageMode(CENTER);
      x_pos += currentSpeed * Math.cos(radians(direction));
      y_pos += currentSpeed * Math.sin(radians(direction));
  }
  void checkForPlayer(Player p, float safeRadiusDiff) {
    if (dist(p.x_pos,p.y_pos,x_pos,y_pos) < sightDistance) {
      playerInRange = true;
      currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
    }
    else playerInRange = false;
    if (dist(p.x_pos,p.y_pos,x_pos,y_pos) < sightDistance - safeRadiusDiff) {
      safe = false;
      currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
    }
    else safe = true;
  }
  void updateBehavior(Player p) {
    checkForPlayer(p, sRF);
    playerGenDir = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
    currentSpeed = speed;
    if (playerInRange) {
        if (cooldown == 0) {attack(p, damage); cooldown = 80;}
        else cooldown--;
        if (!safe) {
          currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos))) - 180;
        }
        else {
          currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
        }
    }
    else {
      cooldown = 0;
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
    if (cHealth <= 0) currentSpeed = 0;
  }
  boolean updateImageDir() {
    String temp = phase;
    if (cHealth <= 0) {phase = "death"; deathTimer--; num_sprites = 11;}
    else if (playerInRange) {
      phase = "attack";
    }
    else phase = "idle";
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
  void display() {
    imageMode(CENTER);
    if (updateImageDir()) frame = 0;
    if (playerInRange) {
      if (playerGenDir >= 90 || playerGenDir < -90) {
        pushMatrix();
        translate(x_pos, y_pos);
        scale(-1.0, 1.0);
        image(localSprite.get(frame + index), 0,0,x_size, y_size);
        popMatrix();
      }
      else image(localSprite.get(frame + index), x_pos, y_pos, x_size, y_size);
    }
    else {
      if (currentDirection >= 90 || currentDirection < -90 || (currentDirection >= 90 && currentDirection < 270)) {
        pushMatrix();
        translate(x_pos, y_pos);
        scale(-1.0, 1.0);
        image(localSprite.get(frame + index), 0,0,x_size, y_size);
        popMatrix();
      }
      else image(localSprite.get(frame + index), x_pos, y_pos, x_size, y_size);
    }
    if (delay <= 5) delay ++;
    else {
      delay = 0;
      if (frame + 1 < num_sprites) frame ++;
      else frame = 0;
    }
    hBarDisplay();
  }
}