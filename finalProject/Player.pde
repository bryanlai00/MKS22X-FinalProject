class Player extends Thing implements Damageable, Collideable {
  int m_health, damage, gaugeValue, num_sprites, sprite_index, delay = 0, frame = 0, invulTimer, invulTime, score = 0, attackAni, dashTimer = 0;
  String lastDirection = "right";
  float x_pos, y_pos, x_size, y_size, directionAngle, c_health, magic_cooldown, dash_cooldown, spin_cooldown;
  boolean isMoving;
  boolean isLeft, isRight, isUp, isDown, isDashing, isAttacking, isRunning;
  int[] abilities;
  ArrayList<Item> itemsAcquired = new ArrayList<Item>();
  ArrayList<PImage> localSprites = new ArrayList<PImage>();
  OverworldObject spinEffect;

  float getX() {
    return x_pos;
  }
  float getY() {
    return y_pos;
  }
  float getX_size() {
    return x_size;
  }
  float getY_size() {
    return y_size;
  }

  //Takes in size then pos.

  //Player(int x_size, int y_size, int x_pos, int y_pos, int iT, PImage s) {
  Player(int x_size, int y_size, int x_pos, int y_pos, int iT, int num_sprites, ArrayList<PImage> ls) {
    super(x_size, y_size);
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
    //for spinEffect:
    spinEffect = new OverworldObject(x_pos, y_pos - 50, 400, 400, effectSprites, false, 63);
    sprite_index = 0;
    //Takes in pos then size.
  }

  void display() {
    //Changes sprite_index based on buttons pressed.
    /* IF RUNNING Sprites Indexes 4-11*/
    if (isMoving) {
      if (lastDirection.equals("right")) {
        sprite_index = 8;
        ;
      } else if (lastDirection.equals("left")) {
        sprite_index = 12;
        ;
      }
    } else {
      if (lastDirection.equals("left")) {
        sprite_index = 4;
      } else if (lastDirection.equals("right")) {
        sprite_index = 0;
      }
    }
    //Display items and created itemsAcquired array for player.
    if (!isDashing) {
      for (int i = 0; i < itemsAcquired.size(); i++) {
        Item indexItem = itemsAcquired.get(i);
        int nepo = 1; 
        if (lastDirection.equals("right")) {
          nepo = 1;
        } else if (lastDirection.equals("left")) {
          nepo = -1;
        }
        if (indexItem.itemValue == 1) {
          //Set sword to a rotating item: Meaning we have to display it not with coords given but at (0,0) after translating the map.
          indexItem.rotating = true;
          pushMatrix();
          if (isAttacking) {
            translate(x_pos + nepo * 20, y_pos + 10);
            rotate(nepo * 2 * PI/5);
          } else {
            translate(x_pos + nepo * 20, y_pos);
            rotate(nepo * PI/5);
          }
          indexItem.display();
          popMatrix();
        }
      }

      image(localSprites.get(frame + sprite_index), x_pos, y_pos, x_size, y_size);
      if (delay <= 10) delay ++;
      else {
        delay = 0;
        if (frame + 1 < num_sprites) frame ++;
        else frame = 0;
      }
    } else {
      if (directionAngle >= 90 && directionAngle < 270) {
        pushMatrix();
        translate(x_pos, y_pos);
        scale(-1.0, 1.0);
        image(loadImage("data/player_assets/dash.png"), 0, 0, 60, 60);
        popMatrix();
      } else image(loadImage("data/player_assets/dash.png"), x_pos, y_pos, 60, 60);
    }
  }

  void loseHealth(float num) {
    if (invulTimer == invulTime) {
      c_health -= num;
      invulTimer = 0;
    }
  }

  //Has isTouching method from Thing.
  boolean isTouching(Thing other) {
    //Add statement to deal with OverworldObjects, bottom is used for monster.
    return super.isTouching(other);
  }

  void attack(Thing enemy, float num) {
    isAttacking = true;
    float range = 200;
    float coneSliceAngle = degrees(PI/4);
    //If the distance is greater than the range, return and iterate with the next monster.
    //Display attack animation of sword:
    if (dist(x_pos, y_pos, enemy.getX(), enemy.getY()) > range) {
      return;
    } else {
      float anglePosition = degrees((float)Math.atan2(enemy.getY() - y_pos, enemy.getX() - x_pos));
      //If angle is less than 0:
      float rightConstraint = directionAngle + coneSliceAngle;
      float leftConstraint = directionAngle - coneSliceAngle;
      /*
      print("\n left constraint: " + leftConstraint);
       print("\n right constraint: " + rightConstraint);
       */
      if (anglePosition < rightConstraint && anglePosition > leftConstraint) {
        ((Monster)enemy).loseHealth(num);
      }
      //print("\n anglePosition: " + anglePosition);  
      //See if the difference angle is applicable for the coneSliceAngle:
    }
  }

  void update(HUD h) {
    //If health reaches 0... set game running to false, to call clear().
    //Reset ising:
    if (invulTimer < invulTime) {
      if (!isDashing) h.flashTime = invulTimer;
      invulTimer++;
      if (invulTimer % 10 < 5 && !isDashing) tint(255, 0, 0);
      else noTint();
    } else noTint();
    if (c_health <= 0) running = false;
    if (magic_cooldown > 0) magic_cooldown--;
    if (dash_cooldown > 0) dash_cooldown--;
    if (spin_cooldown > 0) spin_cooldown--;
    if (dashTimer > 0) {
      p.dash(); 
      dashTimer--;
    } else isDashing = false;
    if (attackAni > 0) {
      attackAni--;
      isAttacking = true;
    } else {
      isAttacking = false;
    }
  }

  void move() {
    //Calculating radius.
    double f = Math.pow(x_size, 2);
    double s = Math.pow(y_size, 2);
    float r = (float)Math.sqrt(f + s); 
    /*Speed for movement 4 for running, 2 for normal*/
    float speed;
    speed = 2.25;

    //Makes sure that the position does not go out.
    //Used to see if the position changes to determine if something moves.
    float x_prev_pos = x_pos;
    float y_prev_pos = y_pos;
    float xChange = speed * (int(isRight) - int(isLeft));
    float yChange = speed * (int(isDown) - int(isUp));
    //print(x_pos + " " + y_pos);
    //Move all other entities by moving the map.
    //List of x-statements to find angleDirection:
    //For basical cardinal directions:
    //print("direction angle" + directionAngle + "\n");
    if (isRight) {
      directionAngle = 0;
    } else if (isLeft) {
      directionAngle = 180;
    } else if (isDown) {
      directionAngle = 90;
    } else if (isUp) {
      directionAngle = -90;
    }
    //For combined directionAngles:
    if (isRight && isUp) {
      directionAngle = -45;
    } else if (isRight && isDown) {
      directionAngle = 45;
    } else if (isLeft && isUp) {
      directionAngle = -135;
    } else if (isLeft && isDown) {
      directionAngle = 135;
    }


    //If the player encounters a "collideableRoomObject, make xChange and yChange == 0
    for (OverworldObject o : collideableRoomObjects) {
      if (isTouching(o)) {
        //If you have a distance that is closer (less) than the previous distance between the object and player, don't move it in that direction.
        //Instead, just don't allow it.
        if (dist(x_pos + xChange, y_pos + yChange, o.getX(), o.getY()) < dist(x_pos, y_pos, o.getX(), o.getY())) {
          xChange = 0;
          yChange = 0;
        }
      }
    }
    for (OverworldObject o : harming) {
      if (isTouching(o) && o.frame < 2) {
        loseHealth(0.5);
      }
    }

    for (int i = allItems.size() - 1; i > -1; i--) {
      Item cur = allItems.get(i);
      if (isTouching(cur)) {
        cur.addAbilityToPlayer(this);
        itemsAcquired.add(allItems.remove(i));
      }
    }

    //If the player touches the item, have the item disappear, add the ability to the array, etc.

    x_pos = constrain(x_pos + xChange, r, width  - r);
    y_pos = constrain(y_pos + yChange, r, height - r);


    //Check boundaries and move other entities based on xChange and yChange.
    for (int i = 0; i < roomObjects.size(); i++) {
      roomObjects.get(i).x_pos += -xChange;
      roomObjects.get(i).y_pos += -yChange;
    }
    for (int i = 0; i < collideableRoomObjects.size(); i++ ) {
      collideableRoomObjects.get(i).x_pos += -xChange;
      collideableRoomObjects.get(i).y_pos += -yChange;
    }
    for (int i = 0; i < allItems.size(); i++) {
      allItems.get(i).x_pos += -xChange;
      allItems.get(i).y_pos += -yChange;
    }
    for (int i = 0; i < m.size(); i++) {
      m.get(i).x_pos += -xChange;
      m.get(i).y_pos += -yChange;
    }
    for(int i = 0; i < projectiles.size(); i++) {
      projectiles.get(i).x_pos += -xChange;
      projectiles.get(i).y_pos += -yChange;
    }
    spinEffect.x_pos = x_pos;
    spinEffect.y_pos = y_pos - 10;
    //Checks if the player is moving.
    if (x_prev_pos != x_pos || y_prev_pos != y_pos) {
      isMoving = true;
    } else {
      isMoving = false;
    }
  }


  //Moves you learn on throughout the game:
  void dash() {
    isDashing = true;
    float speed = 5;
    boolean inBounds = true;
    //If the player encounters a wall while dashing, stop movement.
    for (OverworldObject o : collideableRoomObjects) {
      if (isTouching(o)) {
        inBounds = false;
      }
    }
    if (inBounds) {
      x_pos += speed * (int(isRight) - int(isLeft));
      y_pos += speed * (int(isDown) - int(isUp));
    }
  }

  void spinAttack(Monster enemy, float num) {
    float range = 150;
    if (dist(x_pos, y_pos, enemy.getX(), enemy.getY()) < range) {
      enemy.loseHealth(num);
    }
  }

  void magicAttack() {
    PImage projectile = loadImage("data/items/magic.png");
    projectile.resize(100, 100);
    if (magic_cooldown == 0) {
      if (m.size() > 0) {
        Monster target = m.get(0);
        projectiles.add(new Projectile(x_pos, y_pos, 35, 35, 1, 8, 60, projectile, (Monster)target));
      }
      magic_cooldown = 80;
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
      if (p.abilities[1] == 2) {
        if (dash_cooldown == 0) {
          dashTimer = 60; 
          dash_cooldown = 200; 
          invulTimer = 0;
           h.cooldowns[0] = (int)dash_cooldown;
        }
      }
      return true;

    case 'C':
      if (p.abilities[2] == 3) {
        if(spin_cooldown == 0) {
              roomObjects.add(spinEffect); 
             print(roomObjects.contains(spinEffect));
             for( Monster mons : m) {
                p.spinAttack(mons,2);
             }
            spin_cooldown = 70;
            h.cooldowns[1] = (int)spin_cooldown;
      }
      return true;
      }

    case 'V':
      if (p.abilities[3] == 4) {
        p.magicAttack();
        h.cooldowns[2] = (int)magic_cooldown;
      }
      return true;

    case 'Z':
      if (p.abilities[0] == 1) {
        isAttacking = true;
        attackAni = 20;
        for (Monster mons : m) {
          p.attack(mons, 1);
        }
      }
      return true;

    case 'I':
      if (screens.size() == 0 && b) screens.add(new Screen(width/2 - 190, height - 115, width/2, 75, 75, "instruct"));
      else if (screens.size() == 1) screens.remove(0);
    
    default:
      return b;
    }
  }
}
