class Monster extends Thing implements Damageable, Movable{
  int damage, health, num_sprites;
  float x, y;
  PImage sprite;
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
  void attack(float num) {
    
  }
  void move(float direction) {
    
  }
  boolean isMoving() {
    return true;
  }
}
