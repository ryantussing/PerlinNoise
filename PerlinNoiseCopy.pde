int cols, rows;
int scl = 20;
int w = 1200; 
int h = 900;

float flyingValue;
float flying;

float[][] terrain;

void setup() {
  size(600, 600, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}

void keyPressed() {
  if (keyCode == UP) {
    flying -= 0.10; // how fast the camera is moving along y-axis
    System.out.println("yes");
  }
}

void draw () {
  
  int zmin = 0;
  int zmax = 100;
  
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
       float s = 100;
       float b = 100;
       
       
       // TURN THE COLORS TO HSL IN ORDER TO USE HUE https://stackoverflow.com/questions/12875486/what-is-the-algorithm-to-create-colors-for-a-heatmap
       
       colorMode(HSB, 360, 100, 100);
       
       if (terrain[x][y] <= zmax && terrain[x][y] > 3*zmax/4) {  // RED
          //h = (1 - terrain[x][y]/100) * 360;
          h = ((1 - terrain[x][y]/100) * 360) - 90;
          //g = 0;      g and b are commented to allow for HSB value application
          //b = 0;
          fill(h, s, b); // s and b are 100 for HSB values
        }
       else if (terrain[x][y] <= 3*zmax/2 && terrain[x][y] > zmax/2) { // GREEN
          h = ((1 - terrain[x][y]/100) * 360) - 90;
          //g = terrain[x][y] * 255;
          //b = 0;
          fill(h, s, b);  
        }
       else if (terrain[x][y] <= zmax/2 && terrain[x][y] > zmax/4) { // BLUE
          h = ((1 - terrain[x][y]/100) * 360) - 90;
          //g = 0;
          //b = -terrain[x][y] * 255;
          fill(h, s, b); 
       }
        
       else if (terrain[x][y] <= zmax/4) { // TURQUOISE
          h = ((1 - terrain[x][y]/100) * 360) - 90;
          //g = -terrain[x][y] * 255;
          //b = -terrain[x][y] * 255;
          fill(h, s, b);
       }
       //System.out.println(terrain[x][y]);
    }
    
    endShape();
  
  }
  
}
