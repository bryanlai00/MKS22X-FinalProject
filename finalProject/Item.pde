class Item extends Thing {
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  float itemValue;
  PImage sprite;
  
  public Item(float x_pos, float y_pos) {
    super(x_pos, y_pos);
  }
  
  void display() {
  }
    //MAKE SURE THAT ITEMS ARE ADDED AT THE END OF THE ROOMS.TXT FILE.
  void addAbilityToPlayer(Player p) {
    if(itemValue != 0 && isTouching(p)) {
      //If the item touches the player, give the player that ability and add this # to the player's ability array.
      p.abilities[(int)itemValue] = (int)itemValue;
      //Remove Overworldobject from it.
      roomObjects.remove(this);
    }
  }
}
