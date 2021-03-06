class Baby extends Monster {
  boolean safe;
  PImage projectile;
  String phase;
  float sRF, playerGenDir;
  int cooldown;
  Baby(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss, int sco) {
     super(xcor, ycor, x_size, y_size, spe, sight, mH, numSprites, pT, iT, dam, boss, sco);
  for (int i = 0; i < spriteNames.length; i++) {
     if (spriteNames[i].contains("baby")) {
       localSprite.add(sprite.get(i));
       localSpriteName.add(spriteNames[i]);
     }
     else if (spriteNames[i].contains("fireball")) {
       projectile = sprite.get(i);
     }
  }
  sRF = sight/3;
  phase = "aoksdpok";
  cooldown = 0;
  deathTimer = 50;
  }
  //Copying:
  Baby(Baby copy) {
    this(copy.x_pos, copy.y_pos, copy.x_size, copy.y_size, copy.speed, copy.sightDistance, copy.mHealth, copy.num_sprites, copy.pathTimer, copy.invulTimer, copy.damage, copy.isBoss, copy.score);
  }
  //Attack: spawns a new projectile headed in the player's direction using the sprite stored (fireball)
  void attack(Thing target, float num) {
    projectiles.add(0, new Projectile(x_pos, y_pos, 35, 35, num, 5, 60, projectile, (Player)target));
  }
  //Updates the playerInRange boolean, determines if it is a safe distance from player
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
  //Calls checkForPlayer function, changes current speed/direction and calls attack function based on player's proximity and location
  void updateBehavior(Player p) {
    checkForPlayer(p, sRF);
    playerGenDir = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
    currentSpeed = speed;
    if (playerInRange) {
        if (cooldown == 0) {attack(p, damage); cooldown = 120;}
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
  //Updates the monster's phase being displayed to call the correct sprites
  boolean updateImageDir() {
    String temp = phase;
    if (cHealth <= 0) {phase = "death"; deathTimer--;}
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
  //Displays the sprites and/or health of the monster
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
    noTint();
  }
}
