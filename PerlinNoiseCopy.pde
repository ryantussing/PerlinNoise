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
  
  flying -= 0.01; // how fast the camera is moving along y-axis
  int zmin = -50;
  int zmax = 50;
  
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0; // how fast the camera is moving along x-axis
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff,yoff), 0, 1, zmin, zmax);
      xoff += 0.2;
    }
    yoff += 0.2;
  }
  
  background(0, 0, 100);
  stroke(0, 0, 0);
  
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  
  for (int y = 0; y < rows - 1; y++) {
    
    beginShape(TRIANGLE_STRIP);
    
    for (int x = 0; x < cols; x++) {
      
       vertex(x*scl, y*scl, terrain[x][y]);
       vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
       
       float h;
       float g;
       float b;
       
       
       // TURN THE COLORS TO HSL IN ORDER TO USE HUE https://stackoverflow.com/questions/12875486/what-is-the-algorithm-to-create-colors-for-a-heatmap
       
       colorMode(HSB, 100);
       
       if (terrain[x][y] <= zmax && terrain[x][y] > zmax/2) {  // RED
          h = terrain[x][y] * 255;
          //g = 0;      g and b are commented to allow for HSB value application
          //b = 0;
          fill(h, 100, 100); // s and b are 100 for HSB values
        }
       else if (terrain[x][y] <= zmax/2 && terrain[x][y] > 0.0) { // GREEN
          h = terrain[x][y] * 255;
          //g = terrain[x][y] * 255;
          //b = 0;
          fill(h, 100, 100);  
        }
       else if (terrain[x][y] <= 0.0 && terrain[x][y] > zmin/2) { // BLUE
          h = terrain[x][y];
          //g = 0;
          //b = -terrain[x][y] * 255;
          fill(h, 100, 100); 
       }
        
       else if (terrain[x][y] <= zmin/2) { // TURQUOISE
          h = terrain[x][y];
          //g = -terrain[x][y] * 255;
          //b = -terrain[x][y] * 255;
          fill(h, 100, 100); 
       }
       
    }
    
    endShape();
  
  }
  
}
