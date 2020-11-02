int cols, rows;
int scl = 10;
int w = 1800; 
int h = 900;
static float z;
static float z1;
static int colIndex;
static int rowIndex;

float flyingValue;
float flying;  
static int zmin = 0;
static int zmax = 100;

float[][] terrain;

void setup() {
  size(600, 600, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  
  float max = findHighestValue(terrain);
  float min = findLowestValue(terrain);
  float rowIndexMax = findRowHighestValue(terrain);
  float colIndexMax = findColHighestValue(terrain);
  float rowIndexMin = findRowLowestValue(terrain);
  float colIndexMin = findColLowestValue(terrain);
  //float range = max - min;
  //float colorScale = range/(cols*rows);
  //System.out.println(colIndexMax + 1 + " col max");
  //System.out.println(rowIndexMax + 1 + " row max");
  //System.out.println(colIndexMin + 1 + " col min");
  //System.out.println(rowIndexMin + 1 + " row min");
  
}

void keyPressed() {
  if (keyCode == UP) {
    flying -= 0.10; // how fast the camera is moving along y-axis
  }
}

void draw () {
  
  float yoff = flying;
  
  
  
  for (int y = 0; y < rows; y++) {
    float xoff = 0; // how fast the camera is moving along x-axis
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff,yoff), 0, 1, zmin, zmax);
      xoff += 0.05;
    }
    yoff += 0.05;
  }
  
  background(240, 100, 20);
  //stroke(0, 0, 0);
  noStroke();
  
  translate(width/1, height/1); // brings the picture down into vision from the top of the screen (puts pov on top of the terrain)
  rotateX((PI)/3); // angles the pov to a view side angle
  translate(-w/2, -h/2); // moves the terrain to the left so that it takes up the whole screen from left to right
  
  colorMode(HSB, 360, 100, 100);
       float h;
       float s = 100;
       float b;
  
  for (int y = 0; y < rows - 1; y++) {
    
    beginShape(TRIANGLE_STRIP);
    
    for (int x = 0; x < cols; x++) {
      
       z = terrain[x][y];
       //System.out.println(z);
       z1 = terrain[x][y+1];
       
       vertex(x*scl, y*scl, z);
       vertex(x*scl, (y+1)*scl, z1);
       
       if ((z1 - z) <= -3.0) {
         h = ((1 - terrain[x][y]/100) * 360) - 90;
         b = 100;
         fill(h, s, b);
       }
       else if ((z1 - z) <= -2.0 && (z1 - z) > -3.0) {
         h = ((1 - terrain[x][y]/100) * 360) - 90;
         b = 95;
         fill(h, s, b);
       }
       else if ((z1 - z) <= -1.0 && (z1 - z) > -2.0) {
         h = ((1 - terrain[x][y]/100) * 360) - 90;
         b = 90;
         fill(h, s, b);
       }
       else if ((z1 - z) <= 0.0 && (z1 - z) > -1.0) {
         h = ((1 - terrain[x][y]/100) * 360) - 90;
         b = 85;
         fill(h, s, b);
       }
       else if ((z1 - z) > 0.0 && (z1 - z) <= 1.0) {
         h = ((1 - terrain[x][y]/100) * 360) - 90;
         b = 80;
         fill(h, s, b);
       }
       else if ((z1 - z) > 1.0 && (z1 - z) <= 2.0) {
         h = ((1 - terrain[x][y]/100) * 360) - 90;
         b = 75;
         fill(h, s, b);
       }
       else if ((z1 - z) > 2.0 && (z1 - z) <= 3.0) {
         h = ((1 - terrain[x][y]/100) * 360) - 90;
         b = 70;
         fill(h, s, b);
       }
       else if ((z1 - z) > 3.0) {
         h = ((1 - terrain[x][y]/100) * 360) - 90;
         b = 65;
         fill(h, s, b);
       }
       
       //h = ((1 - colorScale) * 360) - 90;
       //h = (1 - terrain[x][y]/360) * 360;
       
       
       
    } // end of inner for loop
    
    endShape();
  
  } // end of outer for loop
  
} // end of draw

public static float findHighestValue(float[][] terrain) {
    float currentHighestValue = zmin;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = z;
            if (value > currentHighestValue) {
                currentHighestValue = value;
            }
        }
    }
    return currentHighestValue; 
}
public static float findRowHighestValue(float[][] terrain) {
    float currentHighestValue = zmin;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = z;
            if (value > currentHighestValue) {
                rowIndex = row;
            }
        }
    }
    return rowIndex; 
}
public static float findColHighestValue(float[][] terrain) {
    float currentHighestValue = zmin;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = z;
            if (value > currentHighestValue) {
                colIndex = col;
            }
        }
    }
    return colIndex; 
}

public static float findLowestValue(float[][] terrain) {
    float currentLowestValue = zmax;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = z;
            if (value < currentLowestValue) {
                currentLowestValue = value;
            }
        }
    }
    return currentLowestValue;
}
public static float findRowLowestValue(float[][] terrain) {
    float currentLowestValue = zmax;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = z;
            if (value < currentLowestValue) {
                rowIndex = row;
            }
        }
    }
    return rowIndex; 
}
public static float findColLowestValue(float[][] terrain) {
    float currentLowestValue = zmax;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = z;
            if (value < currentLowestValue) {
                colIndex = col;
            }
        }
    }
    return colIndex; 
}
