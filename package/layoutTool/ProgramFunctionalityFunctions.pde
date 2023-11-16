
// !!! PLEASE DO NOT MODIFY THIS TAB !!! ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––– !!! PLEASE DO NOT MODIFY THIS TAB !!! 

/*
 This tab stores all the essential functions related to the program functionality.
 */


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– FIXED VARIABLES ––––––––––

// masterFiles: Storage of all imported files from tha data folder. They work as master template for the displayed items.
// Files that can be imported are: jpeg, png, otf, and svg
ArrayList<GraphicItem> masterFiles = new ArrayList<GraphicItem>();

// activeMasterFileIndex: links the master template to the activeItem
int activeMasterFileIndex = 0;

// myItems: all displayed items with individual settings
ArrayList<GraphicItem> myItems = new ArrayList<GraphicItem>();

// activeMyItemsIndex links the myItems entry to the activeItem
int activeMyItemsIndex = -1;

// The current active item that is changable
GraphicItem activeItem;

// Colors
color white = color(255);
color black = color(0);
color grey = color(220);
color red = color(255, 0, 0);
color bgColor;
int bgColorIndex;

// Interface
float UItextSize;
float UIstrokeWeight;
PFont UIFontRegular;
PFont UIFontBold;


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– ADD ITEM –––––––––––––––––

void addItem() {

  if (activeMyItemsIndex != myItems.size()-1) {
    myItems.add(myItems.get(myItems.size()-1));
    for (int i = myItems.size()-2; i > activeMyItemsIndex+1; i--) {
      myItems.set(i, myItems.get(i-1));
    }

    String activeType = masterFiles.get(activeMasterFileIndex).type;
    switch(activeType) {
    case "font":
      myItems.set(activeMyItemsIndex+1, new ShapeFontItem(masterFiles.get(activeMasterFileIndex)));
      break;
    case "image":
      myItems.set(activeMyItemsIndex+1, new imgItem (masterFiles.get(activeMasterFileIndex)));
      break;
    case "vector":
      myItems.set(activeMyItemsIndex+1, new vectorItem (masterFiles.get(activeMasterFileIndex)));
      break;
    case "cam":
      myItems.set(activeMyItemsIndex+1, new camItem(masterFiles.get(activeMasterFileIndex)));
      break;
    }
  } else {

    String activeType = masterFiles.get(activeMasterFileIndex).type;
    switch(activeType) {
    case "font":
      myItems.add(new ShapeFontItem(masterFiles.get(activeMasterFileIndex)));
      break;
    case "image":
      myItems.add(new imgItem (masterFiles.get(activeMasterFileIndex)));
      break;
    case "vector":
      myItems.add(new vectorItem (masterFiles.get(activeMasterFileIndex)));
      break;
    case "cam":
      myItems.add(new camItem(masterFiles.get(activeMasterFileIndex)));
      break;
    }
  }

  activeMyItemsIndex++;
  if (activeItem != null) {
    myItems.get(activeMyItemsIndex).copyValues(activeItem);
    activeItem.active = false;
  }
  activeItem = myItems.get(activeMyItemsIndex);
  activeItem.active = true;
  lastActivity = frameCount;

  if (interfaceSound == true) {
    playSound("add");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– DELETE ITEM –––––––––––––––


void deleteItem() {
  if ( myItems.size() > 1) {
    myItems.remove(activeMyItemsIndex);
    if (activeMyItemsIndex >= myItems.size()) activeMyItemsIndex--;
    activeItem = myItems.get(activeMyItemsIndex);
    activeItem.active = true;
    activeMasterFileIndex = activeItem.fileIndex;
    lastActivity = frameCount;
    if (interfaceSound == true) {
      playSound("delete");
    }
  }
}

// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SWITCH FILE –––––––––––––––


void switchGraphicFileToPrevious() {
  activeMasterFileIndex--;
  if (activeMasterFileIndex < 0) activeMasterFileIndex = masterFiles.size()-1;
  switchGraphicFile();
}

void switchGraphicFileToNext() {
  activeMasterFileIndex++;
  activeMasterFileIndex = activeMasterFileIndex%masterFiles.size();
  switchGraphicFile();
}

void switchGraphicFile() {
  String activeType = masterFiles.get(activeMasterFileIndex).type;
  switch(activeType) {
  case "font":
    myItems.set(activeMyItemsIndex, new ShapeFontItem(masterFiles.get(activeMasterFileIndex)));
    break;
  case "image":
    myItems.set(activeMyItemsIndex, new imgItem (masterFiles.get(activeMasterFileIndex)));
    break;
  case "vector":
    myItems.set(activeMyItemsIndex, new vectorItem (masterFiles.get(activeMasterFileIndex)));
    break;
  case "cam":
    myItems.set(activeMyItemsIndex, new camItem (masterFiles.get(activeMasterFileIndex)));
    break;
  }
  myItems.get(activeMyItemsIndex).copyValues(activeItem);
  activeItem.active = false;
  activeItem = myItems.get(activeMyItemsIndex);
  activeItem.active = true;
  if (interfaceSound == true) {
    playSound("switch file");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SET ACTIVE ITEM –––––––––––

void setPreviousAsActive() {
  if (activeMyItemsIndex > 0) {
    activeMyItemsIndex--;
  } else {
    activeMyItemsIndex = myItems.size()-1;
  }
  switchActive();
}

void setNextAsActive() {
  if (activeMyItemsIndex < myItems.size()-1) {
    activeMyItemsIndex++;
  } else {
    activeMyItemsIndex = 0;
  }
  switchActive();
}

void switchActive() {
  activeItem.active = false;
  activeItem = myItems.get(activeMyItemsIndex);
  activeItem.active = true;
  activeMasterFileIndex = activeItem.fileIndex;
  if (interfaceSound == true) {
    playSound("switch active");
  }
  lastActivity = frameCount;
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– REORDER ACTIVE ITEM –––––––

void reorderItemBackward() {
  int backwardIndex = activeMyItemsIndex - 1;
  reorder(backwardIndex);
}

void reorderItemForward() {
  int forwardIndex = activeMyItemsIndex + 1;
  reorder(forwardIndex);
}

void reorder(int indexToBe) {
  int indexWas = activeMyItemsIndex;
  if (indexToBe >= 0 && indexToBe < myItems.size()) {
    GraphicItem switchItem = myItems.get(indexToBe);
    myItems.set(indexToBe, activeItem);
    myItems.set(activeMyItemsIndex, switchItem);
    activeMyItemsIndex = indexToBe;
    activeItem.active = false;
    activeItem = myItems.get(activeMyItemsIndex);
    activeItem.active = true;
    lastActivity = frameCount;
    if (interfaceSound == true) {
      playSound("reorder");
    }
  } else if (interfaceSound == true) {
      playSound("reorder max");
    }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– EXPORT ––––––––––––––––––––

void export() {
  if (interfaceSound == true) {
    playSound("export start");
  }
  exportInterface();
  PGraphics exportCanvas = createGraphics(int(width*2), int(height*2));
  float upscaleFactor = float(exportCanvas.width) / float(width);
  exportCanvas.beginDraw();
  exportCanvas.background(bgColor);
  for (int i = 0; i < myItems.size(); i++) {
    myItems.get(i).printCanvas(exportCanvas, upscaleFactor);
  }
  exportCanvas.endDraw();
  exportCanvas.save("export/myLayout_" + timestamp() + ".png");

  loop();
  if (interfaceSound == true) {
    playSound("export finish");
  }
}

void exportInterface() {
  float size = min(width, height) / 3.5;

  pushStyle();
  pushMatrix();

  blendMode(BLEND);

  translate(width/2, height/2);
  noStroke();
  fill(grey, (255*(1.0-alphaInactivityMin)));
  rect(0, 0, width, height);

  noFill();
  stroke(black);
  strokeWeight(UIstrokeWeight/2.5);
  ellipse(0, 0, size, size);

  translate(0, UItextSize*0.25);
  fill(black);
  textFont(UIFontBold);
  textSize(UItextSize);
  textAlign(CENTER);
  text("export", 0, 0);

  popMatrix();
  popStyle();

  noLoop();
}

String timestamp() {
  // get a unique timestamp of the current time (for data export)
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– RESET –––––––––––––––––––––

void reset() {
  bgColorIndex = myColors.length-1;
  bgColor = myColors[bgColorIndex];
  myItems.clear();
  activeItem = null;
  activeMasterFileIndex = 0;
  activeMyItemsIndex = -1;
  addItem();
  resetPowerMove();
  if (interfaceSound == true) {
    playSound("reset");
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– LOAD FILES ––––––––––––––––

// File Observer
File folder;
File [] files;

void loadFiles() {


  // Check for color palette
  File colorFolder = new File(dataPath("input/colors/"));
  File [] colorFiles = colorFolder.listFiles();
  if (colorFiles != null) {
    for (int i = 0; i<colorFiles.length; i++) {
      File tempFile = colorFiles[i];
      if (match(""+tempFile, ".png") != null || match(""+tempFile, ".jpeg") != null || match(""+tempFile, ".jpg") != null) {
        PImage newColors = loadImage(""+tempFile);
        newColors.loadPixels();
        int[] tempColors = newColors.pixels;
        tempColors = sort(tempColors);
        if (newColors.pixels.length < maxImportColors) {
          myColors = newColors.pixels;
        } else {
          myColors = new color[maxImportColors];
          for (int p = 0; p<maxImportColors; p++) {
            int tempIndex = (newColors.pixels.length/maxImportColors)*p;
            myColors[p] = tempColors[tempIndex];
          }
        }
        break;
      }
    }
  }
  bgColorIndex = myColors.length-1;
  bgColor = myColors[bgColorIndex];


  // list all files in data folder
  files = folder.listFiles();

  // Sort files alphabetically
  String [] filesSorted = new String [0];
  for (int i = 0; i<files.length; i++) {
    File tempFile = files[i];
    if (match(""+tempFile, ".jpg") != null || match(""+tempFile, ".jpeg") != null || match(""+tempFile, ".png") != null ||
      match(""+tempFile, ".svg") != null || match(""+tempFile, ".otf") != null) {
      filesSorted = append(filesSorted, ""+tempFile);
    }
  }
  filesSorted = sort(filesSorted);

  // Load files depending on data type
  for (int i = 0; i<filesSorted.length; i++) {
    File tempFile = new File(dataPath("" + filesSorted[i]));
    if (match(""+tempFile, ".jpg") != null)        masterFiles.add(new imgItem ("image", tempFile, i));
    else if (match(""+tempFile, ".jpeg") != null)   masterFiles.add(new imgItem ("image", tempFile, i));
    else if (match(""+tempFile, ".png") != null)   masterFiles.add(new imgItem ("image", tempFile, i));
    else if (match(""+tempFile, ".svg") != null)   masterFiles.add(new vectorItem ("vector", tempFile, i));
    else if (match(""+tempFile, ".otf") != null)   masterFiles.add(new fontItem ("font", tempFile, i));
  }

  // Add camera item
  // masterFiles.add(new camItem(this));
}

void checkFiles() {
  if (files.length != folder.listFiles().length) {
    files = folder.listFiles();

    for (int i = 0; i<files.length; i++) {
      File tempFile = files[i];
      boolean newFile = true;
      for (int j = 0; j<masterFiles.size(); j++) {
        if ((""+tempFile).equals((""+masterFiles.get(j).file))) {
          newFile = false;
        }
      }

      if (newFile) {
        if (match(""+tempFile, "colors.png") != null)  continue;
        else if (match(""+tempFile, ".jpg") != null)   masterFiles.add(new imgItem ("image", tempFile, i));
        else if (match(""+tempFile, ".png") != null)   masterFiles.add(new imgItem ("image", tempFile, i));
        else if (match(""+tempFile, ".svg") != null)   masterFiles.add(new vectorItem ("vector", tempFile, i));
        else if (match(""+tempFile, ".otf") != null)   masterFiles.add(new ShapeFontItem("font", tempFile, i));
      }
    }
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SWITCH SOUND ––––––––––––––

void switchInterfaceSound() {
  interfaceSound = !interfaceSound;
}

void switchBackgroundSound() {
  backgroundSound = !backgroundSound;

  if (backgroundSound == true) {
    playBackgroundSound();
  } else {
    stopBackgroundSound();
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– ACTIVITY ––––––––––––––––––

// Activity Status
int lastActivity = 0;
int activityAlphaResetStart = 60;
int activityAlphaResetLerp = 15;
float alphaInactivityMin = 0.3;
float alphaInactivityMax = 1.0;
float alphaInactivity = 1.0;


void setActivityAlpha() {
  if (frameCount-lastActivity <= activityAlphaResetStart) {
    alphaInactivity = alphaInactivityMin;
  } else if (frameCount-lastActivity > activityAlphaResetStart &&
    frameCount-lastActivity <= activityAlphaResetStart + activityAlphaResetLerp) {
    alphaInactivity = map(frameCount-lastActivity, activityAlphaResetStart,
      activityAlphaResetStart + activityAlphaResetLerp, alphaInactivityMin, alphaInactivityMax);
  } else {
    alphaInactivity = alphaInactivityMax;
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SETUP INTERFACE –––––––––––

void setupInterface() {
  // Load and setup interface variables
  UItextSize = min(width, height) / 15;
  UIstrokeWeight = min(width, height) / 30;
  UIFontRegular = createFont("interface/font/strokeWeight-100.otf", UItextSize);
  UIFontBold = createFont("interface/font/strokeWeight-180.otf", UItextSize);
}
