class Projectile extends Thing {
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  float endX, endY;
  Projectile(float x, float y, float eX, float eY) {
    super(x,y);
    endX = eX;
    endY = eY;
  }
  void display() {
  }
}