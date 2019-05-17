Monster m;
void setup() {
  size(1000,700);
  PImage t = loadImage("Test.png");
  m = new Monster(width/2.0, height/2.0, 100, 100, t, 0, false);
}
void draw() {
 background(255);
 m.display(); 
}
