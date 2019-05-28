class OverworldObject extends Thing implements Collideable {
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  PImage sprite;
  boolean blocking, displayed = false;
  
  OverworldObject(float x_pos, float y_pos, float x_size, float y_size, PImage sprite, boolean blocking) {
    super(x_pos,y_pos);
    this.x_pos = x_pos;
    this.y_pos = y_pos;
    this.x_size = x_size;
    this.y_size = y_size;
    this.sprite = sprite;
    sprite.resize((int) x_size, (int) y_size);
  }
  
  void display() {
      image(sprite, x_pos, y_pos);
      //problem occurs because the background overrites it.
  }
  
  boolean isTouching(Thing other) {
    //If the object/sprite is supposed to act as a boundary: blocking = true. if not, blocking = false (like a tile).
    if(blocking) {
      if(dist(other.getX(), other.getY(), x_pos, y_pos) == 0) {
        return true;
      }
    }
    //Return false if it is not blocking and it solely acts like a tile.
    return false;
  }
  
}
