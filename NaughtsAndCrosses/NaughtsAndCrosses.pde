import java.util.Arrays;
public enum gameType{
  ONEPLAYER, TWOPLAYER, END, START
}
int[][] gridArray = {{0,0,0},{0,0,0},{0,0,0}};
float lineX,lineY, x,y = 0;
boolean cross = false;
boolean win = false;
void setup(){
  size(900,900);
  printArray();
}

void draw(){
   lineX = 300;
  while(lineX < width){
    line(lineX,0,lineX,height);
    lineX = lineX +300;
  }
  
  lineY = 300;
  while(lineY < height){
    line(0,lineY,width,lineY);
    lineY = lineY + 300;
  }
  printArray();
  //line(450,0,450,900);
  if(win){
    System.out.println("WINNER");
  }
}

void mousePressed(){
  if(cross){
    cross = false;
  }else{
    cross = true;
  }
  
  y=0; x=0;
  if(mouseY > y && mouseY < y+300){ // ROW1
    if(mouseX > x && mouseX < x+300){ // column 1
    //x and y shpould be 0
      drawShape(cross,x,y,0,0);
    }else if(mouseX > x+300 && mouseX< x+600){ //colum2
      x = x+300;
      drawShape(cross,x,y,0,1);
    }
    else{
      x = x+600;
      drawShape(cross,x,y,0,2);
    }
  }else if(mouseY > y+300 && mouseY <y+600){
    y = y+300;
    if(mouseX > x && mouseX < x+300){ // column 1
      drawShape(cross,x,y,1,0);
    }else if(mouseX > x+300 && mouseX< x+600){ //colum2
      x = x+300;
      drawShape(cross,x,y,1,1);
    }
    else{
      x = x+600;
      drawShape(cross,x,y,1,2);
    }
  }else{
    y = y+600;
    if(mouseX > x && mouseX < x+300){ // column 1
      drawShape(cross,x,y,2,0);
    }else if(mouseX > x+300 && mouseX< x+600){ //colum2
      x = x+300;
      drawShape(cross,x,y,2,1);
    }
    else{
      x = x+600;
      drawShape(cross,x,y,2,2);
    }
  }
}

public void printArray(){
  System.out.println(Arrays.deepToString(gridArray));
}
//0 is nothing, 1 is x and 2 is O
public void drawShape(boolean cross, float x, float y, int row, int col){
  if(gridArray[row][col]==0){
    if(cross){
      line(x+30,y+30,x+270,y+270);
      line(x+270,y+30,x+30,y+270);
      gridArray[row][col] = 1;
      checkWin();
    }else{
      circle(x+150,y+150,200);
      gridArray[row][col] = 2;
      checkWin();
    }
  }
}

public void checkWin(){
  win = false;
  //Check Horizontal
  for(int i=0; i<3; i++){
    if(gridArray[i][0] == gridArray[i][1] && gridArray[i][2] == gridArray[i][0]){
      if(gridArray[i][0] != 0){
        win = true;
      }
    }
  }
  //Check vertical 
  for(int i=0; i<3; i++){
    if(gridArray[0][i] == gridArray[1][i] && gridArray[2][i] == gridArray[1][i]){
      if(gridArray[0][i] != 0){
        win = true;
      }
    }
  }
  
  //Check Diagonal
  if(gridArray[0][0] == gridArray[1][1] && gridArray[1][1] == gridArray[2][2]){
      if(gridArray[1][1] != 0){
        win = true;
      }
  }
  
  if(gridArray[0][2] == gridArray[1][1] && gridArray[1][1] == gridArray[2][0]){
      if(gridArray[1][1] != 0){
        win = true;
      }
  }
}
