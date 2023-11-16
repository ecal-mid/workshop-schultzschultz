
// !!! PLEASE DO NOT MODIFY THIS TAB !!! ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––– !!! PLEASE DO NOT MODIFY THIS TAB !!! 

/*
 The 'Power Move Mode' is a special program mode featuring a set of additional effects.
 This tab stores only the program functionaly of this mode.
 To add a new move watch for the functions 'checkCombo', 'updatePowerMove' and 'deleteCombo' in the 'GraphicItemControlFunctions' tab.
 */


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– FICED VARIABLES –––––––––––––

// Mode
boolean powerMoveMode = false;

// Button Combo
Boolean  comboMode = false;
int      comboModeTimerAtStart;
int      comboModeTimerMax = 2; //SECONDS
String[] combo = {"", "", ""};
int      comboIndex = 0;
String   comboKeys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

Boolean  comboComplete = false;
Boolean  comboValid = false;
int      comboCompleteTimerAtStart;
int      comboCompleteTimerMax = 1;
float    transition = 0.9;

//Move
Boolean  moveMode = false;
String   powerMove = "";


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– UPDATE -––––––––––––––––––––

void updatePowerMoveMode() {
  if (comboMode) {
    updateComboMode();
  } else if (moveMode) {
    updatePowerMove();
  }
}

void updateComboMode() {
  // Check if timer is over and if the combo is complete to check for validation and combo move
  int comboTimer = ceil(map(frameCount-comboModeTimerAtStart, 0, comboModeTimerMax*frameRate, comboModeTimerMax, 0));
  if (comboTimer < 0) {
    quitPowerMoveMode();
  } else if (comboComplete) {
    if (frameCount > comboCompleteTimerAtStart + (comboCompleteTimerMax*frameRate)) {
      if (comboValid == true) {
        comboMode = false;
      } else {
        quitPowerMoveMode();
      }
    }
  } else if (comboIndex == 3) {
    comboComplete = true;
    comboCompleteTimerAtStart = frameCount;
    comboModeTimerAtStart += comboCompleteTimerMax*frameRate;
    String comboString = "" + combo[0] + combo[1] + combo[2];
    powerMove = checkCombo(comboString);
    if (comboValid) {
      moveMode = true;
      if (interfaceSound == true) {
        playSound("valid combo");
      }
    } else {
      if (interfaceSound == true) {
        playSound("invalid combo");
      }
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– DISPLAY –––––––––-––––––––––

void  displayPowerMoveMode() {
  if (comboMode) {
    displayComboMode();
  }
  if (moveMode) {
    displayMoveMode();
  }
}

void displayComboMode() {

  float animationOut = 0;
  if (comboComplete == false) {
    animationOut = 1.0;
  } else {
    animationOut = map(frameCount, comboCompleteTimerAtStart + comboCompleteTimerMax*transition*frameRate,
      comboCompleteTimerAtStart + comboCompleteTimerMax*frameRate, 1.0, 0);
    animationOut = constrain(animationOut, 0.0, 1.0);
  }

  float animationIn = constrain(map(frameCount-comboModeTimerAtStart, 0, comboModeTimerMax*frameRate, 0, TWO_PI), 0, TWO_PI);
  float size = min(width, height) / 2;

  pushStyle();
  pushMatrix();

  blendMode(BLEND);
  strokeCap(SQUARE);

  translate(width/2, height/2);
  noStroke();
  fill(grey, (255*(1.0-alphaInactivityMin))*animationOut);
  rect(0, 0, width, height);

  if (comboComplete) {
    noFill();
    if (comboValid == true) {
      stroke(black, animationOut*255);
    } else {
      stroke(red, animationOut*255);
    }
    strokeWeight(UIstrokeWeight);
    ellipse(0, 0, size, size);
  } else {

    noFill();
    stroke(white, animationOut*255);
    strokeWeight(UIstrokeWeight);
    ellipse(0, 0, size, size);
    stroke(black);
    arc(0, 0, size, size, 0-HALF_PI, animationIn-HALF_PI, OPEN);
  }

  if (comboValid == true) {
    translate(0, UItextSize*0.25);
    fill(black, animationOut*255);
    textFont(UIFontBold);
    textSize(UItextSize);
    textAlign(CENTER);
    text("" + powerMove, 0, 0);
    textFont(UIFontRegular);
    textSize(UItextSize*0.5);
    textAlign(CENTER);
    text("active", 0, UItextSize*0.75);
  } else {
    noStroke();
    translate(-(UIstrokeWeight*3), 0);
    for ( int i = 0; i<3; i++) {
      if (comboComplete) {
        fill(red, animationOut*255);
      } else if (i+1 > comboIndex) {
        fill(white, animationOut*255);
      } else {
        fill(black, animationOut*255);
      }
      ellipse(0, 0, UIstrokeWeight*1.4, UIstrokeWeight*1.4);
      translate(UIstrokeWeight*3, 0);
    }
  }

  popMatrix();
  popStyle();
}

void displayMoveMode() {
  float animationIn = map(frameCount, comboCompleteTimerAtStart + comboCompleteTimerMax*transition*frameRate, 
  comboCompleteTimerAtStart + comboCompleteTimerMax*frameRate, 0.0, 1.0);
  animationIn = constrain(animationIn, 0.0, 1.0);
  pushStyle();
  pushMatrix();
  blendMode(BLEND);
  strokeWeight(UIstrokeWeight*2*animationIn);
  noFill();
  stroke(white);
  rect(width/2, height/2, width, height);
  popMatrix();
  popStyle();
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– ACTIVATE –––––––––––––––––––

void activatePowerMoveMode() {
  powerMoveMode = true;
  comboMode = true;
  moveMode = false;
  comboModeTimerAtStart = frameCount;
  comboCompleteTimerAtStart = 0;
  comboComplete = false;
  comboValid = false;
  if (interfaceSound == true) {
    playSound("activate power move");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– QUIT –––––––––––––––––––––––

void quitPowerMoveMode() {
  powerMoveMode = false;
  comboMode = false;
  moveMode = false;
  comboIndex = 0;
  combo[0] = "";
  combo[1] = "";
  combo[2] = "";
  powerMove = "";
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– CONFIRM ––––––––––––––––––––

void confirmPowerMove() {
  quitPowerMoveMode();
  if (interfaceSound == true) {
    playSound("confirm power move");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– RESET ––––––––––––––––––––––

void resetPowerMove() {
  deletePowerMove();
  if (interfaceSound == true) {
    playSound("reset power move");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– ADD BUTTON –––––––––––––––––

void addButtonToCombo(String s) {
  combo[comboIndex] = s;
  comboIndex++;
  if (interfaceSound == true) {
    playSound("add combo");
  }
}
