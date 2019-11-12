class Star {
  float x, y, size;
  color col;

  Star(float x, float y, color col, float size) {
    this.x = x;
    this.y = y;
    
    this.col = col;
    
    this.size = size;
  }
  
  public void show() {
    noStroke();
    fill(col, 100);
    ellipse(x, y, size, size);
  }
}
