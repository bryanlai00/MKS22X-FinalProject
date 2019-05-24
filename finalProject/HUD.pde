class HUD {
  float x_pos, y_pos, mHealth, separation;
  ArrayList<PImage> hearts = new ArrayList<PImage>();
  PImage full, half, empty;
  int heartCount;
  HUD(float p_mHealth, float xcor, float ycor, float sep) {
    mHealth = p_mHealth;
    x_pos = xcor;
    y_pos = ycor;
    separation = sep;
    for (int i = 0; i < hudNames.length; i++) {
      if (hudNames[i].contains("full")) full = hud.get(i);
      if (hudNames[i].contains("half")) half = hud.get(i);
      if (hudNames[i].contains("empty")) empty = hud.get(i);
    }
    heartCount = (int)mHealth;
    if (mHealth % 1.0 >= .5) heartCount++;
    for (int i = heartCount; i > 0; i--) hearts.add(full);
  }
  void update(float cHealth) {
    for (int i = 0; i < hearts.size(); i++) {
      if (cHealth < i + 1 && cHealth > i && cHealth >= (float)i - .5) hearts.set(i, half);
      else if (cHealth < i + 1) hearts.set(i, empty);
      else hearts.set(i, full);
    }
  }
  void display() {
    float sepTrack = x_pos;
    for (int i = 0; i < hearts.size(); i++) {
      image(hearts.get(i), sepTrack, y_pos);
      sepTrack += separation;
    }
  }
}
