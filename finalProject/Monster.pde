class Monster extends Thing implements Damageable{
  int damage, health, num_sprites;
  float x, y;
  PImage sprite;
  boolean isBoss;
  
  Monster(float xcor, float ycor, float x_size, float y_size, PImage image, int numSprites) {
    super(x_size, y_size);
    x = xcor;
    y = ycor;
    sprite = image;
    num_sprites = numSprites;
    isBoss = false;
  }
  void display() {
    ellipse(x,y,100,100);
  }
  void loseHealth(float num) {
    health -= num;
  }
  void attack(float num) {
    
  }
}
