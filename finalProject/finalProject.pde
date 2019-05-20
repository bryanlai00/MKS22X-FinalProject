Player p;

void setup() {
  size(800, 600);
   p = new Player(60,60,300,300,loadImage("hollow_knight.png"));
 }
 
void draw() {
  background(0);
  p.display();
  p.move();
}

void keyPressed() {
  p.setMove(keyCode, true);
}

void keyReleased() {
  p.setMove(keyCode, false);
}
