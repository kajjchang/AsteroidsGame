class SafeFloater extends Floater {
  public void show() {
    push();
    super.show();
    pop();
  }
  
  public void move() {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY; 
  }
}
