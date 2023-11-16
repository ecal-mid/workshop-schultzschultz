
// !!! PLEASE DO NOT MODIFY THIS TAB !!! ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––– !!! PLEASE DO NOT MODIFY THIS TAB !!!

/*
  This tab contains essential configurations for the  gamepad interactivity.
 */


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– FIXED VARIABLES ––––––––––

ControlIO control;
Configuration config;
ControlDevice device;

ControlHat hat;
float hatX, hatY;

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SETUP ––––––––––––––––––––


void setupController() {
  if (gamepad == true) {
    control = ControlIO.getInstance(this);
    device = control.getMatchedDevice("controller/PS_Controller_Setup");

    hat = device.getHat("HAT");
    hat.plug(this, "hatRelease", ControlIO.ON_RELEASE);
    device.getButton("SH").plug(this, "buttonShareRelease", ControlIO.ON_RELEASE);
    device.getButton("OP").plug(this, "buttonOptionsRelease", ControlIO.ON_RELEASE);
    device.getButton("TP").plug(this, "buttonTouchpadRelease", ControlIO.ON_RELEASE);
    device.getButton("PS").plug(this, "buttonPSRelease", ControlIO.ON_RELEASE);
    device.getButton("TR").plug(this, "buttonTriangleRelease", ControlIO.ON_RELEASE);
    device.getButton("SQ").plug(this, "buttonSquareRelease", ControlIO.ON_RELEASE);
    device.getButton("CI").plug(this, "buttonCircleRelease", ControlIO.ON_RELEASE);
    device.getButton("CR").plug(this, "buttonCrossRelease", ControlIO.ON_RELEASE);
    device.getButton("L1").plug(this, "buttonL1Release", ControlIO.ON_RELEASE);
    device.getButton("L2").plug(this, "buttonL2Release", ControlIO.ON_RELEASE);
    device.getButton("L3").plug(this, "buttonL3Release", ControlIO.ON_RELEASE);
    device.getButton("R1").plug(this, "buttonR1Release", ControlIO.ON_RELEASE);
    device.getButton("R2").plug(this, "buttonR2Release", ControlIO.ON_RELEASE);
    device.getButton("R3").plug(this, "buttonR3Release", ControlIO.ON_RELEASE);
  }
}
// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– GET INPUT ––––––––––––––––


void getControllerInput() {
  if (gamepad == true) {
    getGamepadInput();
  }
  if (gamepadFallback == true) {
    getGamepadFallbackInput();
  }
  if (keyboardFallback == true) {
    getKeyboardFallbackInput();
  }
}

void getGamepadInput() {
  hatLeftPressed = hat.left();
  hatRightPressed = hat.right();
  hatUpPressed = hat.up();
  hatDownPressed = hat.down();
  hatX = hat.getX();
  hatY = hat.getY();
  crossPressed = device.getButton("CR").pressed();
  squarePressed = device.getButton("SQ").pressed();
  trianglePressed = device.getButton("TR").pressed();
  circlePressed = device.getButton("CI").pressed();
  sharePressed = device.getButton("SH").pressed();
  optionsPressed = device.getButton("OP").pressed();
  psPressed = device.getButton("PS").pressed();
  touchpadPressed = device.getButton("TP").pressed();
  L1Pressed = device.getButton("L1").pressed();
  L2Pressed = device.getButton("L2").pressed();
  L3Pressed = device.getButton("L3").pressed();
  R1Pressed = device.getButton("R1").pressed();
  R2Pressed = device.getButton("R2").pressed();
  R3Pressed = device.getButton("R3").pressed();
  LX = map(device.getSlider("LX").getValue(), -1, 1, -1.0, 1.0);
  LY = map(device.getSlider("LY").getValue(), -1, 1, -1.0, 1.0);
  RX = map(device.getSlider("RX").getValue(), -1, 1, -1.0, 1.0);
  RY = map(device.getSlider("RY").getValue(), -1, 1, -1.0, 1.0);

  joystickLeft(LX, LY);
  joystickRight(RX, RY);
}

void hatRelease(float x, float y) {
  if (hatUpPressed)    buttonUpRelease();
  if (hatDownPressed)  buttonDownRelease();
  if (hatLeftPressed)  buttonLeftRelease();
  if (hatRightPressed) buttonRightRelease();
}


void getGamepadFallbackInput() {
  joystickLeft(LX, LY);
  joystickRight(RX, RY);
}

void getKeyboardFallbackInput() {
  if (cPressed == false && wPressed == false && shiftPressed == false && aPressed == false && pPressed == false && lPressed == false && sPressed == false) {
    if (upPressed == true) {
      keyUp();
    }
    if (downPressed == true) {
      keyDown();
    }
    if (leftPressed == true) {
      keyLeft();
    }
    if (rightPressed == true) {
      keyRight();
    }
  }
}

void keyPressed() {

  if (gamepadFallback == true) {
    if (key == '4')               L3Pressed = true;
    if (key == 'h' || key == 'H') L2Pressed = true;
    if (key == 't' || key == 'T') L2Pressed = false;
    if (key == 'q' || key == 'Q') L1Pressed = true;
    if (key == '9')               R3Pressed = true;
    if (key == 'f' || key == 'F') R2Pressed = true;
    if (key == 'z' || key == 'Z') R2Pressed = false;
    if (key == 'd' || key == 'D') R1Pressed = true;
    if (key == 'g' || key == 'G') sharePressed = true;
    if (key == 'o' || key == 'O') optionsPressed = true;
    if (key == 'u' || key == 'U') touchpadPressed = true;
    if (key == 'p' || key == 'P') psPressed = true;
    if (key == 'y' || key == 'Y') trianglePressed = true;
    if (key == 'b' || key == 'B') circlePressed = true;
    if (key == 'a' || key == 'A') crossPressed = true;
    if (key == 'i' || key == 'I') squarePressed = true;
    if (key == 'j' || key == 'J') hatUpPressed = true;
    if (key == 'k' || key == 'K') hatDownPressed = true;
    if (key == 'v' || key == 'V') hatLeftPressed = true;
    if (key == 'n' || key == 'N') hatRightPressed = true;
    if (key == '0')               LYPlusPressed = true;
    if (key == '1')               LXPlusPressed = true;
    if (key == '2')               LYMinusPressed = true;
    if (key == '3')               LXMinusPressed = true;
    if (key == '5')               RYPlusPressed = true;
    if (key == '6')               RXPlusPressed = true;
    if (key == '7')               RYMinusPressed = true;
    if (key == '8')               RXMinusPressed = true;

    if (key == '0')               LY = -1;
    if (key == '1')               LX = 1;
    if (key == '2')               LY = 1;
    if (key == '3')               LX = -1;
    if (key == '5')               RY = -1;
    if (key == '6')               RX = 1;
    if (key == '7')               RY = 1;
    if (key == '8')               RX = -1;

    if (key == 't' || key == 'T') buttonL2Release();
    if (key == 'z' || key == 'Z') buttonR2Release();
  }

  if (keyboardFallback == true) {
    if (keyCode == TAB) tabPressed = true;
    if (keyCode == SHIFT) shiftPressed = true;
    if (keyCode == CONTROL) controlPressed = true;
    if (keyCode == ALT) altPressed = true;
    if (keyCode == UP) upPressed = true;
    if (keyCode == DOWN) downPressed = true;
    if (keyCode == LEFT) leftPressed = true;
    if (keyCode == RIGHT) rightPressed = true;
    if (key == 'c' || key == 'C') cPressed = true;
    if (key == 'w' || key == 'W') wPressed = true;
    if (key == 'a' || key == 'A') aPressed = true;
    if (key == 'p' || key == 'P') pPressed = true;
    if (key == 'l' || key == 'L') lPressed = true;
    if (key == 's' || key == 'S') sPressed = true;
  }
}


void keyReleased() {

  if (gamepadFallback == true) {
    if (key == '4')               L3Pressed = false;
    if (key == 'h' || key == 'H') L2Pressed = false;
    if (key == 't' || key == 'T') L2Pressed = true;
    if (key == 'q' || key == 'Q') L1Pressed = false;
    if (key == '9')               R3Pressed = false;
    if (key == 'f' || key == 'F') R2Pressed = false;
    if (key == 'z' || key == 'Z') R2Pressed = true;
    if (key == 'd' || key == 'D') R1Pressed = false;
    if (key == 'g' || key == 'G') sharePressed = false;
    if (key == 'o' || key == 'O') optionsPressed = false;
    if (key == 'u' || key == 'U') touchpadPressed = false;
    if (key == 'p' || key == 'P') psPressed = false;
    if (key == 'y' || key == 'Y') trianglePressed = false;
    if (key == 'b' || key == 'B') circlePressed = false;
    if (key == 'a' || key == 'A') crossPressed = false;
    if (key == 'i' || key == 'I') squarePressed = false;
    if (key == 'j' || key == 'J') hatUpPressed = true;
    if (key == 'k' || key == 'K') hatDownPressed = true;
    if (key == 'v' || key == 'V') hatLeftPressed = true;
    if (key == 'n' || key == 'N') hatRightPressed = true;
    if (key == '0')               LYPlusPressed = true;
    if (key == '1')               LXPlusPressed = true;
    if (key == '2')               LYMinusPressed = true;
    if (key == '3')               LXMinusPressed = true;
    if (key == '5')               RYPlusPressed = true;
    if (key == '6')               RXPlusPressed = true;
    if (key == '7')               RYMinusPressed = true;
    if (key == '8')               RXMinusPressed = true;



    
    if (key == '4')               buttonL3Release();
    if (key == 'h' || key == 'H') buttonL2Release();
    if (key == 'q' || key == 'Q') buttonL1Release();
    if (key == '9')               buttonR3Release();
    if (key == 'f' || key == 'F') buttonR2Release();
    if (key == 'd' || key == 'D') buttonR1Release();
    if (key == 'g' || key == 'G') buttonShareRelease();
    if (key == 'o' || key == 'O') buttonOptionsRelease();
    if (key == 'u' || key == 'U') buttonTouchpadRelease();
    if (key == 'p' || key == 'P') buttonPSRelease();
    if (key == 'y' || key == 'Y') buttonTriangleRelease();
    if (key == 'b' || key == 'B') buttonCircleRelease();
    if (key == 'a' || key == 'A') buttonCrossRelease();
    if (key == 'i' || key == 'I') buttonSquareRelease();
    if (key == 'j' || key == 'J') buttonUpRelease();
    if (key == 'k' || key == 'K') buttonDownRelease();
    if (key == 'v' || key == 'V') buttonLeftRelease();
    if (key == 'n' || key == 'N') buttonRightRelease();

    if (key == '0')               LY = 0;
    if (key == '1')               LX = 0;
    if (key == '2')               LY = 0;
    if (key == '3')               LX = 0;
    if (key == '5')               RY = 0;
    if (key == '6')               RX = 0;
    if (key == '7')               RY = 0;
    if (key == '8')               RX = 0;
  }


  if (keyboardFallback == true) {
    if (keyCode == TAB)            tabPressed = false;
    if (keyCode == SHIFT)          shiftPressed = false;
    if (keyCode == CONTROL)        controlPressed = false;
    if (keyCode == ALT)            altPressed = false;
    if (keyCode == UP)             upPressed = false;
    if (keyCode == DOWN)           downPressed = false;
    if (keyCode == LEFT)           leftPressed = false;
    if (keyCode == RIGHT)          rightPressed = false;
    if (key == 'c' || key == 'C')  cPressed = false;
    if (key == 'w' || key == 'W')  wPressed = false;
    if (key == 'a' || key == 'A')  aPressed = false;
    if (key == 'p' || key == 'P')  pPressed = false;
    if (key == 'l' || key == 'L')  lPressed = false;
    if (key == 's' || key == 'S')  sPressed = false;

    if (keyCode == TAB)            keyTab();
    if (keyCode == UP)             keyUp();
    if (keyCode == DOWN)           keyDown();
    if (keyCode == LEFT)           keyLeft();
    if (keyCode == RIGHT)          keyRight();
    if (keyCode == BACKSPACE)      keyBackspace();
    if (keyCode == ENTER)          keyEnter();
    if (key == 'r' || key == 'R')  keyR();
    if (key == 'x' || key == 'X')  keyX();
    if (key == 'm' || key == 'M')  keyM();
    if (key == 'e' || key == 'E')  keyE();
    if (key == 's' || key == 'S')  keyS();

    if (powerMoveMode == true && comboMode == true && comboKeys.contains(""+key) && gamepadFallback == false) {
      addButtonToCombo(""+key);
    }

    if (interfaceSound == true) {
      if (leftPressed == false && rightPressed == false) {
        endSound("rotate");
      }
      if (upPressed == false && downPressed == false) {
        endSound("scale");
      }
      if (leftPressed == false && rightPressed == false && upPressed == false && downPressed == false) {
        endSound("move");
      }
    }
  }

  keyCode = -1;
}
