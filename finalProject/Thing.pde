abstract class Thing implements Collideable {
  
  float x_size, y_size, x_pos, y_pos;
  
  abstract void display();
  
  public Thing(float x, float y) {
    x_size = x;
    y_size = y;
  }
  
    boolean isTouching(Thing other) {
    return true;
  }

}
