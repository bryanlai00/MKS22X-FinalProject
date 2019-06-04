class HUD {
  int score;
  PFont font = createFont("Arial Bold", 18);
  float x_pos, y_pos, mHealth, separation;
  ArrayList<PImage> hearts = new ArrayList<PImage>();
  ArrayList<PImage> abilities = new ArrayList<PImage>();
  int[] cooldowns = {-1, -1, -1};
  PImage full, half, empty, dash, spin, proj;
  int heartCount, flashTime = 0;
  HUD(float p_mHealth, float xcor, float ycor, float sep) {
    score = 0;
    mHealth = p_mHealth;
    x_pos = xcor;
    y_pos = ycor;
    separation = sep;
    for (int i = 0; i < hudNames.length; i++) {
      if (hudNames[i].contains("full")) full = hud.get(i);
      if (hudNames[i].contains("half")) half = hud.get(i);
      if (hudNames[i].contains("empty")) empty = hud.get(i);
      if (hudNames[i].contains("dash")) dash = hud.get(i);
      if (hudNames[i].contains("spin")) spin = hud.get(i);
      if (hudNames[i].contains("proj")) proj = hud.get(i);
    }
    heartCount = (int)mHealth;
    if (mHealth % 1.0 >= .5) heartCount++;
    for (int i = heartCount; i > 0; i--) hearts.add(full);
    abilities.add(dash);
    abilities.add(spin);
    abilities.add(proj);
  }
  void update(float cHealth) {
    for (int i = 0; i < hearts.size(); i++) {
      if (cHealth < i + 1 && cHealth > i && cHealth >= (float)i - .5) hearts.set(i, half);
      else if (cHealth < i + 1) hearts.set(i, empty);
      else hearts.set(i, full);
    }
    if (flashTime != 0 && flashTime % 10 < 5) {
      tint(255, 0, 0);
      flashTime--;
    }
    else noTint();
  }
  void increaseScore(int sco) {score += sco;}
  void display() {
    float sepTrack = x_pos;
    for (int i = 0; i < hearts.size(); i++) {
      image(hearts.get(i), sepTrack, y_pos);
      sepTrack += separation;
    }
    textFont(font);
    textSize(32);
    fill(255);
    text("Score: " + score, width - (100 + 5 * (score + "").length()), 50);
    noFill();
    float sep = x_pos;
    for (int i = 0; i < cooldowns.length; i++) {
      if (cooldowns[i] < 0) tint(0, 0);
      else if (cooldowns[i] > 0) {tint(128, 0, 0); cooldowns[i]--;}
      else noTint();
      image(abilities.get(i), x_pos + 25, height - 200 + sep, 60, 60);
      sep += separation * 1.25;
    }
  }
}
