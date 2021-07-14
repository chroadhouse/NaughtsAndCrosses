enum GameType {
  START, PLAYING, END
}

char[][] board = {{' ',' ',' '},{' ',' ',' '},{' ',' ',' '}};
GameType gameMode = GameType.START;
PImage splashScreen;
char winner = ' ';
boolean isCross;
void setup(){
  size(1200,1200);
  gameMode = GameType.START;
  splashScreen = loadImage("splashScreen.png");
  splashScreen.resize(width,height);
}

void draw(){
  switch(gameMode){
  case START:
    System.out.println("START GAMEMODE");
    background(210,210,210);
    image(splashScreen,0,0);
    break;
    
  case PLAYING:
    background(210,210,210);
    //Varibale for the length of one of the sqaures 
    int w = width/3;
    int h = height/3;
    for(int i=0; i<3; i++){
      for(int j=0;j<3; j++){
        //Works out the middle of each of the aquares 
        int x = w * j + w/2;
        int y = h * i + h/2;
        //Lines for the grid
        line(w,0,w,height);
        line(w*2,0,w*2,height);
        line(0,h,width,h);
        line(0,h*2,width,h*2);
        strokeWeight(4);
        //Draws any symbols that 
        if(board[j][i]=='o'){
          noFill();
          circle(x,y,w/2);
          //Draw an ellipse 
        }else if(board[j][i]=='x'){
          int xr = w/4;
          line(x-xr, y-xr, x+xr, y+xr);
          line(x+xr, y-xr , x-xr, y+xr);
        }
      } 
    }
    System.out.println(winnerCheck());
    winner = winnerCheck();
    if(winnerCheck()!=' ')gameMode = GameType.END;
    break;
  case END:
    background(210,210,210);
    System.out.println("Winning CHAR IS "+winner+" It was there");
    switch(winner){
      case 'x':
        text("Player X has won the macth ",width/2, height/2);
        break;
      case 'o':
        text("Player O has won the match",width/2, height/2);
        break;
    
    }
    break;
  }
}

void keyPressed(){
  // Starts the game
  if(key ==' ' && gameMode !=GameType.PLAYING) {
    gameMode = GameType.PLAYING;
    isCross = false; 
    resetArray();
  }
}

void mousePressed(){
  //Changes players move 
  isCross = !isCross;
  //Sets the vales again
  float h = height/3;
  float w = width/3;
  //This now finds which quadrant in it
  if(mouseY > 0 && mouseY < h){ //first row
    if(mouseX > 0 && mouseX < w){ // 0,0
      addPiece(isCross,0,0);
    }else if(mouseX > w && mouseX < w*2){//1,0
      addPiece(isCross,1,0);
    }else{ //2,0
      addPiece(isCross,2,0);
    }
  }else if(mouseY > h && mouseY < h*2){ // Second Row
    if(mouseX > 0 && mouseX < w){ // 0,1
      addPiece(isCross,0,1);
    }else if(mouseX > w && mouseX < w*2){//1,1
      addPiece(isCross,1,1);
    }else{ //2,1
      addPiece(isCross,2,1);
    }
  }else{ // Third row
    if(mouseX > 0 && mouseX < w){ // 0,2
      addPiece(isCross,0,2);
    }else if(mouseX > w && mouseX < w*2){//1,2
      addPiece(isCross,1,2); 
    }else{ //2,2
      addPiece(isCross,2,2);
    }
  }
}

public void addPiece(boolean isCross, int row, int col){
  //Checks to see if the piece can be placed on the board 
  if(isAvailable(row,col)){
    if(isCross){
      board[row][col] = 'x';
    }else{
      board[row][col] = 'o';
    }
  }
}

public boolean isAvailable(int row, int col){// Method to see what is there 
  return (board[row][col] ==' ');
}

public char winnerCheck(){
  boolean full = true;
  //Horizontal and vertical
  for(int i=0; i<3; i++){
      if(isEqual(board[i][0], board[i][1], board[i][2]) && board[i][0]!=' ') return board[i][0];
      if(isEqual(board[0][i], board[1][i], board[2][i]) && board[0][i]!=' ')return board[0][1];
  }
  //Diagonal
  if((isEqual(board[0][0],board[1][1],board[2][2]) && board[1][1]!=' '))return board[1][1];
  if((isEqual(board[2][0],board[1][1],board[0][2]) && board[0][0]!=' '))return board[1][1];
  //Checks to see if it is full
  for(int i=0; i<3; i++){
    for(int j=0; j<3; j++){
       if(isAvailable(i,j)) full = false;
    }
  }
  if(full) return 'f';
  return ' ';
}

public boolean isEqual(char a,char b,char c){ //See's if 3 values are all the same 
  return (a==b && b==c && a==c);
}

public void resetArray(){ // resets the array 
  for(int i=0; i<3; i++){
    for(int j=0; j<3; j++){
       board[i][j] = ' ';
    }
  }
}
