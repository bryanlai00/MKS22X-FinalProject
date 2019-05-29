class Player extends Thing implements Damageable, Collideable {
  int m_health, damage, gaugeValue, num_sprites, sprite_index, delay = 0, frame = 0, invulTimer, invulTime;
  String lastDirection = "right";
  float x_pos, y_pos, x_size, y_size, directionAngle, c_health;
  boolean isMoving, isRunning;
  boolean isLeft, isRight, isUp, isDown;
  int[] abilities;
  ArrayList<PImage> localSprites = new ArrayList<PImage>();
  
  float getX() {return x_pos;}
  float getY() {return y_pos;}
  float getX_size() {return x_size;}
  float getY_size() {return y_size;}
  
  //Takes in size then pos.
  Player(int x_size, int y_size, int x_pos, int y_pos, int iT, int num_sprites, ArrayList<PImage> ls) {
    super(x_size,y_size);
    this.x_size = x_size;
    this.y_size = y_size;
    this.x_pos = x_pos;
    this.y_pos = y_pos;
    invulTimer = iT;
    invulTime = iT;
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
    if(isMoving) {
      if(lastDirection.equals("right")) {
        sprite_index = 8;;
      }
      else if(lastDirection.equals("left")) {
        sprite_index = 12;;
      }
    }
    else {
      if(lastDirection.equals("left")) {
        sprite_index = 4;
      }
      else if(lastDirection.equals("right")){
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
    if (invulTimer == invulTime) {
      c_health -= num;
      invulTimer = 0;
    }
  }
  
  boolean isTouching(Thing other) {
    //System.out.print(getX() + ", " + getY() + "   ");
    //System.out.print(dist(getX(), getY() , other.getX(), other.getY()) + "   ");
    return dist(getX(), getY() , other.getX(), other.getY()) < x_size;
  }
  
  void attack(Thing enemy, float num) {
    float range = 100;
    float coneSliceAngle = degrees(PI/4);
    textSize(13);
    text(dist(x_pos, y_pos, enemy.getX(), enemy.getY()), 100, 100);
    //If the distance is greater than the range, return and iterate with the next monster.
    if(dist(x_pos, y_pos, enemy.getX(), enemy.getY()) > range) {
      return;
    }
    else {
      float anglePosition = degrees((float)Math.atan2(enemy.getY() - y_pos, enemy.getX() - x_pos));
      //If angle is less than 0:
      float rightConstraint = directionAngle + coneSliceAngle;
      float leftConstraint = directionAngle - coneSliceAngle;
      /*
      print("\n left constraint: " + leftConstraint);
      print("\n right constraint: " + rightConstraint);
      */
      if(anglePosition < rightConstraint && anglePosition > leftConstraint) {
        ((Monster)enemy).cHealth--;
      }
      //print("\n anglePosition: " + anglePosition);  
      //See if the difference angle is applicable for the coneSliceAngle:
      
    }
  }
  
  void update() {
    if (invulTimer < invulTime) invulTimer++;
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
    float xChange = speed * (int(isRight) - int(isLeft));
    float yChange = speed * (int(isDown) - int(isUp));
    //print(x_pos + " " + y_pos);
    //Move all other entities by moving the map.
    if(x_pos < 940 && x_pos > 57 && y_pos < 940 && y_pos > 57) {
      for(int i = 0; i < roomObjects.size(); i++) {
        roomObjects.get(i).x_pos += -xChange;
        roomObjects.get(i).y_pos += -yChange;
      }
      for(int i = 0; i < m.size(); i++) {
        m.get(i).x_pos += -xChange;
        m.get(i).y_pos += -yChange;
      }
    }
    //List of x-statements to find angleDirection:
    //For basical cardinal directions:
        //print("direction angle" + directionAngle + "\n");
        if(isRight) {
          directionAngle = 0;
        }
        else if(isLeft) {
          directionAngle = 180;
        }
        else if(isDown) {
          directionAngle = 90;
        }
        else if(isUp) {
          directionAngle = -90;
        }
    //For combined directionAngles:
        if(isRight && isUp) {
          directionAngle = -45;
        }
        else if(isRight && isDown) {
          directionAngle = 45;
        }
        else if(isLeft && isUp) {
          directionAngle = -135;
        }
        else if(isLeft && isDown) {
          directionAngle = 135;
        }
        
    //See if moving.
    
    x_pos = constrain(x_pos + xChange, r, width  - r);
    y_pos = constrain(y_pos + yChange, r, height - r);
    if(x_prev_pos != x_pos || y_prev_pos != y_pos) {
      isMoving = true;
    }
    else {
      isMoving = false;
    }
  }
  
  boolean setMove(int k, boolean b, ArrayList<Monster> m) {
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
      for(Monster mons : m) {
        p.attack(mons, 1);
        arc(x_pos, y_pos, 80, 80, radians(directionAngle) - PI/5, PI/5 + radians(directionAngle));
      }
 
    default:
    return b;
    }
  }
}
