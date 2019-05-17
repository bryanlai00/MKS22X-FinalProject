abstract class Monster extends Thing implements Damageable, Movable{
  int damage, cHealth, mHealth, num_sprites;
  float x, y;
  PImage[] sprite;
  boolean isBoss;
  
  Monster(float xcor, float ycor, float x_size, float y_size, PImage image, int numSprites, boolean boss) {
    super(x_size, y_size);
    x = xcor;
    y = ycor;
    sprite = image;
    num_sprites = numSprites;
    isBoss = boss;
  }
  void display() {
    image(sprite, x, y, x_size, y_size);
  }
  void loseHealth(float num) {
    health -= num;
  }
  boolean isMoving() {
    return true;
  }
  abstract void attack(float num);
  abstract void move(float direction);
}