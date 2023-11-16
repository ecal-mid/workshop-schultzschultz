
// ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

/*
 This tab stores the gamepad input functions for the specific buttons and joysticks.
 Everytime a button is released its own input function is triggered.
 The button input functions map and customize the input to the programs main functions ('GraphicItemControlFunctions').
 Various functions can be positioned on one button by using button combinations (like Button X pressed)
 FEEL FREE to configure the input functions to trigger the various functions you find in the 'GraphicItemControlFunctions' tab.
 */


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– FIXED VARIABLES ––––––––––

float LX, LY, RX, RY;
boolean hatLeftPressed, hatRightPressed, hatUpPressed, hatDownPressed, crossPressed, squarePressed, trianglePressed, circlePressed,
  sharePressed, optionsPressed, psPressed, touchpadPressed, L1Pressed, L2Pressed, L3Pressed, R1Pressed, R2Pressed, R3Pressed,
  LXPlusPressed, LXMinusPressed, LYPlusPressed, LYMinusPressed, RXPlusPressed, RXMinusPressed, RYPlusPressed, RYMinusPressed;

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– LEFT JOYSTICK ––––––––––––

void joystickLeft(float x, float y) {
  if (x > 0.05 || x < -0.05 || y > 0.05 || y < -0.05) {
    if (L2Pressed == true) {
      moveOnGrid(x, y);
    } else {
      move(x, y);
    }
  } else {
    if (interfaceSound == true) {
      endSound("move");
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– RIGHT JOYSTICK –––––––––––

void joystickRight(float x, float y) {
  if ((x > 0.1 || x < -0.1) && abs(x) > abs(y)) {
    if (L2Pressed == true) {
      setRotationOnGrid(x);
    } else {
      setRotation(x);
    }
  } else {
    if (interfaceSound == true) {
      endSound("rotate");
    }
  }
  if ((y > 0.1 || y < -0.1) && abs(y) > abs(x)) {
    if (L2Pressed == true) {
      setScaleOnGrid(y);
    } else {
      setScale(y);
    }
  } else {
    if (interfaceSound == true) {
      endSound("scale");
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– HAT UP –––––––––––––––––––

void buttonUpRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Up");
  } else {
    if (powerMoveMode == true && moveMode == true && powerMove == "repetition") {
      setYRepetitionPlus();
    } else if (powerMoveMode == true && moveMode == true && powerMove == "animation") {
      setAnimationSpeedPlus();
    } else {
      if (R2Pressed == true) {
        if (powerMoveMode == false) {
          reorderItemForward();
        }
      } else if (L2Pressed == true) {
        setBackgroundColorToNext();
      } else {
        setItemColorToNext();
      }
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– HAT DOWN –––––––––––––––––

void buttonDownRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Down");
  } else {
    if (powerMoveMode == true && moveMode == true && powerMove == "repetition") {
      setYRepetitionMinus();
    } else if (powerMoveMode == true && moveMode == true && powerMove == "animation") {
      setAnimationSpeedMinus();
    } else {
      if (R2Pressed == true) {
        if (powerMoveMode == false) {
          reorderItemBackward();
        }
      } else if (L2Pressed == true) {
        setBackgroundColorToPrevious();
      } else {
        setItemColorToPrevious();
      }
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– HAT LEFT –––––––––––––––––

void buttonLeftRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Left");
  } else {
    if (powerMoveMode == true && moveMode == true && powerMove == "repetition") {
      setXRepetitionMinus();
    } else {
      if (R2Pressed == true) {
        if (powerMoveMode == false) {
          setPreviousAsActive();
        }
      } else {
        switch(activeItem.type) {
        case "font":
          if (L2Pressed == true) {
            deleteLetter();
          } else {
            switchLetterToPrevious();
          }
          break;
        case "image":
          break;
        case "vector":
          setStrokeWeightMinus();
          break;
        case "cam":
          break;
        }
      }
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– HAT RIGHT ––––––––––––––––

void buttonRightRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Right");
  } else {
    if (powerMoveMode == true && moveMode == true && powerMove == "repetition") {
      setXRepetitionPlus();
    } else {
      if (R2Pressed == true) {
        if (powerMoveMode == false) {
          setNextAsActive();
        }
      } else {
        switch(activeItem.type) {
        case "font":
          if (L2Pressed == true) {
            addLetter();
          } else {
            switchLetterToNext();
          }
          break;
        case "image":
          break;
        case "vector":
          setStrokeWeightPlus();
          break;
        case "cam":
          break;
        }
      }
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– TRIANGLE -––––––––––––––––

void buttonTriangleRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Triangle");
  } else {
    if (powerMoveMode == false) {
      println("triangle pressed");
      if (L2Pressed == true) {
        setupAllItemsRandom();
      } else {
        setupRandom();
      }
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SQUARE -––––––––––––––––––

void buttonSquareRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Square");
  } else if (powerMoveMode == true && moveMode == true) {
    deletePowerMove();
  } else {
    deleteItem();
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– CIRCLE -––––––––––––––––––

void buttonCircleRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Circle");
  } else {
    switchBlendMode();
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– CROSS –––-––––––––––––––––

void buttonCrossRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Cross");
  } else if (powerMoveMode == true && moveMode == true) {
    confirmPowerMove();
  } else {
    addItem();
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– L1 –––––––––––––––––––––––

void buttonL1Release() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("L1");
  } else {
    if (powerMoveMode == false) {
      switchGraphicFileToPrevious();
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– L2 –––––––––––––––––––––––

void buttonL2Release() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("L2");
  } else {
    setBackgroundColorToPrevious();
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– L3 Joystick -–––––––––––––

void buttonL3Release() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("L3");
  } else {
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– R1 –––––––––––––––––––––––

void buttonR1Release() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("R1");
  } else {
    if (powerMoveMode == false) {
      switchGraphicFileToNext();
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– R2 –––––––––––––––––––––––

void buttonR2Release() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("R2");
  } else {
    setBackgroundColorToNext();
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– R3 Joystick -–––––––––––––

void buttonR3Release() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("R3");
  } else {
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SHARE ––––––––––––––––––––

void buttonShareRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Share");
  } else {
    switch(activeItem.type) {
    case "font":
      setFontStyle();
      break;
    case "image":
      switchImageMode_AlphaOnOrOff();
      break;
    case "vector":
      switchVectorMode_FillOrStroke();
      break;
    case "cam":
      switchCamMode_LiveOrShot();
      break;
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– OPTIONS ––––––––––––––––––

void buttonOptionsRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Options");
  } else {
    if (L2Pressed == true) {
      switchBackgroundSound();
    } else {
      switchInterfaceSound();
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– TOUCHPAD –––––––––––––––––

void buttonTouchpadRelease() {
  if (powerMoveMode == true) {
    quitPowerMoveMode();
  } else {
    activatePowerMoveMode();
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– PS-BUTTON ––––––––––––––––

void buttonPSRelease() {
  if (powerMoveMode == true && comboMode == true) {
    addButtonToCombo("Ps");
  } else {
    if (L2Pressed == true) {
      reset();
    } else {
      export();
    }
  }
}
