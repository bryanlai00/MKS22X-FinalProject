class OverworldObject extends Thing implements Collideable {
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  PImage sprite;
  ArrayList<PImage> sprites;
  int num_sprites, frame = 0, delay = 0, sprite_index;
  //Value to see if the overworldObject is an item.
  boolean blocking;
  
  OverworldObject(float x_pos, float y_pos, float x_size, float y_size, PImage sprite, boolean blocking) {
    super(x_pos,y_pos);
    this.x_pos = x_pos;
    this.y_pos = y_pos;
    this.x_size = x_size;
    this.y_size = y_size;
    this.sprite = sprite;
    sprite.resize((int) x_size, (int) y_size);
    this.blocking = blocking;
  }
  
    OverworldObject(float x_pos, float y_pos, float x_size, float y_size, ArrayList<PImage> sprites, boolean blocking, int num_sprites) {
    super(x_pos,y_pos);
    this.x_pos = x_pos;
    this.y_pos = y_pos;
    this.x_size = x_size;
    this.y_size = y_size;
    this.sprites = sprites;
    for(int i = 0; i < sprites.size(); i++) {
      sprites.get(i).resize((int) x_size, (int) y_size);
    }
    this.blocking = blocking;
    this.num_sprites = num_sprites;
  }
  
  void display() {
      noTint();
      if(num_sprites != 0) {
        image(sprites.get(frame + sprite_index), x_pos, y_pos, x_size, y_size);
        if (delay <= 10) delay ++;
        else {
          delay = 0;
        if (frame + 1 < num_sprites) frame ++;
        else frame = 0;
        }
      }
      else {
      image(sprite, x_pos, y_pos);
      }
      //problem occurs because the background overrites it.
  }
  
  //Has boolean isTouching from abstract Thing class.
  boolean isTouching(Thing other) {
    //If the object/sprite is supposed to act as a boundary: blocking = true. if not, blocking = false (like a tile).
    return super.isTouching(other);
    //Return false if it is not blocking and it solely acts like a tile.
  }
}
