class Bullet extends ConsumableFloater {
  private int duration;
  
  public Bullet(color col, double x, double y, double direction, double speed, int duration) {
    corners = 4;
    xCorners = new int[]{ -1, -1, 1, 1 };
    yCorners = new int[]{ 1, -1, -1, 1 };
    myColor = col;
    myCenterX = x;
    myCenterY = y;
    myPointDirection = direction;
    double dRadians = myPointDirection * (Math.PI / 180);  
    myDirectionX = Math.cos(dRadians) * speed;
    myDirectionY = Math.sin(dRadians) * speed;
    this.duration = duration;
  }
  
  public void move() {
    super.move();
    duration--;
  }
  
  public boolean done() {
    return duration <= 0;
  }
}
