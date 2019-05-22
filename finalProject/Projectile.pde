class Projectile extends Thing {
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  float x_pos, y_pos, endX, endY, damage, direction, speed;
  int duration, index;
  PImage sprite;
  Projectile(float xcor, float ycor, float xSize, float ySize, float dam, float spe, int d, PImage i, Player p) {
    super(xSize,ySize);
    endX = p.getX();
    endY = p.getY();
    x_pos = xcor;
    y_pos = ycor;
    damage = dam;
    speed = spe;
    duration = d;
    sprite = i;
    direction = (float)Math.toDegrees(Math.atan2((double)(endY - y_pos), (double)(endX - x_pos)));
  }
  void update() {
    if (duration < 0) {
      projectiles.remove(index);
    }
    else duration--;
  }
  void move() {
    imageMode(CENTER);
    x_pos += speed * Math.cos(radians(direction));
    y_pos += speed * Math.sin(radians(direction));
  }
  void setIndex(int i) {
   index = i; 
  }
  int getIndex() {
   return index;
  }
  void display() {
    imageMode(CENTER);
    image(sprite, x_pos, y_pos, getX_size(), getY_size());
  }
}
