int cols, rows;
int scl = 20;
int w = 1200; 
int h = 900;
static int colIndex;
static int rowIndex;

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
  
       float max = findHighestValue(terrain);
       float min = findLowestValue(terrain);
       float rowIndexMax = findRowHighestValue(terrain);
       float colIndexMax = findColHighestValue(terrain);
       float rowIndexMin = findRowLowestValue(terrain);
       float colIndexMin = findColLowestValue(terrain);
       float range = max - min;
       float colorScale = range/(cols*rows);
       System.out.println(colIndexMax + " col max");
       System.out.println(rowIndexMax + " row max");
       System.out.println(colIndexMin + " col min");
       System.out.println(rowIndexMin + " row min");
  
  for (int y = 0; y < rows - 1; y++) {
    
    beginShape(TRIANGLE_STRIP);
    
    for (int x = 0; x < cols; x++) {
      
       vertex(x*scl, y*scl, terrain[x][y]);
       vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
       
       colorMode(HSB, 360, 100, 100);
       float h;
       float s = 100;
       float b = 100;
       
       // TURN THE COLORS TO HSL IN ORDER TO USE HUE https://stackoverflow.com/questions/12875486/what-is-the-algorithm-to-create-colors-for-a-heatmap
       
       //float max = findHighestValue(terrain);
       //float min = findLowestValue(terrain);
       
       //float range = max - min;
       //float colorScale = range/(cols*rows);
       //System.out.println(colorScale);
       
       h = ((1 - colorScale) * 360) - 90;
       //h = ((1 - terrain[x][y]/100) * 360) - 90;
       //h = (1 - terrain[x][y]/360) * 360;
       fill(h, s, b);
       
       
       
    }
    
    endShape();
  
  }
  
}

public static float findHighestValue(float[][] terrain) {
    float currentHighestValue = Float.MIN_VALUE;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = terrain[row][col];
            if (value > currentHighestValue) {
                currentHighestValue = value;
            }
        }
    }
    return currentHighestValue; 
}
public static float findRowHighestValue(float[][] terrain) {
    float currentHighestValue = Float.MIN_VALUE;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = terrain[row][col];
            if (value > currentHighestValue) {
                rowIndex = row;
            }
        }
    }
    return rowIndex; 
}
public static float findColHighestValue(float[][] terrain) {
    float currentHighestValue = Float.MIN_VALUE;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = terrain[row][col];
            if (value > currentHighestValue) {
                colIndex = col;
            }
        }
    }
    return colIndex; 
}

public static float findLowestValue(float[][] terrain) {
    float currentLowestValue = Float.MAX_VALUE;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = terrain[row][col];
            if (value < currentLowestValue) {
                currentLowestValue = value;
                //int colIndex = col;
                //int rowIndex = row;
                //System.out.println(colIndex + "column");
                //System.out.println(rowIndex + "row");
            }
        }
    }
    return currentLowestValue;
}
public static float findRowLowestValue(float[][] terrain) {
    float currentLowestValue = Float.MAX_VALUE;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = terrain[row][col];
            if (value < currentLowestValue) {
                rowIndex = row;
            }
        }
    }
    return rowIndex; 
}
public static float findColLowestValue(float[][] terrain) {
    float currentLowestValue = Float.MAX_VALUE;
    for (int row = 0; row < terrain.length; row++) {
        for (int col = 0; col < terrain[row].length; col++) {
            float value = terrain[row][col];
            if (value < currentLowestValue) {
                colIndex = col;
            }
        }
    }
    return colIndex; 
}
