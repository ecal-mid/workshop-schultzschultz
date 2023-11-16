
// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– LIBRARIES ––––––––––––––––

import processing.javafx.*;
import processing.video.*;
import java.util.Calendar;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import processing.sound.*;


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– EDITABLE VARIABLES –––––––

// Setup which controller setup you want to use to run the program.
boolean gamepad = true;
boolean gamepadFallback = false;
boolean keyboardFallback = false;

// Turn sound on or off
Boolean interfaceSound = true;
Boolean backgroundSound = true;

// Check the available cameras list in the console after program run to switch index
int cameraIndex = 0;


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SETUP ––––––––––––––––––––

void setup() {
  size(800, 800, FX2D);

  // Setup all inputs
  setupInterface();
  setupSound();
  setupController();
  folder = new File(dataPath("input/"));
  loadFiles();

  // Set all items anchor points to its center.
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);
  shapeMode(CENTER);

  // Add first item to work with
  addItem();
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– DRAW –––––––––––––––––––––

void draw() {

  // Check for new files in data folder
  checkFiles();

  background(bgColor);

  // get the input of gamepad and keyboard buttons and joysticks to control the graphic items
  getControllerInput();

  // update power move functionality if mode is active
  if (powerMoveMode) {
    updatePowerMoveMode();
  }

  // display all items
  for (int i = 0; i < myItems.size(); i++) {
    myItems.get(i).update();
    myItems.get(i).display();
    blendMode(BLEND);
  }

  // display power move interface if active
  if (powerMoveMode) {
    displayPowerMoveMode();
  }

  // set the activity alpha value for inactive items based on the last activity
  setActivityAlpha();
}
