class Spaceship extends Floater {
  private float velocity;
  Spaceship(color col, double x, double y, double direction) {
    corners = 4;
    xCorners = new int[]{ 8, -5, -2, -5 };
    yCorners = new int[]{ 0, 5, 0, -5 };
    myColor = col;
    myCenterX = x;
    myCenterY = y;
    myDirectionX = myDirectionY = 0;
    myPointDirection = direction;
  }
  
  public void accelerate(float acceleration) {
    myDirectionX += acceleration * Math.cos(myPointDirection * (Math.PI / 180));
    myDirectionY += acceleration * Math.sin(myPointDirection * (Math.PI / 180));
    myDirectionX = Math.copySign(Math.min(3, Math.abs(myDirectionX)), myDirectionX);
    myDirectionY = Math.copySign(Math.min(3, Math.abs(myDirectionY)), myDirectionY);
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
    super.show();
    pop();
  }
  
  public float getX() {
    return (float) myCenterX;
  }
  
  public float getY() {
    return (float) myCenterY;
  }
}
