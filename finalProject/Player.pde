class Player extends Thing {
  int c_health, m_health, damage, gaugeValue, num_sprites;
  float x_pos, y_pos, x_size, y_size, direction;
  boolean isMoving, isRunning;
  int[] abilities;
  PImage sprite;
  
  Player(int x_size, int y_size, int x_pos, int y_pos, PImage s) {
    super(x_size,y_size);
    this.x_pos = x_pos;
    this.y_pos = y_pos;
    m_health = 3;
    c_health = 3;
    damage = 1;
    //Boolean values are default set to false. 
    //# of abilties. All filled with 0 right now.
    abilities = new int[5];
    //The maximum value for this will be equal to 100.
    gaugeValue = 0;
    sprite = s;
  }
  
  void display() {
  }
}
