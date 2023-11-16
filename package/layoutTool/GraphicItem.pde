
// !!! PLEASE DO NOT MODIFY THIS TAB !!! ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––– !!! PLEASE DO NOT MODIFY THIS TAB !!!

/*
 This tab contains the essential functions related to displaying the graphic items.
 The Graphic Item Class serves as a framework for managing various types of graphic items
 with a specific set of configurable variables.
 The subclasses for image, vector font and cam items are adapted for the visual integration.
 */


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– GLOBAL –––––––––––––––––––

class GraphicItem {

  boolean active = false;
  float size = min(width, height)/4;
  String type;
  File file;
  int fileIndex;

  PVector position = new PVector(width/2, height/2);
  float scale = 1.0;
  float rotation = 0;

  int colIndex = 0;
  color col = myColors[colIndex];

  int blendModeIndex = 0;
  int blendMode = blendModes[blendModeIndex];
  boolean randomSet = false;


  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– ITEM SPECIFIC ––––––––––––––

  // Image Item
  PImage img;
  PImage imgDefault;
  PImage[] imgDuplex = new PImage[myColors.length];
  PImage[] imgDuplexAlpha = new PImage[myColors.length];
  boolean defaultColor = true;
  boolean imageModeAlpha = false;

  // Vector Item
  PShape shape;
  boolean vectorModeStroke = false;
  float strokeWeight = strokeWeightDefault;

  // Font Item
  int fontFamilyIndex = 0;
  int activeCharIndex = 0;
  String text = "" + characterSet[activeCharIndex];

  // Cam Item
  Capture cam;
  boolean camModeLive = false;


  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– POWER MOVES ––––––––––––––––

  // Drawing
  PGraphics imgDrawing;
  Boolean drawing = false;
  boolean drawingDelete = false;
  Boolean drawingSetup = false;
  PVector drawingCornerTopLeft = new PVector(0, 0);
  PVector drawingCornerBottomRight = new PVector(0, 0);
  PVector drawingCenter = new PVector(0, 0);
  PVector drawingPosition = new PVector(0, 0);
  float drawingScale = 0.0;
  float drawingRotation = 0;

  // Animation
  boolean animation = false;
  float animationSpeed = animationSpeedDefault;
  float animationRestXPos = 0;
  float animationRestYPos = 0;
  float animationRestRot = 0;
  float animationRestSca = 0;
  float animationTransXPos = 0;
  float animationTransYPos = 0;
  float animationTransRot = 0;
  float animationTransSca = 0;

  // Repetition
  boolean repetition = false;
  PVector repetitionPosition = new PVector(0, 0);
  PVector repetitionDirection = new PVector(0, 0);
  PVector repetitions = new PVector(1, 1);



  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– CONSTRUCTOR ––––––––––––––––

  GraphicItem (String t, File f, int fI) {
    type = t;
    file = f;
    fileIndex = fI;
    println("Loaded: " + file);
  }

  GraphicItem (GraphicItem item) {
    type = item.type;
    file = item.file;
    fileIndex = item.fileIndex;
  }

  GraphicItem () {
  }


  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– UPDATE –––––––––––––––––––––

  void update() {
    if (drawingDelete == true) {
      drawingDelete = false;
      deleteDrawing();
    }
    if (randomSet == true) {
      randomReset(this);
      randomSet = false;
    }
  }

  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– DISPLAY ––––––––––––––––––––

  void display() {
    pushMatrix();
    blendMode(blendMode);
    if (drawing == true) {
      displayDrawing();
    } else {
      translate(position.x, position.y);
      rotate(radians(rotation));
      scale(scale);
      if (animation) animate();
      if (repetition) {
        for (float xRepetition = int(repetitions.x)*-0.5; xRepetition <= repetitions.x*0.5; xRepetition++) {
          for (float yRepetition = int(repetitions.y)*-0.5; yRepetition <= repetitions.y*0.5; yRepetition++) {
            float x = lerp(0, repetitionDirection.x * repetitions.x, xRepetition*(1.0/repetitions.x));
            float y = lerp(0, repetitionDirection.y * repetitions.y, yRepetition*(1.0/repetitions.y));
            displayItemSpecific(x, y);
          }
        }
      } else {
        displayItemSpecific(0, 0);
      }
    }
    popMatrix();
  }


  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– PRINT ––––––––––––––––––––––

  void printCanvas(PGraphics c, float s) {
    c.pushMatrix();
    c.imageMode(CENTER);
    c.blendMode(BLEND);
    if (drawing == true) {
      PGraphics d = createGraphics(width, height);
      d.beginDraw();
      d.pushMatrix();
      d.translate(drawingCenter.x+(position.x-drawingPosition.x), drawingCenter.y+(position.y-drawingPosition.y));
      d.rotate(radians(rotation-drawingRotation));
      d.scale(constrain(scale-drawingScale+1.0, scaleMin, scaleMax));
      d.translate(-drawingCenter.x+width/2, -drawingCenter.y+height/2);
      d.imageMode(CENTER);
      d.image(imgDrawing, 0, 0);
      d.popMatrix();
      d.endDraw();
      c.image(d, c.width/2, c.height/2, c.width, c.height);
    } else {
      c.translate(map(position.x, 0, width, 0, c.width), map(position.y, 0, height, 0, c.height));
      c.scale(scale*s);
      c.rotate(radians(rotation));
      drawItemSpecific(0, 0, c);
    }
    c.popMatrix();
  }


  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– COPY –––––––––––––––––––––––

  void copyValues(GraphicItem prevItem) {
    position.set(prevItem.position.x, prevItem.position.y);
    scale = prevItem.scale;
    rotation = prevItem.rotation;

    colIndex = prevItem.colIndex;
    col = myColors[colIndex];
    defaultColor = prevItem.defaultColor;
    imageModeAlpha = prevItem.imageModeAlpha;
    blendMode = prevItem.blendMode;
    blendModeIndex = prevItem.blendModeIndex;

    activeCharIndex = prevItem.activeCharIndex;
    if (prevItem.text != null) {
      text = prevItem.text;
    } else {
      text = "" + characterSet[activeCharIndex];
    }

    vectorModeStroke = prevItem.vectorModeStroke;
    strokeWeight = prevItem.strokeWeight;

    if (type == "image") {
      updateImg();
    }
  }

  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– DUPLEX –––––––––––––––––––––

  PImage createColorImage(PImage img1, color col1, boolean alpha) {
    PImage img2 = createImage(img1.width, img1.height, ARGB);
    color pixelColor;
    for (int i = 0; i < img1.pixels.length; i++) {
      float alphaS = map(saturation(img1.pixels[i]), 0.0, 255.0, 0.0, 255.0);
      float alphaB = map(brightness(img1.pixels[i]), 0.0, 255.0, 255.0, 0.0);
      if (alpha) {
        pixelColor = color(red(col1), green(col1), blue(col1), max(alphaS, alphaB));
      } else {
        pixelColor = lerpColor(color(255), col1, max(alphaS, alphaB)/255);
      }
      img2.pixels[i] = pixelColor;
    }
    return img2;
  }


  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– POWER MOVE: DRAWING ––––––––

  // Power Move: Drawing ––––––––––––––––––

  void updateDrawing() {
    if (drawingSetup == false) {
      setupDrawing();
    }

    imgDrawing.beginDraw();
    imgDrawing.pushMatrix();
    imgDrawing.translate(position.x-((width-imgDrawing.width)/2), position.y-((height-imgDrawing.height)/2));
    imgDrawing.scale(scale);
    imgDrawing.rotate(radians(rotation));
    drawItemSpecific(0, 0, imgDrawing);
    imgDrawing.popMatrix();
    imgDrawing.endDraw();

    drawingCornerTopLeft.set(min(position.x, drawingCornerTopLeft.x), min(position.y, drawingCornerTopLeft.y));
    drawingCornerBottomRight.set(max(position.x, drawingCornerBottomRight.x), max(position.y, drawingCornerBottomRight.y));
    float centerX = ((drawingCornerBottomRight.x-drawingCornerTopLeft.x)/2)+drawingCornerTopLeft.x;
    float centerY = ((drawingCornerBottomRight.y-drawingCornerTopLeft.y)/2)+drawingCornerTopLeft.y;
    drawingCenter.set(centerX, centerY);
    drawingPosition.set(position.x, position.y);
    drawingScale = scale;
    drawingRotation = rotation;
  }

  void displayDrawing() {

    if (powerMoveMode == false) drawingSetup = false;
    translate(drawingCenter.x+(position.x-drawingPosition.x), drawingCenter.y+(position.y-drawingPosition.y));
    rotate(radians(rotation-drawingRotation));
    scale(constrain(scale-drawingScale+1.0, scaleMin, scaleMax));
    if (animation == true) animate();
    translate(-drawingCenter.x+width/2, -drawingCenter.y+height/2);
    if (active == false) tint(white, int(map(alphaInactivity, 0.0, 1.0, 0, 255)));
    image(imgDrawing, 0, 0);
    noTint();
  }

  void setupDrawing() {
    imgDrawing = createGraphics(int(width*2), int(height*2));
    drawingCornerTopLeft.set(position.x, position.y);
    drawingCornerBottomRight.set(position.x, position.y);

    drawingSetup = true;
    drawing = true;
  }

  void deleteDrawing() {
    imgDrawing = createGraphics(int(width*2), int(height*2));
    drawingCornerTopLeft.set(0, 0);
    drawingCornerBottomRight.set(0, 0);
    drawingCenter.set(0, 0);
    drawingPosition.set(0, 0);
    drawing = false;
    drawingSetup = false;
  }

  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– POWER MOVE: ANIMATION ––––––

  void animate() {

    float [] updatedValues = updateAnimationValues(this);

    translate(updatedValues[0], updatedValues[1]);
    rotate(radians(updatedValues[2]));
    scale(1.0+updatedValues[3]);
  }

  void updateAnimation() {
    if (animation == false) {
      setupAnimation();
    }

    animationTransXPos = position.x-animationRestXPos;
    animationTransYPos = position.y-animationRestYPos;
    animationTransRot = rotation-animationRestRot;
    animationTransSca = scale-animationRestSca;
  }

  void setupAnimation () {
    animationRestXPos = position.x;
    animationRestYPos = position.y;
    animationRestRot = rotation;
    animationRestSca = scale;

    animation = true;
  }

  void resetAnimation() {
    animation = false;
    animationSpeed = animationSpeedDefault;
    animationRestXPos = 0;
    animationRestYPos = 0;
    animationRestRot = 0;
    animationRestSca = 0;
    animationTransXPos = 0;
    animationTransYPos = 0;
    animationTransRot = 0;
    animationTransSca = 0;
  }


  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– POWER MOVE: REPETITION –––––

  void setupRepetition() {
    repetitionPosition.set(position.x+size, position.y+size);
    repetition = true;
  }

  void updateRepetition() {
    if (repetition == false) setupRepetition();
    repetitionDirection.set(position.x-repetitionPosition.x, position.y - repetitionPosition.y);
  }


  // –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––

  void displayItemSpecific(float x, float y) {
  }
  void drawItemSpecific(float x, float y, PGraphics canvas) {
  }
  void updateImg() {
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SUBCLASS: IMAGE ––––––––––––

class imgItem extends GraphicItem {

  imgItem (String t, File f, int fI) {
    super(t, f, fI);
    defaultColor = true;

    imgDefault = loadImage(""+f);
    for (int i = 0; i < myColors.length; i++) {
      imgDuplex[i] = createColorImage(imgDefault, myColors[i], false);
      imgDuplexAlpha[i] = createColorImage(imgDefault, myColors[i], true);
    }
    updateImg();
  }

  imgItem (GraphicItem item) {
    super(item);
    img = item.img.copy();
    imgDefault = item.imgDefault.copy();
    for (int i = 0; i < item.imgDuplex.length; i++) {
      imgDuplex[i] = item.imgDuplex[i].copy();
      imgDuplexAlpha[i] = item.imgDuplexAlpha[i].copy();
    }
  }

  void displayItemSpecific(float x, float y) {
    if (active == false) tint(white, int(map(alphaInactivity, 0.0, 1.0, 0, 255)));
    image (img, x, y, (size/img.height)*img.width, size);
    noTint();
  }

  void drawItemSpecific(float x, float y, PGraphics canvas) {
    canvas.imageMode(CENTER);
    canvas.image(img, x, y, (size/img.height)*img.width, size);
    canvas.noTint();
  }

  void updateImg() {
    if (defaultColor == true)     img = imgDefault;
    else {
      if (imageModeAlpha == true) img = imgDuplexAlpha[colIndex];
      else                        img = imgDuplex[colIndex];
    }
  }
}

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SUBCLASS: VECTOR –––––––––––

class vectorItem extends GraphicItem {

  vectorItem (String t, File f, int fI) {
    super(t, f, fI);
    shape = loadShape(""+f);
  }

  vectorItem (GraphicItem item) {
    super(item);
    shape = item.shape;
  }

  void displayItemSpecific(float x, float y) {
    shape.disableStyle();

    if (vectorModeStroke == true) {
      if (active == true) stroke(col);
      else                stroke(lerpColor(white, col, alphaInactivity));
      strokeWeight(strokeWeight);
      noFill();
    } else {
      if (active == true) fill(col);
      else                fill(lerpColor(white, col, alphaInactivity));
      noStroke();
    }

    shape(shape, x, y, size, size);
  }

  void drawItemSpecific(float x, float y, PGraphics canvas) {
    shape.disableStyle();
    canvas.shapeMode(CENTER);
    if (vectorModeStroke == true) {
      canvas.stroke(col);
      canvas.strokeWeight(strokeWeight);
      canvas.noFill();
    } else {
      canvas.fill(col);
      canvas.noStroke();
    }
    canvas.shape(shape, x, y, size, size);
  }
}


class fontItem extends GraphicItem {

  fontItem (String t, File f, int fI) {
    super(t, f, fI);

    // Check if font is a font family or single font
    if (match(""+f, "_otf") != null) {

      File fontFolder =  new File(dataPath("" + f));
      File [] fontFiles = fontFolder.listFiles();

      String [] fontFilesSorted = new String [0];
      for (int i = 0; i<fontFiles.length; i++) {
        File tempFontFile = fontFiles[i];
        if (match(""+tempFontFile, "\\.otf") != null) {
          fontFilesSorted = append(fontFilesSorted, ""+tempFontFile);
        }
      }
      fontFilesSorted = sort(fontFilesSorted);
      fontFamily = new PFont[fontFilesSorted.length];

      for (int i = 0; i<fontFilesSorted.length; i++) {
        File tempFontFile =  new File(dataPath("" + fontFilesSorted[i]));

        if (match(""+tempFontFile, "\\.otf") != null) {
          fontFamily[i] = createFont(""+tempFontFile, size);
          println("Loaded: " + tempFontFile);
        }
      }
    } else {
      fontFamily = new PFont[1];
      fontFamily[0] = createFont(""+f, size);
    }
  }

  // javascript constructor
  fontItem (GraphicItem item) {
    super(item);
    fontFamily = item.fontFamily;
    fontFamilyIndex= item.fontFamilyIndex;
  }

  void displayItemSpecific(float x, float y) {
    textFont(fontFamily[fontFamilyIndex]);
    textAlign(CENTER);
    if (active == true) fill(col);
    else                fill(lerpColor(white, col, alphaInactivity));
    noStroke();

    if (fontFamily[fontFamilyIndex].getGlyph(text.charAt(0)) != null) {
      float textHeight = fontFamily[fontFamilyIndex].getGlyph(text.charAt(0)).height;
      text(text, x, y + textHeight/2);
    } else {
      text(text, x, y + size*0.35);
    }
  }

  void drawItemSpecific(float x, float y, PGraphics canvas) {
    canvas.textFont(fontFamily[fontFamilyIndex]);
    canvas.textAlign(CENTER);
    canvas.fill(col);
    canvas.noStroke();
    canvas.text(text, x, y+fontFamily[fontFamilyIndex].getGlyph(text.charAt(0)).height/2);
  }
}



// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SUBCLASS: CAMERA -––––––––––

class camItem extends GraphicItem {

  camItem (PApplet main) {
    type = "cam";
    String[] cameras = Capture.list();
    println("\nAvailable Cameras: ");
    printArray(cameras);
    cam = new Capture(main, 1920/2, 1080/2, cameras[cameraIndex], 25);
    cam.start();
    camModeLive = true;
    defaultColor = true;
  }

  camItem (GraphicItem item) {
    super(item);
    cam = item.cam;
    if (item.type == "cam") camModeLive = item.camModeLive;
    if (item.img != null) img = item.img.copy();
    if (item.imgDefault != null) imgDefault = item.imgDefault.copy();
    for (int i = 0; i < item.imgDuplex.length; i++) {
      if (item.imgDuplex[i] != null) {
        imgDuplex[i] = item.imgDuplex[i].copy();
      }
    }
  }

  void displayItemSpecific(float x, float y) {
    if (cam.available() == true) cam.read();
    if (active == false) tint(white, int(map(alphaInactivity, 0.0, 1.0, 0, 255)));
    if (camModeLive == false && img != null)  image(img, x, y, (size/img.height)*img.width, size);
    else                                      image(cam.copy(), x, y, (size/cam.height)*cam.width, size);
    noTint();
  }

  void drawItemSpecific(float x, float y, PGraphics canvas) {
    canvas.imageMode(CENTER);
    if (cam.available() == true) cam.read();
    if (camModeLive == false) canvas.image(img, x, y, (size/img.height)*img.width, size);
    else                      canvas.image(cam, x, y, (size/cam.height)*cam.width, size);
  }

  void updateImg() {
    if (camModeLive == false) {
      if (defaultColor == true) img = imgDefault;
      else                      img = imgDuplex[colIndex];
    }
  }
}
