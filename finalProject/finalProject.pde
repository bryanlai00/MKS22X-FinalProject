Player p;

void setup() {
  size(800, 600);
   p = new Player(60,60,300,300,loadImage("hollow_knight.png"));
 }
 
void draw() {
  textSize(32);
  fill(0, 102, 153, 204);
  text("hello world",30,30);
  background(223);
  p.display();
  p.move();
}

void keyPressed() {
  p.setMove(keyCode, true);
}

void keyReleased() {
  p.setMove(keyCode, false);
  p.isRunning = false;
}
