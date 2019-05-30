class Item extends Thing {
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  int itemValue;
  PImage sprite;
  
  public Item(float x_pos, float y_pos, float x_size, float y_size, PImage sprite, int itemValue) {
    super(x_pos, y_pos);
    this.x_pos = x_pos;
    this.y_pos = x_pos;
    this.x_size = x_size;
    this.y_size = y_size;
    this.sprite = sprite;
    sprite.resize((int) x_size, (int) y_size);
    this.itemValue = itemValue;
  }
  
  void display() {
    image(sprite, x_pos,y_pos);
  }
  
    //MAKE SURE THAT ITEMS ARE ADDED AT THE END OF THE ROOMS.TXT FILE.
  void addAbilityToPlayer(Player p) {
    if(itemValue != 0 && isTouching(p)) {
      //If the item touches the player, give the player that ability and add this # to the player's ability array.
      p.abilities[(int)itemValue] = (int)itemValue;
      //Remove Overworldobject from it.
    }
  }
}
