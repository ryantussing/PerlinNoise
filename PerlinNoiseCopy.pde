int cols, rows;
int scl = 20;
int w = 1200; 
int h = 900;

float flying = 0;

float[][] terrain;

void setup() {
  size(600, 600, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}

void draw () {
  
  flying -= 0.0;
  int zmin = -50;
  int zmax = 50;
  
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff,yoff), 0, 1, zmin, zmax);
      xoff += 0.2;
    }
    yoff += 0.2;
  }
  
  background(0);
  stroke(255);
  //noFill();
  //if (terrain[x][y] <= zmin/2) {
  //  fill(0, 0, 255); 
  //}
  //if (terrain[x][y] <= 0.0 && terrain[x][y] > zmin/2) {
  //  fill(0, 250, 154); 
  //}
  //if (terrain[x][y] <= zmax/2 && terrain[x][y] > 0) {
  //  fill(255, 255, 51); 
  //}
  //if (terrain[x][y] <= zmax) {
  //  fill(255, 165, 0); 
  //}
  
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
       vertex(x*scl, y*scl, terrain[x][y]);
       vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
       
       if (terrain[x][y] <= zmax && terrain[x][y] > zmax/2) {
          fill(0, terrain[x][y]*255, 0);  
        }
       else if (terrain[x][y] <= zmax/2 && terrain[x][y] > 0) {
          fill(0, terrain[x][y]*255, 0);  
        }
       else if (terrain[x][y] <= 0.0 && terrain[x][y] > zmin/2) {
          fill(0, terrain[x][y]*255, 0);  
       }
        
       else if (terrain[x][y] <= zmin/2) {
          fill(0, terrain[x][y]*255, 0); 
       }
    }
    endShape();
  }
  
}
