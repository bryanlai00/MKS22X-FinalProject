class Dragon extends Monster {
  boolean reachable;
  PImage projectile;
  String phase;
  float playerGenDir, reach = 120, range = 110;
  int cooldown, attackPhase, attackDelay = -1;
  Dragon(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss, int sco) {
     super(xcor, ycor, x_size, y_size, spe, sight, mH, numSprites, pT, iT, dam, boss, sco);
  for (int i = 0; i < spriteNames.length; i++) {
     if (spriteNames[i].contains("dragon")) {
       localSprite.add(sprite.get(i));
       localSpriteName.add(spriteNames[i]);
     }
     else if (spriteNames[i].contains("fireball")) {
       projectile = sprite.get(i);
     }
  }
     phase = "aoksdpok";
     attackPhase = 0;
     deathTimer = 65;
  }
  //Copying:
  Dragon(Dragon copy) {
    this(copy.x_pos, copy.y_pos, copy.x_size, copy.y_size, copy.speed, copy.sightDistance, copy.mHealth, copy.num_sprites, copy.pathTimer, copy.invulTimer, copy.damage, copy.isBoss, copy.score);
  }
  //Attack: If playerInRange, slashes if reachable, else spawns five projectiles
  void attack(Thing target, float num) {
    attack(target, num, reachable);
  }
  void attack(Thing target, float num, boolean rea) {
    if (rea) {
      float coneSliceAngle = degrees(PI/2);
      //If the distance is greater than the range, return and iterate with the next monster.
      if(dist(x_pos, y_pos, ((Player)target).getX(), ((Player)target).getY()) > reach) {
        return;
      }
      else {
        float anglePosition = degrees((float)Math.atan2(((Player)target).getY() - y_pos, ((Player)target).getX() - x_pos));
        textSize(13);
        text("Angle between monster and player: " + anglePosition, 100, 130);    
        //If angle is less than 0:
        float rightConstraint = currentDirection + coneSliceAngle;
        float leftConstraint = currentDirection - coneSliceAngle;
        if(anglePosition < rightConstraint && anglePosition > leftConstraint) {
          ((Player)target).loseHealth(num);
        }
        print("\n anglePosition: " + anglePosition);
        arc(x_pos, y_pos, reach, reach, radians(currentDirection) - PI/2, PI/2 + radians(currentDirection));
      }
    }
    else {
      int p_size = 35;
      if (isBoss) p_size = 50;
      projectiles.add(0, new Projectile(x_pos, y_pos, p_size, p_size, num, 5, 60, projectile, (Player)target, 0));
      projectiles.add(0, new Projectile(x_pos, y_pos, p_size, p_size, num, 5, 60, projectile, (Player)target, 35));
      projectiles.add(0, new Projectile(x_pos, y_pos, p_size, p_size, num, 5, 60, projectile, (Player)target, -35));
      projectiles.add(0, new Projectile(x_pos, y_pos, p_size, p_size, num, 5, 60, projectile, (Player)target, 70));
      projectiles.add(0, new Projectile(x_pos, y_pos, p_size, p_size, num, 5, 60, projectile, (Player)target, -70));
    }
  }
  //Updates the playerInRange boolean, determines if player is reachable
  void checkForPlayer(Player p) {
    if (dist(p.x_pos,p.y_pos,x_pos,y_pos) < sightDistance) {
      playerInRange = true;
      currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
      if (Math.abs(p.x_pos - x_pos) < range && Math.abs(p.y_pos - y_pos) < y_size / 4) reachable = true;
      else reachable = false;
    }
    else {playerInRange = false; reachable = false;}
  }
  //Updates the monster's phase being displayed to call the correct sprites
  boolean updateImageDir() {
    String temp = phase;
    if (cHealth <= 0) {phase = "death"; deathTimer--; num_sprites = 10;}
    else if (attackPhase == 0) {
      if (playerInRange) {
        if (reachable && cooldown < 40) {phase = "slash"; attackPhase = 40; num_sprites = 8;}
        else if (!reachable) {phase = "forspit"; attackPhase = 55; num_sprites = 11;}
        else {phase = "idle"; num_sprites = 8;}
      }
      else if (isMoving()) {phase = "move"; num_sprites = 10;}
      else {phase = "idle"; num_sprites = 8;}
    }
    else attackPhase--;
    
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
  //Calls checkForPlayer function, changes current speed/direction and calls attack function based on player's proximity and location
  void updateBehavior(Player p) {
    playerGenDir = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
    if (cHealth <= 0) currentSpeed = 0;
    else {
      checkForPlayer(p);
      if (playerInRange) {
          currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
          currentSpeed = 0;
          if (cooldown == 0) {cooldown = 75; attackDelay = 10;}
          else cooldown--; 
          if (attackDelay == 0) attack(p, damage);
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
  }
    attackDelay--;
  }
  //Displays the sprites and/or health of the monster
  void display() {
    imageMode(CENTER);
    if (updateImageDir()) frame = 0;
    x_size = localSprite.get(frame + index).width;
    y_size = localSprite.get(frame + index).height;
    if (isBoss) {x_size *= 1.5; y_size *= 1.5;}
    if (playerInRange) {
      if (playerGenDir >= 90 || playerGenDir < -90) {
        pushMatrix();
        translate(x_pos, y_pos);
        scale(-1.0, 1.0);
        image(localSprite.get(frame + index), 0, 0 , x_size, y_size);
        popMatrix();
      }
      else image(localSprite.get(frame + index), x_pos, y_pos, x_size, y_size);
    }
    else {
      if (currentDirection >= 90 || currentDirection < -90 || (currentDirection >= 90 && currentDirection < 270)) {
        pushMatrix();
        translate(x_pos, y_pos);
        scale(-1.0, 1.0);
        image(localSprite.get(frame + index), 0, 0, x_size, y_size);
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
