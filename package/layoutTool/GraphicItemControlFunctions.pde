
// ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

/*
 This tab stores all the essential functions related to interacting with the graphic items.
 FEEL FREE TO MODIFY THE CODE to experiment with the functions and variables.
 */


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– MOVE –––––––––––––––––––––

// MODIFIED VARIABLES
// PVector  activeItem.position

// EDITABLE VARIABLES
float margin = -5;
float moveSpeed = 10;
int  horizontalGridSize = 50;
int  verticalGridSize = 50;

void move(float xInput, float yInput) {

  // map input values to get the x/yDirection
  float xDirection = map(xInput, -1.0, 1.0, -moveSpeed, moveSpeed);
  float yDirection = map(yInput, -1.0, 1.0, -moveSpeed, moveSpeed);

  // add x/yDirection to current position
  activeItem.position.x = activeItem.position.x + xDirection;
  activeItem.position.y = activeItem.position.y + yDirection;

  // constrain position to frame margin
  activeItem.position.x = constrain(activeItem.position.x, margin, width-margin);
  activeItem.position.y = constrain(activeItem.position.y, margin, height-margin);

  // play sound of this function
  if (interfaceSound == true) {
    playSound("move", activeItem.position.y);
  }
}

void moveOnGrid(float xInput, float yInput) {

  // map input values and add it to the inputx/yDirection (sum of previous move inputs)
  xInputDirection += map(xInput, -1.0, 1.0, -horizontalGridSize/gridSpeed, horizontalGridSize/gridSpeed);
  yInputDirection += map(yInput, -1.0, 1.0, -verticalGridSize/gridSpeed, verticalGridSize/gridSpeed);

  // check if inputXDirection is beyond the horizontalGridSize
  if (abs(xInputDirection) > horizontalGridSize) {

    // if true add/subtract horizontalGridSize to current position
    if (xInputDirection > horizontalGridSize) {
      activeItem.position.x = activeItem.position.x + horizontalGridSize;
    } else if (xInputDirection < -horizontalGridSize) {
      activeItem.position.x = activeItem.position.x - horizontalGridSize;
    }

    // constrain position to frame margin
    activeItem.position.x = constrain(activeItem.position.x, margin, width-margin);

    // gridify position to horizontalGridSize
    activeItem.position.x = round(activeItem.position.x/horizontalGridSize)*horizontalGridSize;

    //reset inputXDirection
    xInputDirection = 0;
  }

  // check if inputYDirection is beyond the verticalGridSize
  if (abs(yInputDirection) > verticalGridSize) {

    // if true add/subtract verticalGridSize to current position
    if (yInputDirection > verticalGridSize) {
      activeItem.position.y = activeItem.position.y + verticalGridSize;
    } else if (yInputDirection < -verticalGridSize) {
      activeItem.position.y = activeItem.position.y - verticalGridSize;
    }

    // constrain position to frame margin
    activeItem.position.y = constrain(activeItem.position.y, margin, height-margin);

    // gridify position to verticalGridSize
    activeItem.position.y = round(activeItem.position.y / verticalGridSize) * verticalGridSize;

    //reset inputYDirection
    yInputDirection = 0;
  }

  // play sound of this function
  if (interfaceSound == true) {
    playSound("move", activeItem.position.y);
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SCALE ––––––––––––––––––––

// MODIFIED VARIABLES
// Float  activeItem.scale

// EDITABLE VARIABLES
float scaleMin = 0.25;
float scaleMax = 10.0;
float scaleSpeed = 0.1;
float scaleGridSize = 1.0;

void setScale(float sInput) {

  // map input values to get the scaleInputDirection
  float sDirection = map(sInput, -1.0, 1.0, scaleSpeed, -scaleSpeed);

  // add scaleInputDirection to current scale
  activeItem.scale = activeItem.scale + sDirection;

  // constrain scale to minimum and maximum values
  activeItem.scale = constrain(activeItem.scale, scaleMin, scaleMax);

  if (interfaceSound == true) {
    playSound("scale", activeItem.scale);
  }
}

void setScaleOnGrid(float sInput) {

  // map input values and add it to the scaleInputDirection (sum of previous scale inputs)
  sInputDirection += map(sInput, -1.0, 1.0, scaleGridSize/gridSpeed, -scaleGridSize/gridSpeed);

  // check if scaleInputDirection direction is beyond the scaleGridSize
  if (abs(sInputDirection) > scaleGridSize) {

    // if true add/subtract scaleGridSize to current scale
    if (sInputDirection > scaleGridSize) {
      activeItem.scale = activeItem.scale + scaleGridSize;
    } else if (sInputDirection < -scaleGridSize) {
      activeItem.scale = activeItem.scale - scaleGridSize;
    }

    // constrain scale to minimum and maximum values
    activeItem.scale = constrain(activeItem.scale, scaleMin, scaleMax);

    // gridify scale to scaleGridSize
    activeItem.scale = round(activeItem.scale / scaleGridSize) * scaleGridSize;

    //reset scaleInputDirection
    sInputDirection = 0;
  }

  // play sound of this function
  if (interfaceSound == true) {
    playSound("scale", activeItem.scale);
  }
}



// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– ROTATION –––––––––––––––––

// MODIFIED VARIABLES
// Float  activeItem.rotation

// EDITABLE VARIABLES
float rotationMin = 0;
float rotationMax = 360;
float rotationSpeed = 2;
float rotationGridSize = 45;

void setRotation(float rInput) {

  // map input values to get the rotationDirection
  float rDirection = map(rInput, -1.0, 1.0, -rotationSpeed, rotationSpeed);

  // add rotationDirection to current rotation
  activeItem.rotation = activeItem.rotation + rDirection;

  // constrain rotation to circle constant
  activeItem.rotation = activeItem.rotation%360;

  // play sound of this function
  if (interfaceSound == true) {
    playSound("rotate", activeItem.rotation);
  }
}

void setRotationOnGrid(float rInput) {

  // map input value and add it to rotationInputDirection (sum of previous rotation inputs)
  rInputDirection += map(rInput, -1.0, 1.0, -rotationGridSize/gridSpeed, rotationGridSize/gridSpeed);

  // check if rotationInputDirection direction is beyond the rotationGridSize
  if (abs(rInputDirection) > rotationGridSize) {

    // if true add/subtract rotationGridSize to current rotation
    if (rInputDirection > rotationGridSize) {
      activeItem.rotation = activeItem.rotation + rotationGridSize;
    } else if (rInputDirection < -rotationGridSize) {
      activeItem.rotation = activeItem.rotation - rotationGridSize;
    }

    // constrain rotation to circle constant
    activeItem.rotation = activeItem.rotation%360;

    // gridify rotation to rotationGridSize
    activeItem.rotation = round(activeItem.rotation / rotationGridSize) * rotationGridSize;

    //reset rotationInputDirection
    rInputDirection = 0;
  }

  // play sound of this function
  if (interfaceSound == true) {
    playSound("rotate", activeItem.rotation);
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– LETTER –––––––––––––––––––

// MODIFIED VARIABLES
// String  activeItem.text             :  combining all previously added characters
// Int     activeItem.activeCharIndex  :  index of active char in characterSet
// Int     activeItem.fontFamilyIndex  :  index of fontstyle in fontFamily

// EDITABLE VARIABLES
// Set of characters that will be skipped through to set text
String [] characterSet = {"A", "a", "B", "b", "C", "c", "D", "d", "E", "e", "F", "f", "G", "g", "H", "h", "I", "i", "J", "j", "K", "k", "L", "l", "M", "m",
  "N", "n", "O", "o", "P", "p", "Q", "q", "R", "r", "S", "s", "T", "t", "U", "u", "V", "v", "W", "w", "X", "x", "Y", "y", "Z", "z", ".", ",", "?", "!"};
//String [] characterSet = {"A", "a", "B", "b", "C", "c", "D", "d", "E", "e", "F", "f", "G", "g", "H", "h", "I", "i", "J", "j", "K", "k", "L", "l", "M", "m",
//  "N", "n", "O", "o", "P", "p", "Q", "q", "R", "r", "S", "s", "T", "t", "U", "u", "V", "v", "W", "w", "X", "x", "Y", "y", "Z", "z"}
//  String [] characterSet = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
//  "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", ",", "?", "!"};

void switchLetterToNext() {

  // trim text by its last entry
  activeItem.text = activeItem.text.substring(0, activeItem.text.length()-characterSet[activeItem.activeCharIndex].length());

  // increase activeCharIndex by one
  activeItem.activeCharIndex++;

  // if activeCharIndex exeeds total amount of characters in characterSet, then switch to the remainder
  activeItem.activeCharIndex = activeItem.activeCharIndex%characterSet.length;

  //  add the letter of activeCharIndex in characterSet to text
  activeItem.text = activeItem.text + characterSet[activeItem.activeCharIndex];

  // play sound of this function
  if (interfaceSound == true) {
    playSound("switch letter");
  }
}

void switchLetterToPrevious() {

  // trim text by its last entry
  activeItem.text = activeItem.text.substring(0, activeItem.text.length()-characterSet[activeItem.activeCharIndex].length());

  // decrease activeCharIndex by one
  activeItem.activeCharIndex--;

  // if activeCharIndex goes below 0 then switch to the last index of characterSet
  if (activeItem.activeCharIndex < 0) {
    activeItem.activeCharIndex = characterSet.length-1;
  }

  // add the letter of activeCharIndex in characterSet to text
  activeItem.text = activeItem.text + characterSet[activeItem.activeCharIndex];

  // play sound of this function
  if (interfaceSound == true) {
    playSound("switch letter");
  }
}

void addLetter() {

  // add the letter of activeCharIndex in characterSet to text
  activeItem.text = activeItem.text + characterSet[activeItem.activeCharIndex];

  // play sound of this function
  if (interfaceSound == true) {
    playSound("add letter");
  }
}

void deleteLetter() {

  // only delete letters if  text length is more than one letter after deleting
  if (activeItem.text.length() > characterSet[activeItem.activeCharIndex].length()) {

    // trim text by its last letter
  activeItem.text = activeItem.text.substring(0, activeItem.text.length()-characterSet[activeItem.activeCharIndex].length());

    // update activeCharIndex
    for (int i = 0; i < characterSet.length; i++) {
      if ((""+characterSet[i]).equals((""+activeItem.text.charAt(activeItem.text.length()-1))) == true) {
        activeItem.activeCharIndex = i;
        break;
      }
    }

    // play sound of this function
    if (interfaceSound == true) {
      playSound("delete letter");
    }
  }
}

void setFontStyle() {

  // only switch font style if fontFamily has more than one entry
  if (activeItem.fontFamily.length > 1) {

    // increase fontFamilyIndex by one
    activeItem.fontFamilyIndex++;

    // if fontFamilyIndex exeeds the entry amount of fontFamily, step back to zero
    if (activeItem.fontFamilyIndex >= activeItem.fontFamily.length) {
      activeItem.fontFamilyIndex = 0;
    }

    // play sound of this function
    if (interfaceSound == true) {
      playSound("switch mode");
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– CAMERA –––––––––––––––––––

// MODIFIED VARIABLES
// boolean  activeItem.camModeLive   :  live or camera shot
// PImage   activeItem.img           :  pictured image
// boolean  activeItem.defaultColor  :  image in default color or duplex color
// PImage[] activeItem.imgDuplex     :  array of duplex images for every entry in 'myColors'
// Color[]  myColors                 :  array of imported colors

void switchCamMode_LiveOrShot() {

  activeItem.camModeLive = !activeItem.camModeLive;

  if (activeItem.camModeLive == false) {

    // set item color to default color if its the first shot, else save the previous set color
    if (activeItem.img == null) {
      activeItem.defaultColor = true;
    }

    // copy image from camera stream
    activeItem.imgDefault = activeItem.cam.copy();

    // generate duplex images for all colors
    for (int i = 0; i < myColors.length; i++) {
      activeItem.imgDuplex[i] = activeItem.createColorImage(activeItem.imgDefault, myColors[i], false);
    }

    // update the active image
    activeItem.updateImg();
  }

  // play sound of this function
  if (interfaceSound == true) {
    playSound("switch mode");
  }
}

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– IMAGE ––––––––––––––––––––

// MODIFIED VARIABLES
// boolean  activeItem.imageModeAlpha  :  alpha on or off
// boolean  activeItem.defaultColor    :  image in default color or duplex color

void switchImageMode_AlphaOnOrOff() {

  // only change alpha mode if defaultColor is off
  if (activeItem.defaultColor == false) {

    // switch imageModeAlpha
    activeItem.imageModeAlpha = !activeItem.imageModeAlpha;

    // update the active image
    activeItem.updateImg();

    // play sound of this function
    if (interfaceSound == true) {
      playSound("switch mode");
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– VECTOR –––––––––-–––––––––

// MODIFIED VARIABLES
// Boolean  vectorModeStroke         :  stroke or fill
// Float    activeItem.strokeWeight  :  thicknesss of stroke

// EDITABLE VARIABLES
float strokeWeightDefault = 250;
float strokeWeightMin = 100;
float strokeWeightMax = 1000;
float strokeWeightIncrement = 150;

void switchVectorMode_FillOrStroke() {

  // switch vectorModeStroke
  activeItem.vectorModeStroke = !activeItem.vectorModeStroke;

  // play sound of this function
  if (interfaceSound == true) {
    playSound("switch mode");
  }
}

void setStrokeWeightPlus() {

  // only change strokeWeight if vectorModeStroke is active
  if (activeItem.vectorModeStroke == true) {

    // only increase strokeWeight if strokeWeight is below strokeWeightMax value
    if (activeItem.strokeWeight < strokeWeightMax) {

      // add strokeWeightIncrement to strokeWeight
      activeItem.strokeWeight = activeItem.strokeWeight + strokeWeightIncrement;

      // constrain strokeWeight to minimum and maximum values
      activeItem.strokeWeight = constrain(activeItem.strokeWeight, strokeWeightMin, strokeWeightMax);

      // play sound of this function
      if (interfaceSound == true) {
        playSound("strokeweight");
      }
    } else {

      // play sound of this function
      if (interfaceSound == true) {
        playSound("strokeweight max");
      }
    }
  }
}

void setStrokeWeightMinus() {

  // only change strokeWeight if vectorModeStroke is active
  if (activeItem.vectorModeStroke == true) {

    // only increase strokeWeight if strokeWeight is above strokeWeightMin value
    if (activeItem.strokeWeight > strokeWeightMin) {

      // subtract strokeWeightIncrement to strokeWeight
      activeItem.strokeWeight = activeItem.strokeWeight - strokeWeightIncrement;

      // constrain strokeWeight to minimum and maximum values
      activeItem.strokeWeight = constrain(activeItem.strokeWeight, strokeWeightMin, strokeWeightMax);

      // play sound of this function
      if (interfaceSound == true) {
        playSound("strokeweight");
      }
    } else {

      // play sound of this function
      if (interfaceSound == true) {
        playSound("strokeweight max");
      }
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– COLOR -–––––––––-–––––––––

// MODIFIED VARIABLES
// Color   activeItem.col       :  active color
// Int     activeItem.colIndex  :  index of active color in myColors
// Color   bgColor              :  background color
// Int     bgColorIndex         :  index of bgColor in myColors
// String  activeItem.type      :  type of item ( image, vector, font or cam)

// EDITABLE VARIABLES
color [] myColors = {#000000, #FF0000, #FFFF00, #00FF00, #00FFFF, #0000FF, #FF00FF, #FFFFFF}; // preset if no image is found to import colors
/*
 You can use an image as source to load a range of colors to use it myColors array.
 The source image must be placed in the data folder 'data/input/colors' and is imported and analysed at setup.
 If you want to add your colors manually just delete the 'colors.png' and add you colors as HEX-code to the follwing array 'myColors'.
 */
int maxImportColors = 10; // amount of colors that are imported from source image.

void setItemColorToNext() {

  // differing handling for image/cam types to other types
  if (activeItem.type == "image" || activeItem.type == "cam") {

    // if defaultColor is true then deactivate, else increase colIndex by one
    if (activeItem.defaultColor) {
      activeItem.defaultColor = false;
    } else {
      activeItem.colIndex++;
    }

    // if colIndex exeeds total amount of colors in myColors, then jump back to zero and set defaultColor to true
    if (activeItem.colIndex >= myColors.length) {
      activeItem.colIndex = 0;
      activeItem.defaultColor = true;
    }

    // update the active image
    activeItem.updateImg();
  } else {

    // increase colIndex by one
    activeItem.colIndex++;

    // if colIndex exeeds total amount of colors in myColors, then switch to the remainder
    activeItem.colIndex = activeItem.colIndex%myColors.length;
  }

  // update the active color to colIndex in myColors
  activeItem.col = myColors[activeItem.colIndex];

  // play sound of this function
  if (interfaceSound == true) {
    playSound("color");
  }
}

void setItemColorToPrevious() {

  // decrease colIndex by one
  activeItem.colIndex--;

  // check if colIndex goes below zero
  if (activeItem.colIndex < 0) {

    // differing handling for image/cam types to other types
    if (activeItem.type == "image" || activeItem.type == "cam") {

      // check if defaultColor is already active
      if (!activeItem.defaultColor) {

        // else switch defaultColor on and set colIndex back to zero
        activeItem.defaultColor = true;
        activeItem.colIndex = 0;
      } else {

        // else switch defaultColor off and jump colIndex to entry amount of myColors (minus one because index count starts at 0)
        activeItem.defaultColor = false;
        activeItem.colIndex = myColors.length-1;
      }
    } else {

      // jump colIndex to entry amount of myColors (minus one because index count starts at 0)
      activeItem.colIndex = myColors.length-1;
    }
  }

  // update the active color to colIndex in myColors
  activeItem.col = myColors[activeItem.colIndex];

  // update the active image
  if (activeItem.type == "image" || activeItem.type == "cam") {
    activeItem.updateImg();
  }

  // play sound of this function
  if (interfaceSound == true) {
    playSound("color");
  }
}

void setBackgroundColorToNext() {

  // increase bgColIndex by one
  bgColorIndex++;

  // if bgColIndex exeeds total amount of colors in myColors, then jump back to zero
  if (bgColorIndex >= myColors.length) {
    bgColorIndex = 0;
  }

  // update the bgColor to bgColIndex in myColors
  bgColor = myColors[bgColorIndex];


  // play sound of this function
  if (interfaceSound == true) {
    playSound("background color");
  }
}

void setBackgroundColorToPrevious() {

  // decrease bgColIndex by one
  bgColorIndex--;

  // if bgColIndex goes below zero jump bgColorIndex to entry amount of myColors (minus one because index count starts at 0)
  if (bgColorIndex < 0) {
    bgColorIndex = myColors.length-1;
  }

  // update the bgColor to bgColIndex in myColors
  bgColor = myColors[bgColorIndex];


  // play sound of this function
  if (interfaceSound == true) {
    playSound("background color");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– BLEND MODE ––-––––––––––––

// MODIFIED VARIABLES
// activeItem.blendMode       :  blendMode as integer
// activeItem.blendModeIndex  :  index of blendMode in blendModes

// EDITABLE VARIABLES
int [] blendModes = {BLEND, MULTIPLY, DIFFERENCE};

void switchBlendMode() {

  // increase blendModeIndex by one
  activeItem.blendModeIndex++;

  // if blendModeIndex exeeds total amount of blendModes, then jump back to zero
  if (activeItem.blendModeIndex >= blendModes.length) {
    activeItem.blendModeIndex = 0;
  }

  // update blendMode to blendModeIndex in blendModes
  activeItem.blendMode = blendModes[activeItem.blendModeIndex];

  // play sound of this function
  if (interfaceSound == true) {
    playSound("switch mode");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– RANDOM -––––––––-–––––––––

// MODIFIED VARIABLES
// Bool   activeItem.randomSet  :  activate to trigger setupRandom() in next loop
// Color  bgColor               :  background color
// Int    bgColorIndex          :  index of bgColor in myColors
// String  activeItem.type      :  type of item ( image, vector, font or cam)

void setupRandom() {

  // activate randomSet for next loop
  activeItem.randomSet = true;

  // play sound of this function
  if (interfaceSound == true) {
    playSound("random");
  }
}


void setupAllItemsRandom() {

  // get random value for bgColorIndex and update bgColor to bgColorIndex in myColors
  bgColorIndex = floor(random(myColors.length));
  bgColor = myColors[bgColorIndex];

  // activate randomSet for next loop for all items
  for (int i = 0; i < myItems.size(); i++) {
    myItems.get(i).randomSet = true;
  }

  // play sound of this function
  if (interfaceSound == true) {
    playSound("all random");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

void randomReset(GraphicItem item) {

  // activate or deactivate which variables should be set by random
  randomResetPosition(item);
  randomResetScale(item);
  randomResetRotation(item);
  randomResetColor(item);
  randomResetBlendMode(item);

  if (item.type == "image") {
    randomResetImage(item);
  } else if (item.type == "vector") {
    randomResetVector(item);
  } else if (item.type == "font") {
    randomResetFont(item);
  } else if (item.type == "cam") {
    randomResetCam(item);
  }

  if (item.animation == true) {
    randomResetAnimation(item);
  }

  if (item.repetition == true) {
    randomResetRepetition(item);
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// PVector  item.position

// EDITABLE VARIABLES
float randomMargin = margin;
float randomHorizontalGridSize = horizontalGridSize;
float randomVerticalGridSize = verticalGridSize;

void randomResetPosition(GraphicItem item) {

  // generate random value
  float randomX = random(randomMargin, width-randomMargin);
  float randomY = random(randomMargin, height-randomMargin);

  // grifify random value
  // randomX = round(randomX / randomHorizontalGridSize) * randomHorizontalGridSize;
  // randomY = round(randomY / randomVerticalGridSize) * randomVerticalGridSize;

  // set position to random value
  item.position.x = randomX;
  item.position.y = randomY;
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// Float  item.scale

// EDITABLE VARIABLES
float randomScaleMin = scaleMin;
float randomScaleMax = scaleMax;
float randomScaleGridSize = scaleGridSize;

void randomResetScale(GraphicItem item) {

  // generate random values for scale
  float randomScale = random(randomScaleMin, randomScaleMax);
  // float randomScale = item.scale * random(0.8, 1.2);

  // grifify random value
  // randomScale = round(randomScale / randomScaleGridSize) * randomScaleGridSize;

  // set scale to random value
  item.scale = randomScale;
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// Float  item.rotation

// EDITABLE VARIABLES
float randomRotationMin = 0;
float randomRotationMax = 360;
float randomRotationGridSize = rotationGridSize;

void randomResetRotation(GraphicItem item) {

  // generate random value
  float randomRotation = random(randomRotationMin, randomRotationMax);

  //rotate by either positive or negative rotationGridSize
  //float randomDirection = 0;
  //if (boolean(floor(random(2))) == true) {
  //  randomDirection = 1;
  //}  else {
  //  randomDirection = -1
  //}
  //float randomRotation = item.rotation + randomRotationGridSize * randomDirection;

  // grifify random value
  // randomRotation = round(randomRotation / randomRotationGridSize) * randomRotationGridSize;

  // set rotation to random value
  item.rotation = randomRotation;
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// Color     item.col       :  active color
// Int       item.colIndex  :  index of active color in myColors
// Color []  myColors       :  set of colors imported at setup

void randomResetColor(GraphicItem item) {

  // generate random colIndex value
  item.colIndex = floor(random(myColors.length));

  // update color to colIndex in myColors
  item.col = myColors[item.colIndex];
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// Int []  blendModes   :  set of blendModes
// item.blendMode       :  blendMode as integer
// item.blendModeIndex  :  index of blendMode in blendModes

void randomResetBlendMode(GraphicItem item) {

  // generate random index value
  int randomIndex = floor(random(blendModes.length));

  // update blendModeIndex and set blend mode to randomIndex in blendModes
  item.blendModeIndex = randomIndex;
  item.blendMode = blendModes[item.blendModeIndex];
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// boolean  item.imageModeAlpha  :  alpha on or off
// boolean  item.defaultColor    :  image in default color or duplex color

void randomResetImage(GraphicItem item) {

  // generate random toggle (chance 1 : myColors entries)
  boolean randomToggle = boolean(floor(random(myColors.length)));

  // randomToggle value sets if item is in defaultColor
  if (randomToggle == true) {
    item.defaultColor = true;
  } else {
    item.defaultColor = false;

    // random toggle if duplex image has alpha
    item.imageModeAlpha = boolean(floor(random(2)));
  }

  // update the active image
  item.updateImg();
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// Boolean  vectorModeStroke   :  stroke or fill
// Float    item.strokeWeight  :  thicknesss of stroke

// EDITABLE VARIABLES
float randomStrokeWeightMin = strokeWeightMin;
float randomStrokeWeightMax = strokeWeightMax;
float randomStrokeWeightIncrement = strokeWeightIncrement;

void randomResetVector(GraphicItem item) {

  // random toggle if vector mode is stroke (or fill)
  item.vectorModeStroke = boolean(floor(random(2)));

  // generate random value
  if (item.vectorModeStroke == true) {
    float randomStrokeWeight = random(randomStrokeWeightMin, randomStrokeWeightMax);

    //increment/decrement by randomStrokeWeightIncrement
    //float randomDirection = 0;
    //if (boolean(floor(random(2))) == true) {
    //  randomDirection = 1;
    //}  else {
    //  randomDirection = -1
    //}
    //float randomStrokeWeight = item.strokeWeight + randomStrokeWeightIncrement * randomDirection;

    // set strokeWeight to random value
    item.strokeWeight = randomStrokeWeight;
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// Int  item.fontFamilyIndex  :  index of fontstyle in fontFamily

void randomResetFont(GraphicItem item) {

  // generate random fontFamilyIndex value
  item.fontFamilyIndex = floor(random(item.fontFamily.length));
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// boolean  item.camModeLive   :  live or camera shot
// boolean  item.defaultColor  :  image in default color or duplex color
// PImage[] item.imgDuplex     :  array of duplex images for every entry in 'myColors'
// Color[]  myColors           :  array of imported colors

void randomResetCam(GraphicItem item) {

  // random toggle if camModeLive is live or shot
  item.camModeLive = boolean(floor(random(2)));

  // if camModeLive is false then update the current image as
  if (item.camModeLive == false) {

    // generate random toggle (chance 1 : myColors entries)
    boolean randomToggle = boolean(floor(random(myColors.length)));

    // randomToggle value sets if item is in defaultColor or duplex
    if (randomToggle == true) {
      item.defaultColor = true;
    } else {
      item.defaultColor = false;
    }

    // copy image from camera stream
    item.imgDefault = item.cam.copy();

    // generate duplex images for all colors
    for (int i = 0; i < myColors.length; i++) {
      item.imgDuplex[i] = item.createColorImage(item.imgDefault, myColors[i], false);
    }

    // update the active image
    item.updateImg();
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––


// MODIFIED VARIABLES
// Float  item.animationTransPos  :  transfer position (animating between item.position and item.animationTransPos)
// Float  item.animationTransRot  :  transfer rotation (animating between item.rotation and item.animationTransRot)
// Float  item.animationTransSca  :  transfer scale (animating between item.scale and item.animationTransSca)

// EDITABLE VARIABLES
float randomMaxDecrement = 0.8;
float randomMaxIncrement = 1.2;

void randomResetAnimation(GraphicItem item) {

  // multiply animation values by random
  item.animationTransXPos = item.animationTransXPos * random(randomMaxDecrement, randomMaxIncrement);
  item.animationTransYPos = item.animationTransYPos * random(randomMaxDecrement, randomMaxIncrement);
  item.animationTransRot =  item.animationTransRot * random(randomMaxDecrement, randomMaxIncrement);
  item.animationTransSca =  item.animationTransSca * random(randomMaxDecrement, randomMaxIncrement);
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––

// MODIFIED VARIABLES
// PVector  item.repetitionDirection  :  transfer direction (sets distance between repetitions)
// PVector  item.repetitions          :  count of x/y repetitions

// EDITABLE VARIABLES
float randomMaxNegativeShift;
float randomMaxPositiveShift;
float randomMaxRepetitions = 5;

void randomResetRepetition(GraphicItem item) {

  randomMaxNegativeShift = item.size * 0.5;
  randomMaxPositiveShift = item.size * 2;

  // generate random values
  float randomXDirection = floor(random(randomMaxNegativeShift, randomMaxPositiveShift));
  float randomYDirection = floor(random(randomMaxNegativeShift, randomMaxPositiveShift));
  float randomXRepetitions = floor(random(1, randomMaxRepetitions));
  float randomYRepetitions = floor(random(1, randomMaxRepetitions));

  // grifify random value
  // randomXDirection = round(randomXDirection / horizontalGridSize) * horizontalGridSize;
  // randomYDirection = round(randomYDirection / verticalGridSize) * verticalGridSize;

  // set repetitionDirection and repetitions to random value
  item.repetitionDirection.set(randomXDirection, randomYDirection);
  item.repetitions.set(randomXRepetitions, randomYRepetitions);
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– POWER MOVE –––––––––––––––

// Check the previously pressed button combo for a match.
// For a valid combo it returns the specific power move or nothing if invalid.
String checkCombo(String combo) {
  switch(combo) {
  case "SquareCrossCircle":
  case "1QA":
    comboValid = true;
    return "drawing";
  case "TriangleCircleCross":
  case "4R5":
    comboValid = true;
    return "animation";
  case "CircleSquareUp":
  case "7UK":
    comboValid = true;
    return "repetition";
  case "NewButtonCombo":      // Gamepad Combo
  case "NBC":                 // Keyboard Combo (3 keys)
    comboValid = true;
    return "new power move";  // power move name for functions below
  default:
    comboValid = false;
    return "";
  }
}


// Trigger the power move function depending on which power move is activated.
void updatePowerMove() {
  switch(powerMove) {
  case "drawing":
    drawWithItem();
    break;
  case "animation":
    animateItem();
    break;
  case "repetition":
    repeatItem();
    break;
  case "new power move":
    // add function here
    break;
  }
}


// Delete the settings depending on which power move is activated.
void deletePowerMove() {
  switch(powerMove) {
  case "drawing":
    deleteItemDrawing();
    break;
  case "animation":
    deleteItemAnimation();
    break;
  case "repetition":
    deleteItemRepetition();
    break;
  case "new power move":
    // add function here
    break;
  }
  quitPowerMoveMode();

  // play sound of this function
  if (interfaceSound == true) {
    playSound("delete power move");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– POWER MOVE: DRAWING ––––––

void drawWithItem() {

  // update item drawing with current settings
  activeItem.updateDrawing();

  // play sound of this function
  if (powerMoveMode) {
  }
}

void deleteItemDrawing() {

  // activate drawingDelete function for next loop
  activeItem.drawingDelete = true;

  // play sound of this function
  if (interfaceSound == true) {
    playSound("delete drawing");
  }
}

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– POWER MOVE: REPETITION –––


// MODIFIED VARIABLES
// PVector  item.repetitionDirection  :  transfer direction (sets distance between repetitions)
// PVector  item.repetitions          :  count of x/y repetitions

// EDITABLE VARIABLES
int maxRepetitions = 5;

void repeatItem() {

  // update item repetition settings
  activeItem.updateRepetition();
}

void deleteItemRepetition() {

  // deactivate repetition
  activeItem.repetition = false;

  // play sound of this function
  if (interfaceSound == true) {
    playSound("delete repetition");
  }
}

void setXRepetitionPlus() {

  // only increase repetition if current value is below maxValue
  if (activeItem.repetitions.x < maxRepetitions) {

    // increment value by one
    activeItem.repetitions.set(activeItem.repetitions.x+1, activeItem.repetitions.y);

    // play sound of this function
    if (interfaceSound == true) {
      playSound("repetition");
    }
  } else {

    // play sound of this function
    if (interfaceSound == true) {
      playSound("repetition max");
    }
  }
}

void setXRepetitionMinus() {

  // only decrease repetition if current value is above one
  if (activeItem.repetitions.x > 1) {

    // decrement value by one
    activeItem.repetitions.set(activeItem.repetitions.x-1, activeItem.repetitions.y);

    // play sound of this function
    if (interfaceSound == true) {
      playSound("repetition");
    }
  } else {

    // play sound of this function
    if (interfaceSound == true) {
      playSound("repetition max");
    }
  }
}

void setYRepetitionPlus() {

  // only increase repetition if current value is below maxValue
  if (activeItem.repetitions.y < maxRepetitions) {

    // increment value by one
    activeItem.repetitions.set(activeItem.repetitions.x, activeItem.repetitions.y+1);

    // play sound of this function
    if (interfaceSound == true) {
      playSound("repetition");
    }
  } else {

    // play sound of this function
    if (interfaceSound == true) {
      playSound("repetition max");
    }
  }
}

void setYRepetitionMinus() {

  // only decrease repetition if current value is above one
  if (activeItem.repetitions.y > 1) {

    // decrement value by one
    activeItem.repetitions.set(activeItem.repetitions.x, activeItem.repetitions.y-1);

    // play sound of this function
    if (interfaceSound == true) {
      playSound("repetition");
    }
  } else {

    // play sound of this function
    if (interfaceSound == true) {
      playSound("repetition max");
    }
  }
}

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– POWER MOVE: ANIMATION -–––

// MODIFIED VARIABLES
// Float  item.animationPos  :  current position (animating between item.position and item.animationTransPos)
// Float  item.animationRot  :  current rotation (animating between item.rotation and item.animationTransRot)
// Float  item.animationSca  :  current scale (animating between item.scale and item.animationTransSca)
// Float  item.animationTransPos  :  transfer position
// Float  item.animationTransRot  :  transfer rotation
// Float  item.animationTransSca  :  transfer scale

// EDITABLE VARIABLES
float animationSpeedDefault = 30; //fps
float animationSpeedMax = 7.5;
float animationSpeedMin = 120;
float animationSpeedIncrement = 2.0;
float animationNoise = 0;

void animateItem() {

  // update item animation settings
  activeItem.updateAnimation();
}


float[] updateAnimationValues(GraphicItem item) {

  // update values based on speed and animation settings

  // sine animation (wavy)
  float animationXPos = sin(frameCount / item.animationSpeed)*(item.animationTransXPos);
  float animationYPos = sin(frameCount / item.animationSpeed)*(item.animationTransYPos);
  float animationRot = sin(frameCount / item.animationSpeed)*(item.animationTransRot);
  float animationSca = sin(frameCount / item.animationSpeed)*(item.animationTransSca);

  // circular animation (wavy)
  //float animationXPos = cos(frameCount / item.animationSpeed)*(item.animationTransXPos);
  //float animationYPos = sin(frameCount / item.animationSpeed)*(item.animationTransYPos);

  // loop circular
  //float animationXPos = map(frameCount%item.animationSpeed, 0, item.animationSpeed, 0, item.animationTransXPos);
  //float animationYPos = map(frameCount%item.animationSpeed, 0, item.animationSpeed, 0, item.animationTransYPos);
  //float animationRot = map(frameCount%item.animationSpeed, 0, item.animationSpeed, 0, item.animationTransRot);
  //float animationSca = map(frameCount%item.animationSpeed, 0, item.animationSpeed, 0, item.animationTransSca)

  // noise
  //float animationXPos = map(noise(animationNoise), 0, 1, 0, item.animationTransXPos);
  //float animationYPos = map(noise(animationNoise), 0, 1, 0, item.animationTransYPos);
  //float animationRot = map(noise(animationNoise), 0, 1, 0, item.animationTransRot);
  //float animationSca = map(noise(animationNoise), 0, 1, 0, item.animationTransSca);
  //animationNoise = animationNoise + 1/item.animationSpeed;

  // return updated values to animate item
  float [] updatedValues = {animationXPos, animationYPos, animationRot, animationSca};
  return updatedValues;
}


void setAnimationSpeedPlus() {

  // only increase speed if value would be below animationSpeedMin
  if (activeItem.animationSpeed / animationSpeedIncrement >= animationSpeedMax) {

    //multiply animationSpeed by animationSpeedIncrement
    activeItem.animationSpeed = activeItem.animationSpeed / animationSpeedIncrement;

    // play sound of this function
    if (interfaceSound == true) {
      playSound("set animation speed");
    }
  } else {

    // play sound of this function
    if (interfaceSound == true) {
      playSound("set animation speed max");
    }
  }
}

void setAnimationSpeedMinus() {

  // only decrease speed if value would be above animationSpeedMax
  if (activeItem.animationSpeed * animationSpeedIncrement <= animationSpeedMin) {

    //divide animationSpeed by animationSpeedIncrement
    activeItem.animationSpeed = activeItem.animationSpeed * animationSpeedIncrement;

    // play sound of this function
    if (interfaceSound == true) {
      playSound("set animation speed");
    }
  } else {

    // play sound of this function
    if (interfaceSound == true) {
      playSound("set animation speed max");
    }
  }
}

void deleteItemAnimation() {

  // delete and reset animation values
  activeItem.resetAnimation();

  // play sound of this function
  if (interfaceSound == true) {
    playSound("delete animation");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– FUNCTIONALITY VARIABLES -–––

// !!! NO CHANGES HERE !!!
float xInputDirection = 0, yInputDirection = 0;
float sInputDirection = 0;
float rInputDirection = 0;
float gridSpeed = 8;
// !!! NO CHANGES HERE !!!
