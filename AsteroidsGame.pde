float CHUNK_SIZE = 5000.0;
int STARS_PER_CHUNK = 250;

Spaceship myShip;
ArrayList<Floater> floaters = new ArrayList<Floater>();
ArrayList<Star> stars = new ArrayList<Star>();

HashMap<Integer, HashMap<Integer, Star[]>> chunks = new HashMap<Integer, HashMap<Integer, Star[]>>();
int[] currentChunk = new int[] {0, 0};

HashMap<Character, Boolean> keyPressedMap = new HashMap<Character, Boolean>();

public color generateColor() {
  int[] rgb = new int[3];
  int primary = (int) random(3);
  rgb[primary] = 255;
  for (int i = 0; i < rgb.length; i++) {
    if (i != primary) {
      rgb[i] = 255 - (int) random(255);
    }
  }
  return color(rgb[0], rgb[1], rgb[2], random(255));
}

public color invertColor(color col) {
  return color(255 - red(col), 255 - green(col), 255 - blue(col));
}

void createChunk(int x, int y) {
  if (chunks.get(x) == null) {
    final int y_ = y;
    chunks.put(x, new HashMap<Integer, Star[]>() {{
      Star[] stars = new Star[STARS_PER_CHUNK];
      for (int i = 0; i < STARS_PER_CHUNK; i++) {
        stars[i] = new Star(random(CHUNK_SIZE), random(CHUNK_SIZE), generateColor(), random(10, 15));
      }
      put(y_, stars);
    }});
  } else {
    Star[] stars = new Star[STARS_PER_CHUNK];
    for (int i = 0; i < STARS_PER_CHUNK; i++) {
      stars[i] = new Star(random(CHUNK_SIZE), random(CHUNK_SIZE), generateColor(), random(10, 15));
    }
    chunks.get(x).put(y, stars);
  }
}


public void setup() {
  size(750, 750);
  myShip = new Spaceship(color(0, 150, 0), 100, 100, 45, 100);
  floaters.add(myShip);
  createChunk(0, 0);
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
  if (keyDown(' ')) {
    floaters.add(myShip.shoot());
  }

  float xf = CHUNK_SIZE / width;
  float yf = CHUNK_SIZE / height;

  float xTrans, yTrans;
  
  background(255);

  if (myShip.getX() > ((currentChunk[0] + 1) * CHUNK_SIZE) - width / 2) {
    xTrans = -(currentChunk[0] * CHUNK_SIZE) * (xf - 1) / xf;
  } else if (myShip.getX() < (currentChunk[0] * CHUNK_SIZE) + width / 2) {
    xTrans = (currentChunk[0] * CHUNK_SIZE);
  } else {
    xTrans = -myShip.getX() + width / 2;
  }

  if (myShip.getY() > ((currentChunk[0] + 1) * CHUNK_SIZE) - height / 2) {
    yTrans = -(currentChunk[0] * CHUNK_SIZE) * (yf - 1) / yf;
  } else if (myShip.getY() < (currentChunk[0] * CHUNK_SIZE) + height / 2) {
    yTrans = (currentChunk[0] * CHUNK_SIZE);
  } else {
    yTrans = -myShip.getY() + height / 2;
  }
  
  translate(xTrans, yTrans);
  
  /*
  fill(255, 0, 0, 100);
  rect(0, 0, GAME_SIZE, 50);
  rect(GAME_SIZE - 50, 50, 50, GAME_SIZE - 100);
  rect(0, 50, 50, GAME_SIZE - 100);
  rect(0, GAME_SIZE - 50, GAME_SIZE, 50);
  
  if (myShip.getY() <= 50 || myShip.getY() >= GAME_SIZE - 50 || myShip.getX() <= 50 || myShip.getX() >= GAME_SIZE - 50) {
    myShip.takeDamage(1);
  }
  */
  
  for (Star star : chunks.get(currentChunk[0]).get(currentChunk[1])) {
    star.show();
  }
  
  ArrayList<Floater> toRemove = new ArrayList<Floater>();

  for (Floater floater : floaters) {
    floater.move();
    floater.show();
    if (floater instanceof ConsumableFloater) {
      if (((ConsumableFloater) floater).done()) {
        toRemove.add(floater);
      }
    }
  }

  floaters.removeAll(toRemove);
  
  if (myShip.getX() <= currentChunk[0] * CHUNK_SIZE) {
    currentChunk = new int[] { currentChunk[0] - 1, currentChunk[1] };
    createChunk(currentChunk[0], currentChunk[1]);
  } else if (myShip.getX() >= (currentChunk[0] + 1) * CHUNK_SIZE) {
    currentChunk = new int[] { currentChunk[0] + 1, currentChunk[1] };
    createChunk(currentChunk[0], currentChunk[1]);
  } else if (myShip.getY() <= currentChunk[1] * CHUNK_SIZE) {
    currentChunk = new int[] { currentChunk[0], currentChunk[1] - 1 };
    createChunk(currentChunk[0], currentChunk[1]);
  } else if (myShip.getY() >= (currentChunk[1] + 1) * CHUNK_SIZE) {
    currentChunk = new int[] { currentChunk[0], currentChunk[1] + 1 };
    createChunk(currentChunk[0], currentChunk[1]);
  }
  
  translate(-xTrans, -yTrans);
  
  push();
  stroke(0);
  line(10, 30, 50, 30);
  line(30, 10, 30, 50);
  stroke(myShip.getColor());
  double dRadiansVelocity = Math.atan(myShip.getDirectionY() / myShip.getDirectionX());
  double speed = Math.sqrt(Math.pow(myShip.getDirectionX(), 2) + Math.pow(myShip.getDirectionY(), 2));
  line(30.0, 30.0, (float) (30.0 + Math.cos(dRadiansVelocity) * speed * 5), (float) (30.0 + Math.sin(dRadiansVelocity) * speed * 5));
  stroke(invertColor(myShip.getColor()));
  double dRadiansPointDirection = myShip.getPointDirection() * (Math.PI / 180);
  line(30.0, 30.0, (float) (30.0 + Math.cos(dRadiansPointDirection) * 15 * Math.sqrt(2)), (float) (30.0 + Math.sin(dRadiansPointDirection) * 15 * Math.sqrt(2)));
  pop();
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
