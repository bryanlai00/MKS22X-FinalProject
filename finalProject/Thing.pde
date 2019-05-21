abstract class Thing implements Collideable {
  
  float x_size, y_size, x_pos, y_pos;
  
  abstract void display();
  abstract float getX();
  abstract float getY();
  abstract float getX_size();
  abstract float getY_size();
  
  public Thing(float x, float y) {
    x_size = x;
    y_size = y;
  }
    boolean isTouching(Thing other) {
    //System.out.print(dist(this.x_pos, this.y_pos , other.x_pos , other.y_pos) + "   ");
    
    return dist(getX(), getY() , other.getX(), other.getY()) < getX_size() || dist(getX(), getY() , other.getX(), other.getY()) < getY_size();
  }

}
