class Player extends Thing implements Damageable, Collideable {
  int c_health, m_health, damage, gaugeValue, num_sprites;
  float x_pos, y_pos, x_size, y_size, direction;
  boolean isMoving, isRunning;
  boolean isLeft, isRight, isUp, isDown;
  int[] abilities;
  PImage sprite;
  
  //Takes in size then pos.
  Player(int x_size, int y_size, int x_pos, int y_pos, PImage s) {
    super(x_size,y_size);
    this.x_size = x_size;
    this.y_size = y_size;
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
    sprite.resize(x_size,y_size);
    //Takes in pos then size.
  }
  
  void display() {
    image(sprite,x_pos,y_pos);
  }
  
  void loseHealth(float num) {
    c_health -= (int) num;
  }
  
  boolean isTouching(Thing other) {
    return dist(x_pos,y_pos,other.x_pos,other.y_pos) < x_size;
  }
  
  void attack(float num) {
    
  }
  
  void move() {
    //Calculating radius.
    double f = Math.pow(x_size, 2);
    double s = Math.pow(y_size, 2);
    float r = (float)Math.sqrt(f + s); 
    float speed;
    if(isRunning) {
      speed = 4;
    }
    else {
      speed = 2;
    }
    //Makes sure that the position does not go out.
    float xChange = x_pos + speed*(int(isRight) - int(isLeft));
    float yChange = y_pos + speed*(int(isDown) - int(isUp));
    x_pos = constrain(xChange, r, width  - r);
    y_pos = constrain(yChange, r, height - r);
  }
  
  boolean setMove(int k, boolean b) {
    //Create switch/case to set the boolean variables for up, down, left and right.
    switch (k) {
    case UP:
      return isUp = b;
 
    case DOWN:
      return isDown = b;
 
    case LEFT:
      return isLeft = b;
 
    case RIGHT:
      return isRight = b;
 
    default:
      return b;
    }
  }
}
