class CellularAutomata {
   int[][] grid;
   int w = 20;
   
   CellularAutomata() {
      grid = new int[width/w][height/w];
   }
   
   void drawGrid() {
      clear();
      background(255);
      drawBackgroundGrid();
      for(int i = 0; i < grid.length; i++) {
        for(int j = 0; j < grid[0].length; j++) {
            if(grid[i][j] == 1) {
              fill(0);
              rect(i * w, j * w, w, w);  
            }
        }
      }
      delay(300);
   }
   
   void updateGrid() {
     int[][] nextGrid = new int[width/w][height/w];
     for (int i = 1; i < (width/w) - 1; i++) {
       for(int j = 1; j < (height/w) - 1; j++) {
         int count = countNeighbours(i, j);
         if((grid[i][j] == 1) && (count < 2 || count > 3)) {
            nextGrid[i][j] = 0; 
         } else if (grid[i][j] == 0 && count == 3) {
            nextGrid[i][j] = 1; 
         } else {
            nextGrid[i][j] = grid[i][j]; 
         }
       }
     }
     grid = nextGrid;
   }  
   
   int countNeighbours(int i, int j) {
      int count = 0;
      for(int k = i - 1; k <= i + 1; k++) {
         for(int g = j - 1; g <= j + 1; g++) {
             if (grid[k][g] == 1) {
                 if(k != i || g != j)
                    count++;
             }
         }
      }
      println("Count" + i + j + ": " + count);
      return count;
   }
   
   void setGrid(int[][] grid) {
      this.grid = grid; 
   }
}

CellularAutomata ca;

void drawBackgroundGrid() {
   for(int i = 0; i < width; i += ca.w) {
        for(int j = 0; j < height; j += ca.w) {
           line(i, j, width, j); 
        }
        line(i, 0, i, height);
   } 
}

void setup() {
   size(800, 600);
   background(255);
   ca = new CellularAutomata();
   drawBackgroundGrid();
   
   map = new int[width/ca.w][height/ca.w];
}

boolean start = false;

void draw() {
  if (start) {
     for(int i = 0; i < 1; i++) {
       ca.drawGrid();
       ca.updateGrid();
     }
     
  }
}

int[][] map;

void keyPressed() {
  if (keyCode == ENTER) {
    if (start)
      start = false;
    else
      start = true;
    ca.setGrid(map);
  }
}

void mouseClicked() {
    for(int i = 0; i < width; i += ca.w) {
       for(int j = 0; j < height; j += ca.w) {
          if(mouseX > i && mouseX < i + ca.w)
            if(mouseY > j && mouseY < j + ca.w) {
               fill(0);
               rect(i, j, ca.w, ca.w);
               map[i/ca.w][j/ca.w] = 1;
            }
       }
    }
}