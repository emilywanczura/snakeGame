boolean playGame;
int yPos, xPos, yDir, xDir;
int fishCount=0;
PVector fishPosition;
float[] snakeX = new float[10];
float[] snakeY = new float[10];

void setup() {
  size(800, 800);
  background(#001833);
  frameRate(5);
  yPos=height/2;
  xPos=width*11/20;
  yDir=0;
  xDir=width/20;
  strokeWeight(0);
  playGame = false;
  drawGrid();
  welcomeScreen();
  fishPosition = new PVector((int)random(1, 19)*width/20, (int)random(2, 19)*height/20);
}

void draw() {
  if (playGame == true) {
    background(#001833);
    strokeWeight(0);
    drawGrid();
    snakeX[0] = xPos;
    snakeY[0] = yPos;
    for (int bodyPosition=fishCount; bodyPosition>0; bodyPosition--) {
      snakeX[bodyPosition] = snakeX[bodyPosition-1];
      snakeY[bodyPosition] = snakeY[bodyPosition-1];
    }
    xPos+=xDir;
    yPos+=yDir;
    drawFruit(fishPosition.x, fishPosition.y);
    checkDirection();
    for (int bodySegment=1; bodySegment<=fishCount; bodySegment++) {
      fill(#FFE100);
      strokeWeight(0);
      rect(snakeX[bodySegment]-width/40, snakeY[bodySegment]-height/40, width/20, height/20, 30);
    }
    if (dist(xPos, yPos, fishPosition.x, fishPosition.y) < width/120) {
      fishCount+=1;
      fishPosition = new PVector((int)random(1, 19)*width/20, (int)random(2, 19)*height/20);
      if (fishCount == 10) {
        playGame = false;
        winScreen();
      }
    }
    for (int i=2; i<snakeX.length; i++){
     if (snakeX[0] == snakeX[i] && snakeY[0] == snakeY[i]){
      gameOver();
     }
    }
    if (fishCount>=1) {
      scoreDisplay();
    }
    checkGameLoss();
  }
}

void drawGrid() {
  for (int i=1; i<39; i+=2) {
    for (int j=3; j<39; j+=2) {
      if ((j-i)%4==0) {
        drawCell(i*width/40, j*height/40, true);
      } else {
        drawCell(i*width/40, j*height/40, false);
      }
    }
  }
}

void drawCell(float x, float y, boolean colour) {
  if  (colour == true) {
    fill(#003166);
  } else {
    fill(#003d80);
  }
  square(x, y, width/20);
}

void drawFruit(float x, float y) {
  fill(#F05E16);
  triangle(x, y, x+width/40, y-height/40, x+width/40, y+height/40);
  circle(x, y, width/25);
}

void checkDirection() {
  if (xDir > 0) {
    drawCharRight();
  } else if (xDir < 0) {
    drawCharLeft();
  } else if (yDir < 0) {
    drawCharUp();
  } else if (yDir > 0) {
    drawCharDown();
  }
}

void gameOver(){
 playGame=false;
 gameOverScreen();
}

void checkGameLoss() {
  if (xPos+width/40>width) {
    gameOver();
  } else if (xPos-width/40<0) {
    gameOver();
  } else if (yPos+height/40>height) {
    gameOver();
  } else if (yPos-height/30<width/40) {
    gameOver();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      if (playGame == false){
        playGame = true;
        yPos=height/2;
        xPos=width*11/20;
        yDir=0;
        xDir=width/20;
        drawCharRight();
        fishPosition = new PVector((int)random(1, 19)*width/20, (int)random(2, 19)*height/20);
        fishCount=0;
        snakeX=new float[10];
        snakeY=new float[10];
      }
    }
    if (keyCode == UP) {
      if (fishCount>0 && yDir!=0) {
      } else {
        yDir=-height/20;
        xDir=0;
      }
    }
    if (keyCode == DOWN) {
      if (fishCount>0 && yDir!=0) {
      } else {
        yDir=height/20;
        xDir=0;
      }
    }
    if (keyCode == LEFT) {
      if (fishCount>0 && xDir!=0) {
      } else {
        xDir=-width/20;
        yDir=0;
      }
    }
    if (keyCode == RIGHT) {
      if (fishCount>0 && xDir!=0) {
      } else {
        xDir=width/20;
        yDir=0;
      }
    }
  }
}

void scoreDisplay() {
  fill(#F05E16);
  triangle(width/20, height*3/80, width*3/40, height/80, width*3/40, height*5/80);
  circle(width/20, height*3/80, width/25);
  textSize(36);
  textAlign(CENTER);
  fill(255);
  text(fishCount, width/8, height/20);
}

void welcomeScreen() {
  fill(#F7C4A7);
  rect(width/5, height*9/40, width*3/5, height/2);
  textSize(18);
  textAlign(CENTER);
  fill(0);
  text("WELCOME TO EEL", width/2, height*3/10);
  textAlign(LEFT);
  text("Game Instructions:", width/4, height*9/24);
  text("*****************************************************", width/4, height*10/24);
  text("Use LEFT, RIGHT, UP, DOWN to move.", width/4, height*11/24);
  text("Eat 10 fish to win.", width/4, height*13/24);
  text("Press SHIFT to start.", width/4, height*15/24);
}

void gameOverScreen() {
  strokeWeight(2);
  fill(#F7C4A7);
  rect(width/5, height*9/40, width*3/5, height/2);
  textSize(18);
  fill(0);
  textAlign(LEFT);
  text("GAME OVER", width/4, height*9/24);
  text("*****************************************************", width/4, height*10/24);
  text("Score: " + fishCount, width/4, height/2);
  text("Press SHIFT to restart.", width/4, height*15/24);
}

void winScreen() {
  strokeWeight(2);
  fill(#F7C4A7);
  rect(width/5, height*9/40, width*3/5, height/2);
  textSize(18);
  fill(0);
  textAlign(LEFT);
  text("Congratulations! You won.", width/4, height*9/24);
  text("*****************************************************", width/4, height*10/24);
  text("Score: 10", width/4, height/2);
  text("Press SHIFT to restart.", width/4, height*15/24);
}

void drawCharRight() {
  strokeWeight(2);
  stroke(0);
  fill(#FFE100);
  circle(xPos, yPos, width/15);
  fill(255);
  circle(xPos-width/64, yPos-height/64, width/64);
  circle(xPos-width/64, yPos+height/64, width/64);
  fill(0);
  circle(xPos-width/96, yPos-height/64, width/128);
  circle(xPos-width/96, yPos+height/64, width/128);
  stroke(255, 0, 0);
  line(xPos+width/40, yPos, xPos+width/20, yPos);
  strokeWeight(1);
  stroke(0);
  noFill();
  circle(xPos+width/128, yPos-height/128, width/156);
  circle(xPos+width/128, yPos+height/128, width/156);
}

void drawCharLeft() {
  strokeWeight(2);
  stroke(0);
  fill(#FFE100);
  circle(xPos, yPos, width/15);
  fill(255);
  circle(xPos+width/64, yPos-height/64, width/64);
  circle(xPos+width/64, yPos+height/64, width/64);
  fill(0);
  circle(xPos+width/96, yPos-height/64, width/128);
  circle(xPos+width/96, yPos+height/64, width/128);
  stroke(255, 0, 0);
  line(xPos-width/40, yPos, xPos-width/20, yPos);
  strokeWeight(1);
  stroke(0);
  noFill();
  circle(xPos-width/128, yPos-height/128, width/156);
  circle(xPos-width/128, yPos+height/128, width/156);
}

void drawCharUp() {
  strokeWeight(2);
  stroke(0);
  fill(#FFE100);
  circle(xPos, yPos, width/15);
  fill(255);
  circle(xPos-width/64, yPos+height/64, width/64);
  circle(xPos+width/64, yPos+height/64, width/64);
  fill(0);
  circle(xPos-width/64, yPos+height/96, width/128);
  circle(xPos+width/64, yPos+height/96, width/128);
  stroke(255, 0, 0);
  line(xPos, yPos-height/40, xPos, yPos-height/20);
  strokeWeight(1);
  stroke(0);
  noFill();
  circle(xPos-width/128, yPos-height/128, width/156);
  circle(xPos+width/128, yPos-height/128, width/156);
}

void drawCharDown() {
  strokeWeight(2);
  stroke(0);
  fill(#FFE100);
  circle(xPos, yPos, width/15);
  fill(255);
  circle(xPos-width/64, yPos-height/64, width/64);
  circle(xPos+width/64, yPos-height/64, width/64);
  fill(0);
  circle(xPos-width/64, yPos-height/96, width/128);
  circle(xPos+width/64, yPos-height/96, width/128);
  stroke(255, 0, 0);
  line(xPos, yPos+height/40, xPos, yPos+height/20);
  strokeWeight(1);
  stroke(0);
  noFill();
  circle(xPos-width/128, yPos+height/128, width/156);
  circle(xPos+width/128, yPos+height/128, width/156);
}
