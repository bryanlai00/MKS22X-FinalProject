class OverworldObject extends Thing {
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  
  OverworldObject(float x, float y) {
    super(x,y);
  }
  void display() {
  }
}
