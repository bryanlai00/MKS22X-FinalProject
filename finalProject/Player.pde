class Player extends Thing implements Damageable, Collideable {
  int c_health, m_health, damage, gaugeValue, num_sprites, sprite_index, delay = 0, frame = 0;
  String lastDirection;
  float x_pos, y_pos, x_size, y_size, directionAngle;
  boolean isMoving, isRunning;
  boolean isLeft, isRight, isUp, isDown;
  int[] abilities;
  ArrayList<PImage> localSprites = new ArrayList<PImage>();
  
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  
  //Takes in size then pos.
  Player(int x_size, int y_size, int x_pos, int y_pos, int num_sprites, ArrayList<PImage> ls) {
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
    this.num_sprites = num_sprites;
    this.localSprites = ls;
    sprite_index = 0;
    //Takes in pos then size.
  }
  
  void display() {
    //Changes sprite_index based on buttons pressed.
      /* IF RUNNING Sprites Indexes 4-11*/
      print("isRight: " + isRight);
      print("isLeft: " + isLeft);
      print("isUp: " + isUp);
      print("isDown: " + isDown);
    if(isMoving) {
      if(isRight) {
        sprite_index = 8;;
      }
      else if(isLeft) {
        sprite_index = 12;;
      }
    }
    else {
      if(isLeft) {
        sprite_index = 4;
      }
      else if(isRight){
        sprite_index = 0;
      }
    }
    image(localSprites.get(frame + sprite_index), x_pos, y_pos, x_size, y_size);
    if (delay <= 10) delay ++;
    else {
      delay = 0;
      if (frame + 1 < num_sprites) frame ++;
      else frame = 0;
    }
  }
  
  void loseHealth(float num) {
    c_health -= (int) num;
  }
  
  boolean isTouching(Thing other) {
    //System.out.print(getX() + ", " + getY() + "   ");
    //System.out.print(dist(getX(), getY() , other.getX(), other.getY()) + "   ");
    return dist(getX(), getY() , other.getX(), other.getY()) < x_size;
  }
  
  void attack(Thing other, float num) {
  }
  
  void move() {
    //Calculating radius.
    double f = Math.pow(x_size, 2);
    double s = Math.pow(y_size, 2);
    float r = (float)Math.sqrt(f + s); 
    /*Speed for movement 4 for running, 2 for normal*/
    float speed;
    if(isRunning) {
      speed = 4;
    }
    else {
      speed = 2;
    }
    
    //Makes sure that the position does not go out.
    //Used to see if the position changes to determine if something moves.
    float x_prev_pos = x_pos;
    float y_prev_pos = y_pos;
    float xChange = x_pos + speed*(int(isRight) - int(isLeft));
    float yChange = y_pos + speed*(int(isDown) - int(isUp));
    //List of x-statements to find angleDirection:
    //For basical cardinal directions:
        if(isRight) {
          directionAngle = 0;
        }
        else if(isLeft) {
          directionAngle = 180;
        }
        else if(isDown) {
          directionAngle = 270;
        }
        else if(isUp) {
          directionAngle = 90;
        }
    //For combined directionAngles:
        if(isRight && isUp) {
          directionAngle = 45;
        }
        else if(isRight && isDown) {
          directionAngle = 315;
        }
        else if(isLeft && isUp) {
          directionAngle = 135;
        }
        else if(isLeft && isDown) {
          directionAngle = 225;
        }
        
    //See if moving.
    
    x_pos = constrain(xChange, r, width  - r);
    y_pos = constrain(yChange, r, height - r);
    if(x_prev_pos != x_pos || y_prev_pos != y_pos) {
      isMoving = true;
      print("isMoving is true \n");
    }
    else {
      isMoving = false;
      print("isMoving is false \n"); 
    }
  }
  
  boolean setMove(int k, boolean b) {
    //Create switch/case to set the boolean variables for up, down, left and right.
    switch (k) {
    case UP:
      return isUp = b;
 
    case DOWN:
      return isDown = b;
 
    case LEFT:
      lastDirection = "left";
      return isLeft = b;
 
    case RIGHT:
      lastDirection = "right";
      return isRight = b;
     
    case 'X':
      isRunning = true;
      return isRunning;
      
    case 'C':
      isRunning = false;
      return isRunning;
      
    case 'Z':
      arc(50, 50, 80, 80, 0, PI+QUARTER_PI, PIE);
 
    default:
      return b;
    }
  }
}
