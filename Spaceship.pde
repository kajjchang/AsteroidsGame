class Spaceship extends ConsumableFloater {
  private static final int MAX_SPEED = 3;
  private static final int SHIP_RADIUS = 5;

  private float maxHealth;
  private float health;

  public Spaceship(color col, double x, double y, double direction, float health) {
    corners = 4;
    xCorners = new int[]{ SHIP_RADIUS, -8, -SHIP_RADIUS, -8 };
    yCorners = new int[]{ 0, SHIP_RADIUS, 0, -SHIP_RADIUS };
    myColor = col;
    myCenterX = x;
    myCenterY = y;
    myDirectionX = myDirectionY = 0;
    myPointDirection = direction;
    this.health = maxHealth = health;
  }
  
  public void accelerate(float acceleration) {
    myDirectionX += acceleration * Math.cos(myPointDirection * (Math.PI / 180));
    myDirectionY += acceleration * Math.sin(myPointDirection * (Math.PI / 180));
    myDirectionX = Math.copySign(Math.min(MAX_SPEED, Math.abs(myDirectionX)), myDirectionX);
    myDirectionY = Math.copySign(Math.min(MAX_SPEED, Math.abs(myDirectionY)), myDirectionY);
  }
  
  public void turn(float angle) {
    myPointDirection += angle;
  }

  public void move() {
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
  }
  
  public void show() {
    push();
    fill(200);
    rectMode(CORNER);
    rect((float) myCenterX - 25.0, (float) myCenterY - SHIP_RADIUS - 22.5, 50.0, 10.0);
    fill(myColor);
    rect((float) myCenterX - 22.5, (float) myCenterY - SHIP_RADIUS - 20, 45.0 * health / maxHealth, 5.0);
    strokeWeight(5);
    super.show();
    pop();
  }
  
  public Bullet shoot() {
    double dRadians = myPointDirection * (Math.PI / 180);
    return new Bullet(myColor, myCenterX + Math.cos(dRadians) * SHIP_RADIUS, myCenterY + Math.sin(dRadians) * SHIP_RADIUS, myPointDirection, 10, 120);
  }
  
  public void takeDamage(float damage) {
    health -= damage;
  }
  
  public float getX() {
    return (float) myCenterX;
  }
  
  public float getY() {
    return (float) myCenterY;
  }
  
  public float getPointDirection() {
    return (float) myPointDirection;
  }
  
  public float getDirectionX() {
    return (float) myDirectionX;
  }
  
  public float getDirectionY() {
    return (float) myDirectionY;
  }
  
  public color getColor() {
    return myColor;
  }
  
  public boolean done() {
    return health <= 0;
  }
}
