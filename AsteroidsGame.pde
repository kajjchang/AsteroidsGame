final float GAME_SIZE = 5000.0;

Spaceship myShip;
ArrayList<Floater> floaters = new ArrayList<Floater>();
ArrayList<Star> stars = new ArrayList<Star>();

HashMap<Character, Boolean> keyPressedMap = new HashMap<Character, Boolean>();

public color starColor() {
  int[] rgb = new int[3];
  int primary = (int) random(3);
  rgb[primary] = 255;
  for (int i = 0; i < rgb.length; i++) {
    if (i != primary) {
      rgb[i] = 255 - (int) random(255);
    }
  }
  return color(rgb[0], rgb[1], rgb[2]);
}

public void setup() {
  size(750, 750);
  myShip = new Spaceship(color(0, 0, 255, 100), 10, 10, 45);
  floaters.add(myShip);
  for (int i = 0; i < 500; i++) {
    stars.add(new Star(random(GAME_SIZE), random(GAME_SIZE), starColor(), random(10, 15)));
  }
}

public void draw() {
  if (keyDown('w')) {
    myShip.accelerate(0.1);
  }
  if (keyDown('s')) {
    myShip.accelerate(-0.1);
  }
  if (keyDown('a')) {
    myShip.turn(-1);
  }
  if (keyDown('d')) {
    myShip.turn(1);
  }

  float xf = GAME_SIZE / width;
  float yf = GAME_SIZE / height;

  float xTrans, yTrans;
  
  background(255);

  if (myShip.getX() > GAME_SIZE - width / 2) {
    xTrans = -GAME_SIZE * (xf - 1) / xf;
  } else if (myShip.getX() < width / 2) {
    xTrans = 0;
  } else {
    xTrans = -myShip.getX() + width / 2;
  }

  if (myShip.getY() > GAME_SIZE - height / 2) {
    yTrans = -GAME_SIZE * (yf - 1) / yf;
  } else if (myShip.getY() < height / 2) {
    yTrans = 0;
  } else {
    yTrans = -myShip.getY() + height / 2;
  }
  
  translate(xTrans, yTrans);
  
  if (true) {
    push();
    fill(255, 0, 0, 100);
    rect(0, 0, GAME_SIZE, 50);
    rect(GAME_SIZE - 50, 50, 50, GAME_SIZE - 100);
    rect(0, 50, 50, GAME_SIZE - 100);
    rect(0, GAME_SIZE - 50, GAME_SIZE, 50);
    pop();
  }
  
  for (Star star : stars) {
    star.show();
  }

  for (Floater floater : floaters) {
    floater.move();
    floater.show();
  }
}

boolean keyDown(char key_) {
  return keyPressedMap.getOrDefault(key_, false);
}

void keyPressed() {
  keyPressedMap.put(key, true);
}

void keyReleased() {
  keyPressedMap.put(key, false);
}
