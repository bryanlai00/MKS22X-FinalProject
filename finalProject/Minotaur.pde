class Minotaur extends Monster {
  String phase;
  float playerGenDir, reach, range = 100;;
  int cooldown, attackPhase, attackDelay = -1;
  boolean reachable = false;
  Minotaur(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss, float rea) {
     super(xcor, ycor, x_size, y_size, spe, sight, mH, numSprites, pT, iT, dam, boss);
     reach = rea * 1.5;
     for (int i = 0; i < spriteNames.length; i++) {
       if (spriteNames[i].contains("minotaur")) {
         localSprite.add(sprite.get(i));
         localSpriteName.add(spriteNames[i]);
       }
     }
     phase = "aoksdpok";
     cooldown = 90;
     attackPhase = 0;
     deathTimer = 45;
  }
  void attack(Thing target, float num) {
    float coneSliceAngle = degrees(PI/2);
    //textSize(13);
    //text(dist(x_pos, y_pos, enemy.getX(), enemy.getY()), 100, 100);
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
      /*
      print("\n left constraint: " + leftConstraint);
      print("\n right constraint: " + rightConstraint);
      */
      if(anglePosition < rightConstraint && anglePosition > leftConstraint) {
        ((Player)target).loseHealth(num);
      }
      print("\n anglePosition: " + anglePosition);
      arc(x_pos, y_pos, reach, reach, radians(currentDirection) - PI/2, PI/2 + radians(currentDirection));
      //See if the difference angle is applicable for the coneSliceAngle:
    }
  }
  void display() {
    imageMode(CENTER);
    if (updateImageDir()) frame = 0;
    if (playerInRange) {
      if (playerGenDir > 45 || playerGenDir < -45) {
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
      currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
      if (dist(p.x_pos,p.y_pos,x_pos,y_pos) < range) reachable = true;
      else reachable = false;
    }
    else {playerInRange = false; reachable = false;}
  }
  void move(float direction) {
      x_pos += currentSpeed * Math.cos(radians(direction));
      y_pos += currentSpeed * Math.sin(radians(direction));
  }
  boolean updateImageDir() {
    String temp = phase;
    if (cHealth <= 0) {phase = "death"; num_sprites = 9; deathTimer--;}
    else if (attackPhase == 0) {
      if (playerInRange) {
        if (reachable && playerGenDir < 0 && cooldown < 40) {phase = "upswing"; num_sprites = 9; attackPhase = 45;}
        else if (reachable && playerGenDir >= 0 && cooldown < 40) {phase = "downswing"; num_sprites = 12; attackPhase = 45;}
        else if (reachable) {phase = "idle"; num_sprites = 5;}
        else {phase = "move"; num_sprites = 8;}
      }
      else if (isMoving()) {phase = "move"; num_sprites = 8;}
      else {phase = "idle"; num_sprites = 5;}
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
  void updateBehavior(Player p) {
    playerGenDir = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
    if (cHealth <= 0) currentSpeed = 0;
    else {
      checkForPlayer(p);
      if (playerInRange) {
        if (reachable){
          currentSpeed = 0;
          if (cooldown == 0) {cooldown = 120; attackDelay = 10;}
          else cooldown--;
          if (attackDelay == 0) attack(p, damage);
        }
        else {
          currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y_pos - y_pos), (double)(p.x_pos - x_pos)));
          currentSpeed = speed;
        }
      }
      else {
        cooldown = 180;
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
}
