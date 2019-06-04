class Item extends Thing {
        float getX() {return x_pos;}
        float getY() {return y_pos;}
        float getX_size() {return x_size;}
        float getY_size() {return y_size;}
        int itemValue;
        PImage sprite;
        boolean rotating;

        //Constructor:
        public Item(float x_pos, float y_pos, float x_size, float y_size, PImage sprite, float itemValue){
                super(x_pos, y_pos);
                this.x_pos = x_pos;
                this.y_pos = y_pos;
                this.x_size = x_size;
                this.y_size = y_size;
                this.sprite = sprite;
                sprite.resize((int) x_size, (int) y_size);
                this.itemValue = (int) itemValue;
        }

        //Displays itself.
        void display() {
                if(rotating) {
                        image(sprite, 0, 0);
                }
                else {
                        image(sprite, x_pos, y_pos);
                }
        }

        //Adds ability to player and shows cooldown timers.
        void addAbilityToPlayer(Player p) {
                if(itemValue != 0 && p.isTouching(this)) {
                        //If the item touches the player, give the player that ability and add this # to the player's ability array.
                        p.abilities[(int)itemValue - 1] = (int)itemValue;
                        //Remove Overworldobject from it.
                        if (itemValue == 2) h.cooldowns[0] = 0;
                        if (itemValue == 3) h.cooldowns[1] = 0;
                        if (itemValue == 4) h.cooldowns[2] = 0;
                }
        }
}
