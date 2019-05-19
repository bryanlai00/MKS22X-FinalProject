class Slime extends Monster {
  Slime(float xcor, float ycor, float x_size, float y_size, float spe, float sight, int numSprites, int pT, boolean boss) {
     super(xcor, ycor, x_size, y_size, spe, sight, numSprites, pT, boss);
       for (String str : sp) {
         if (str.contains("slime")) sprite.add(loadImage("data/sprites/" + str + ".png"));
       }
     
  }
  void attack(float num) {}
  void move(float direction) {
    x += currentSpeed * Math.cos(radians(direction));
    y += currentSpeed * Math.sin(radians(direction));
  }
  void update() {
    if (pathTimer <= pathTime && pathTimer > pathTime/2) currentSpeed = speed;
    else if (pathTimer <= 0 && pathTimer > -pathTime/2) {
      currentDirection = (float)Math.toDegrees(Math.atan2((double)(spawnY - y), (double)(spawnX - x)));
      currentSpeed = speed;
    }
    else if ((pathTimer <= pathTime/2 && pathTimer > 0) || (pathTimer <= -pathTime/2 && pathTimer > -pathTime)) currentSpeed = 0;
    else  {
      pathTimer = pathTime;
      currentDirection = (float)(Math.random() * 360);
    }
    pathTimer--;
  }
}
