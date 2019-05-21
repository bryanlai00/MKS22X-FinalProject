class Projectile extends Thing {
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  float endX, endY, damage;
  Projectile(float x, float y, float eX, float eY, float dam) {
    super(x,y);
    endX = eX;
    endY = eY;
    damage = dam;
  }
  void display() {
  }
}