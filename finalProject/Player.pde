<<<<<<< HEAD
class Player extends Thing {
   float x, y;
   Player(float xcor, float ycor, float x_size, float y_size) {
    super(x_size,y_size);
    x = xcor;
    y = ycor;
=======
class Player extends Thing implements Damageable, Collideable {
  int c_health, m_health, damage, gaugeValue, num_sprites;
  float x_pos, y_pos, x_size, y_size;
  boolean isMoving, isRunning;
  boolean isLeft, isRight, isUp, isDown;
  int[] abilities;
  PImage sprite;
  
  //Takes in size then pos.
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
    sprite.resize(x_size,y_size);
    //Takes in pos then size.
>>>>>>> 8a78e3f534dab5270b5c21ba314ceaab4f8c29d6
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
    imageMode(CENTER);
    //Calculating radius.
    double f = Math.pow(x_size, 2);
    double s = Math.pow(y_size, 2);
    float r = (float)Math.sqrt(f + s) / 2; 
    //Makes sure that the position does not go out.
    x_pos = constrain(x_pos + 2*(int(isRight) - int(isLeft)), r, width  - r);
    y_pos = constrain(y_pos + 2*(int(isDown)  - int(isUp)),   r, height - r);
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
