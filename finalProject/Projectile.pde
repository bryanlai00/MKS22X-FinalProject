class Projectile extends Thing {
        float getX() {return x_pos;}
        float getY() {return y_pos;}
        float getX_size() {return x_size;}
        float getY_size() {return y_size;}
        float x_pos, y_pos, endX, endY, damage, direction, speed;
        String target;
        int duration;
        PImage sprite; //<>//
        //Projectile against Monsters:
        Projectile(float xcor, float ycor, float xSize, float ySize, float dam, float spe, int d, PImage i, Monster m) {
                super(xSize,ySize);
                endX = m.getX();
                endY = m.getY();
                x_pos = xcor;
                y_pos = ycor;
                damage = dam;
                speed = spe;
                duration = d;
                sprite = i;
                target = "monster";
                //Shows direction:
                sprite.resize((int)xSize, (int)ySize);
                direction = p.directionAngle;
        }
        Projectile(float xcor, float ycor, float xSize, float ySize, float dam, float spe, int d, PImage i, Player p) {
                super(xSize,ySize);
                endX = p.getX();
                endY = p.getY();
                x_pos = xcor;
                y_pos = ycor;
                damage = dam;
                speed = spe;
                duration = d;
                sprite = i;
                target = "player";
                sprite.resize((int)xSize, (int)ySize);
                direction = (float)Math.toDegrees(Math.atan2((double)(endY - y_pos), (double)(endX - x_pos)));
        }
        Projectile(float xcor, float ycor, float xSize, float ySize, float dam, float spe, int d, PImage i, Player p, float directionalDiff) {
                super(xSize,ySize);
                endX = p.getX();
                endY = p.getY();
                x_pos = xcor;
                y_pos = ycor;
                damage = dam;
                speed = spe;
                duration = d;
                sprite = i;
                target = "player";
                sprite.resize((int)xSize, (int)ySize);
                direction = (float)Math.toDegrees(Math.atan2((double)(endY - y_pos), (double)(endX - x_pos))) + directionalDiff;
        }
        void update(Player p) {
                if (isTouching(p)) {
                        p.loseHealth(damage);
                        projectiles.remove(projectiles.size() - 1);
                }
                else if (projectiles.size() > 0 && duration < 0) {
                        projectiles.remove(projectiles.size() - 1);
                }
                else duration--;
        }
        void move() {  
                for(OverworldObject o : collideableRoomObjects) {
                        if(isTouching(o)) {
                                if(dist(x_pos + speed * (float) Math.cos(radians(direction)), y_pos + speed * (float) Math.sin(radians(direction)), o.getX(), o.getY()) < dist(x_pos, y_pos, o.getX(), o.getY())) {
                                        sprite = createImage(0, 0, RGB);
                                        damage = 0;
                                }
                        }
                }
                x_pos += speed * Math.cos(radians(direction));
                y_pos += speed * Math.sin(radians(direction));
        }

        void update(Monster m) {
                if(isTouching(m)) {
                        m.loseHealth(damage);
                        projectiles.remove(projectiles.size() - 1);
                }
                else if (projectiles.size() > 0 && duration < 0) {
                        projectiles.remove(projectiles.size() - 1);
                }
                else duration--;
        }

        void display() {
                imageMode(CENTER);
                noTint();
                if (direction < 90 && direction >= -90) {
                        pushMatrix();
                        translate(x_pos, y_pos);
                        scale(-1.0, 1.0);
                        image(sprite, 0, 0);
                        popMatrix();
                }
                else image(sprite, x_pos, y_pos);
        }
}
