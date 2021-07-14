import java.util.Arrays;
public enum GameType{
  ONEPLAYER, TWOPLAYER, TWOPLAYEREND, START, ONEPLAYEREND
}
int[][] gridArray = {{0,0,0},{0,0,0},{0,0,0}};
float lineX,lineY, x,y = 0;
int crossPlayer, naughtPlayer = 0;
boolean cross = false;
boolean full = true;
boolean reset = true;
boolean crossWin = false;
PImage splashScreen;
GameType gameMode = GameType.START;

void setup(){
  size(900,900);
  splashScreen = loadImage("splashScreen.png");
  splashScreen.resize(width,height);
}

void draw(){
  if(gameMode == GameType.TWOPLAYER){
    if(reset){ background(210,210,210); reset = false; }
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
  }
  if(gameMode == GameType.START){ 
      System.out.println("START GAMEMODE");
      background(210,210,210);
      image(splashScreen,0,0);
  }
  
  if(gameMode == GameType.TWOPLAYEREND){
    background(210,210,210);
    System.out.println("THE GAME HAS ENDED");
    if(full){
      textSize(40);
      text("No one won",width*0.4, height*0.25);
      textSize(25);
      text("Crosses: "+crossPlayer+"",width*0.4,height*0.3);
      text("Naughts: "+naughtPlayer+"",width*0.4, height*0.5);
    }else{
      if(crossWin){
        textSize(40);
        text("Crosses Win", width*0.4, height*0.25);
        textSize(25);
        text("Crosses: "+crossPlayer+"",width*0.4,height*0.3);
        text("Naughts: "+naughtPlayer+"",width*0.4, height*0.5);
      }else if(!crossWin){
        textSize(40);
        text("Naughts Win", width*0.4, height*0.25);
        textSize(25);
        text("Crosses: "+crossPlayer+"",width*0.4,height*0.3);
        text("Naughts: "+naughtPlayer+"",width*0.4, height*0.5);
      }
    }
    
   
  }
}

void keyPressed(){
  if(key == ' ' && gameMode==GameType.START){
    System.out.println("COMNG");
    gameMode = GameType.TWOPLAYER;
  }
  
  if(gameMode==GameType.TWOPLAYEREND){
    //Here i will check the different option
    if(key=='1'){
      //Then play again
      reset = true;
      cross = false;
      resetArray();
      gameMode = GameType.TWOPLAYER;
    }
  }
}


void mousePressed(){
  if(gameMode == GameType.TWOPLAYER){
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

public boolean crossWinCheck(int i){
  if(i==1) {
    crossPlayer++;
    return true;
  }
  else{ 
    naughtPlayer++;
    return false;
  }
}

public void checkWin(){
  boolean win = false;
  full = true;
  //Check Horizontal
  for(int i=0; i<3; i++){
    if(gridArray[i][0] == gridArray[i][1] && gridArray[i][2] == gridArray[i][0]){
      if(gridArray[i][0] != 0){
        crossWin = crossWinCheck(gridArray[i][0]);
        win = true;
        break;
      }
    }
  }
  //Check vertical 
  for(int i=0; i<3; i++){
    if(gridArray[0][i] == gridArray[1][i] && gridArray[2][i] == gridArray[1][i]){
      if(gridArray[0][i] != 0){
        crossWin = crossWinCheck(gridArray[0][i]);
        win = true;
        break;
      }
    }
  }
  
  //Check Diagonal
  if(gridArray[0][0] == gridArray[1][1] && gridArray[1][1] == gridArray[2][2]){
      if(gridArray[1][1] != 0){
        crossWin = crossWinCheck(gridArray[1][1]);
        win = true;
      }
  }
  
  if(gridArray[0][2] == gridArray[1][1] && gridArray[1][1] == gridArray[2][0]){
      if(gridArray[1][1] != 0){
        crossWin = crossWinCheck(gridArray[1][1]);
        win = true;
      }
  }
  
  if(win){
    gameMode = GameType.TWOPLAYEREND;
    full = false;
    //reset = true;
    //resetArray();
  }else{
    for(int i=0; i<3; i++){
      for(int j=0; j<3; j++){
        if(gridArray[i][j] == 0){
           full = false;
        }
      }
    }
    if(full) {
      gameMode = GameType.TWOPLAYEREND;
      //reset = true;
      //resetArray();
    }
  }
}

public void resetArray(){
  for(int i=0; i<3; i++){
    for(int j=0; j<3; j++){
      gridArray[i][j] = 0;
    }
  }
}
