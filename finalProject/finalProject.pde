PImage t = loadImage("Test.png");
Monster m = new Monster(width/2, height/2, 100, 100, t, 0);
void setup() {
  size(1000,700);
}
void draw() {
 m.display(); 
}
