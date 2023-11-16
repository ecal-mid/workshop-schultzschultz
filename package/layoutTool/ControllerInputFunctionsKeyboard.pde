
// ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

/*
 This tab stores the keyboard input functions for the specific buttons and joysticks.
 Everytime a button is released its own input function is triggered.
 The button input functions map and customize the input to the programs main functions ('GraphicItemControlFunctions').
 Various functions can be positioned on one button by using button combinations (like Button X pressed)
 FEEL FREE to configure the input functions to trigger the various functions you find in the 'GraphicItemControlFunctions' tab.
 */


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– FIXED VARIABLES ––––––––––

boolean tabPressed, shiftPressed, controlPressed, altPressed, upPressed, downPressed, leftPressed, rightPressed, cPressed, wPressed, aPressed, pPressed, lPressed, sPressed;

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– LEFT JOYSTICK ––––––––––––


void keyUp() {
  if (pPressed == true && powerMoveMode == true && moveMode == true && powerMove == "repetition") {
    setYRepetitionPlus();
  } else if (aPressed == true && powerMoveMode == true && moveMode == true && powerMove == "animation") {
    setAnimationSpeedPlus();
  } else if (wPressed == true && activeItem.type == "vector") {
    setStrokeWeightPlus();
  } else if (cPressed == true) {
    setBackgroundColorToNext();
  } else if (shiftPressed == true && controlPressed == true && altPressed == true) {
    reorderItemForward();
  } else if (controlPressed == true && altPressed == true) {
    setScaleOnGrid(-1.25);
  } else if (controlPressed == true) {
    setScale(-1);
  } else if (altPressed == true) {
    moveOnGrid(0, -1.25);
  } else {
    move(0, -1);
  }
}

void keyDown() {

  if (pPressed == true && powerMoveMode == true && moveMode == true && powerMove == "repetition") {
    setYRepetitionMinus();
  } else if (aPressed == true && powerMoveMode == true && moveMode == true && powerMove == "animation") {
    setAnimationSpeedMinus();
  } else if (wPressed == true && activeItem.type == "vector") {
    setStrokeWeightMinus();
  } else if (cPressed == true) {
    setBackgroundColorToPrevious();
  } else if (shiftPressed == true && controlPressed == true && altPressed == true) {
    reorderItemBackward();
  } else if (controlPressed == true && altPressed == true) {
    setScaleOnGrid(1.25);
  } else if (controlPressed == true) {
    setScale(1);
  } else if (altPressed == true) {
    moveOnGrid(0, 1.25);
  } else {
    move(0, 1);
  }
}

void keyLeft() {
  if (pPressed == true && powerMoveMode == true && moveMode == true && powerMove == "repetition") {
    setXRepetitionMinus();
  } else if (cPressed == true) {
    setItemColorToPrevious();
  } else if (lPressed == true) {
    switchLetterToPrevious();
  } else if (shiftPressed == true && controlPressed == true && altPressed == true) {
    setPreviousAsActive();
  } else if (shiftPressed == true) {
    switchGraphicFileToPrevious();
  } else if (controlPressed == true && altPressed == true) {
    setRotationOnGrid(-1.25);
  } else if (controlPressed == true) {
    setRotation(-1);
  } else if (altPressed == true) {
    moveOnGrid(-1.25, 0);
  } else {
    move(-1, 0);
  }
}

void keyRight() {
  if (pPressed == true && powerMoveMode == true && moveMode == true && powerMove == "repetition") {
    setXRepetitionPlus();
  } else if (cPressed == true) {
    setItemColorToNext();
  } else if (lPressed == true) {
    switchLetterToNext();
  } else if (shiftPressed == true && controlPressed == true && altPressed == true) {
    setNextAsActive();
  } else if (shiftPressed == true) {
    switchGraphicFileToNext();
  } else if (controlPressed == true && altPressed == true) {
    setRotationOnGrid(1.25);
  } else if (controlPressed == true) {
    setRotation(1);
  } else if (altPressed == true) {
    moveOnGrid(1.25, 0);
  } else {
    move(1, 0);
  }
}

void keyR() {
  if (powerMoveMode == false) {
    if (shiftPressed == true && controlPressed == true && altPressed == true) {
      reset();
    } else if (altPressed == true) {
      setupAllItemsRandom();
    } else {
      setupRandom();
    }
  }
}

void keyX() {
  switchBlendMode();
}

void keyM() {
  if (activeItem.type == "image") {
    switchImageMode_AlphaOnOrOff();
  } else if (activeItem.type == "vector") {
    switchVectorMode_FillOrStroke();
  } else if (activeItem.type == "font") {
    setFontStyle();
  } else if (activeItem.type == "cam") {
    switchCamMode_LiveOrShot();
  }
}

void keyEnter() {
  if (lPressed == true && activeItem.type == "font" ) {
    addLetter();
  } else if (powerMoveMode == false) {
    addItem();
  } else if (powerMoveMode == true) {
    confirmPowerMove();
  }
}

void keyBackspace() {
  if (lPressed == true && activeItem.type == "font" ) {
    deleteLetter();
  } else if (powerMoveMode == false) {
    deleteItem();
  } else if (powerMoveMode == true) {
    deletePowerMove();
  }
}

void keyTab() {
  if (powerMoveMode == true) {
    quitPowerMoveMode();
  } else {
    activatePowerMoveMode();
  }
}

void keyE() {
  export();
}

void keyS() {
  if (controlPressed == true) {
    switchBackgroundSound();
  } else {
    switchInterfaceSound();
  }
}
