abstract class Monster extends Thing implements Damageable, Movable{
  int damage, cHealth, mHealth, num_sprites, delay = 0, frame = 0, pathTimer, pathTime;
  float x, y, spawnX, spawnY, currentDirection, speed, currentSpeed, sightDistance;
  ArrayList<PImage> sprite = new ArrayList<PImage>();
  boolean isBoss, playerInRange;
  
  Monster(float xcor, float ycor, float x_size, float y_size, float spe, float sight, int numSprites, int pT, boolean boss) {
    super(x_size, y_size);
    x = xcor;
    y = ycor;
    spawnX = xcor;
    spawnY = ycor;
    speed = spe;
    currentSpeed = spe;
    sightDistance = sight;
    num_sprites = numSprites;
    pathTimer = pT;
    pathTime = pT;
    isBoss = boss;
    playerInRange = false;
  }
  void display() {
    if (delay <= 10) delay ++;
    else {
      delay = 0;
      if (frame + 1 < num_sprites) frame ++;
      else frame = 0;
    }
    image(sprite.get(frame), x, y, super.x_size, super.y_size);
  }
  void loseHealth(float num) {
    cHealth -= num;
  }
  boolean isMoving() {
    return true;
  }
  void checkForPlayer(Player p) {
    if (Math.sqrt(Math.pow(p.x - x, 2) + Math.pow(p.y - y, 2)) < sightDistance) {
      playerInRange = true;
      currentDirection = (float)Math.toDegrees(Math.atan2((double)(p.y - y), (double)(p.x - x)));
    }
    else playerInRange = false;
  }
  abstract void attack(float num);
  abstract void move(float direction);
}
