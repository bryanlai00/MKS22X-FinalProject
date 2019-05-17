abstract class Thing {
  
  float x_size, y_size;
  
  abstract void display();
  
  public Thing(float x, float y) {
    x_size = x;
    y_size = y;
  }
  
}