class Star {
  private float x, y, size;
  private color col;

  public Star(float x, float y, color col, float size) {
    this.x = x;
    this.y = y;
    
    this.col = col;
    
    this.size = size;
  }
  
  public void show() {
    noStroke();
    fill(col);
    ellipse(x, y, size, size);
  }
}
