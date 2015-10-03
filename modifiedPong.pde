// i did number 2 and 7
class Ball {
  float initialX, initialY;
  float x, y;
  float vx, vy;
  float size = 10;
  color c;
  color s;

  Ball(float x, float y, color c, color s) {
    this.x = initialX = x;
    this.y = initialY = y;
    this.c = c;
    this.s=s;
    vx = 2+random(4);
    vy = random(4);
  }

  void draw() {
    noStroke();
    fill(c);
    ellipse(x, y, size*2, size*2);
  }

  void reset() {
    background(255);
    x = initialX;
    y = initialY;
    loop();
    vx = 2+random(4);
    if (random(1) < 0.5) {
      vx = -vx;
    }
    vy = random(4) - 1;
  }

  void move() {
    x += vx;
    y += vy;
    if (x < size || x > width-size) {
      vx = -vx;
    }
    if (y < size || y > height-size) {
      vy = -vy;
    }
    if (x-size < leftPaddle.x + leftPaddle.w) {
      if (y > leftPaddle.y &&
          y < leftPaddle.y + leftPaddle.h) {
        vx = -vx;
      } else {
        fill(255);
        background(s);
        noLoop();
        rightScore++;
        upScore++;
        downScore++;
        text("press r to reset", 200,200);
      }
    }
    if (x+size > rightPaddle.x) {
      if (y > rightPaddle.y &&
          y < rightPaddle.y + rightPaddle.h) {
        vx = -vx;
      } else {
        fill(255);
        background(s);
        noLoop();
        leftScore++;
        upScore++;
        downScore++;
        text("press r to reset", 200,200);
      }
    }
     if (y+size > downPaddle.y) {
      if (x > downPaddle.x &&
          x < downPaddle.x + downPaddle.w) {
        vy = -vy;
      } else {
        fill(255);
        background(s);
        noLoop();
        leftScore++;
        rightScore++;
        upScore++;
        text("press r to reset", 200,200);
      }
    }
     if (y-size < upPaddle.y + upPaddle.h) {
      if (x > upPaddle.x &&
          x < upPaddle.x + upPaddle.w) {
        vy = -vy;
      } else {
        fill(255);
        background(s);
        noLoop();
        rightScore++;
        leftScore++;
        downScore++;
        text("press r to reset", 200,200);
      }
    }
  }
}

class Paddle {
  float x, y;
  float vy;
  float w = 15, h = 80;
  color c;

  Paddle(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    vy = 0;
  }

  void draw() {
    noStroke();
    fill(c);
    rect(x, y, w, h);
  }

  void move() {
    y += vy;
    if (y < 0 || y > height-h) {
      vy = 0;
      y = constrain(y, 0, height-h);
    }
  }
}

class Paddlez {
  float x, y;
  float vx;
  float w = 80, h = 15;
  color c;

  Paddlez(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    vx = 0;
  }

  void draw() {
    noStroke();
    fill(c);
    rect(x, y, w, h);
  }

  void move() {
    x += vx;
    if (x < 0 || x > width-w) {
      vx = 0;
      x = constrain(x, 0, width-w);
    }
  }
}

Ball b;
Paddle leftPaddle, rightPaddle;
Paddlez upPaddle, downPaddle;
int leftScore = 0;
int rightScore = 0;
int upScore = 0;
int downScore= 0;

void setup() {
  size(500, 500);
  colorMode(HSB);
  b=(new Ball(width/2, height/2, color(40, 255, 255),color(6, 255, 255)));

  leftPaddle = new Paddle(15, 150, color(0));
  rightPaddle = new Paddle(width-15-15, 150, color(0));
  upPaddle = new Paddlez(150, 15, color(0));
  downPaddle= new Paddlez(150, height-15-15,color(0));
  
}

void drawScores() {
  textSize(32);
  text("L "+leftScore,200, 225);
  text("R "+rightScore, 200, 250);
  text("U "+upScore, 200, 275);
  text("D "+downScore, 200, 300);
  
}

void draw() {
  background(255);

 b.draw();
 b.move();

  leftPaddle.move();
  leftPaddle.draw();
  rightPaddle.move();
  rightPaddle.draw();
  upPaddle.move();
  upPaddle.draw();
  downPaddle.move();
  downPaddle.draw();
  drawScores();
}

void keyPressed() {
  if (key == 'q') {
    leftPaddle.vy = -6;
  }
  if (key == 'a') {
    leftPaddle.vy = 6;
  }
  if (key == 'o') {
    rightPaddle.vy = -6;
  }
  if (key == 'l') {
    rightPaddle.vy = 6;
  }
   if (key == 'z') {
    upPaddle.vx = -6;
  }
  if (key == 'x') {
    upPaddle.vx = 6;
  }
  if (key == 'n') {
    downPaddle.vx = -6;
  }
  if (key == 'm') {
    downPaddle.vx = 6;
  }
  if (key=='r')
  {
    b.reset();
  }
}

void keyReleased() {
  if (key == 'q' && leftPaddle.vy < 0) {
    leftPaddle.vy = 0;
  }
  if (key == 'a' && leftPaddle.vy > 0) {
    leftPaddle.vy = 0;
  }
  if (key == 'o' && rightPaddle.vy < 0) {
    rightPaddle.vy = 0;
  }
  if (key == 'l' && rightPaddle.vy > 0) {
    rightPaddle.vy = 0;
  }
  if (key == 'z' && upPaddle.vx < 0) {
    upPaddle.vx = 0;
  }
  if (key == 'x' && upPaddle.vx > 0) {
    upPaddle.vx = 0;
  }
    if (key == 'n' && downPaddle.vx < 0) {
    downPaddle.vx = 0;
  }
  if (key == 'm' && downPaddle.vx > 0) {
    downPaddle.vx = 0;
  }
}
