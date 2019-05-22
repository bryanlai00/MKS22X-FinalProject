class Slime extends Monster {
  Slime(float xcor, float ycor, float x_size, float y_size, float spe, float sight, float mH, int numSprites, int pT, int iT, float dam, boolean boss) {
     super(xcor, ycor, x_size, y_size, spe, sight, mH, numSprites, pT, iT, dam, boss);
  for (int i = 0; i < spriteNames.length; i++) {
     if (spriteNames[i].contains("slime")) {
       localSprite.add(sprite.get(i));
       localSpriteName.add(spriteNames[i]);
     }
  }
  }
  void attack(Thing target, float num) {
    ((Player)target).loseHealth(num);
  }
  void move(float direction) {
      x_pos += currentSpeed * Math.cos(radians(direction));
      y_pos += currentSpeed * Math.sin(radians(direction));
  }
  void updateBehavior(Player p) {
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
