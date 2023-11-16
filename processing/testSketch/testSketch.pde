
//Libraries

import processing.sound.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import processing.video.*;
import processing.javafx.*;
import java.util.Calendar;

Capture cam;
SoundFile sound;

ControlIO control;
Configuration config;
ControlDevice gpad;

float pupilPosX, pupilPosY, pupilSize;
float eyeRad = 80, eyeSize = eyeRad * 2;
float browSize =  eyeSize * 1.2f, browFactor;
float irisRad = 42, irisSize = irisRad * 2;
float lidPos, restLid = PI * 0.3f, minLid = restLid/1.5f, maxLid = PI * 0.92f;

public void setup() {
  size(400, 500);
  surface.setTitle("GCP Gamepad example");
  control = ControlIO.getInstance(this);
  gpad = control.filter(GCP.GAMEPAD).getMatchedDevice("PS_Controller_Setup");
  if (gpad == null) {
    println("No suitable device configured");
    System.exit(-1); 
  }
    String[] cameras = Capture.list();
  cam = new Capture(this, 1920, 1080, cameras[0], 25);
  cam.start();

  sound = new SoundFile(this, "sound.aiff");
  sound.loop();
}

public void getUserInput() {
  boolean dilated = gpad.getButton("CR").pressed();
  pupilSize = dilated ? irisSize * 0.6f : irisSize * 0.45f; 
  pupilPosX =  0.9f * map(gpad.getSlider("LX").getValue(), -1, 1, -(eyeRad - irisRad), eyeRad - irisRad);
  pupilPosY =  0.9f * map(gpad.getSlider("LY").getValue(), -1, 1, -(eyeRad - irisRad), eyeRad - irisRad);
  lidPos = gpad.getSlider("RY").getValue();
  browFactor = (lidPos >= 0) ? 1 : map(lidPos, 0, -1, 1.1f, 1.3f);
  lidPos = map(lidPos, -0.12f, 1, restLid, maxLid);
  lidPos = constrain(lidPos, minLid, maxLid);
}

public void draw() {
    if (cam.available() == true) cam.read();
  getUserInput();
  background(255, 200, 255);
  image(cam, 0, 250, 400, 250);
  drawEye(100, 125);
  drawEye(300, 125);
}

public void drawEye(int x, int y) {
  pushMatrix();
  translate(x, y);
  stroke(0, 96, 0);
  strokeWeight(3);
  fill(255);
  ellipse(0, 0, eyeSize, eyeSize);
  noStroke();
  fill(120, 100, 220);
  ellipse(pupilPosX, pupilPosY, irisSize, irisSize);
  fill(32);
  ellipse(pupilPosX, pupilPosY, pupilSize, pupilSize);
  stroke(0, 96, 0);
  strokeWeight(4);
  fill(220, 160, 220);
  arc(0, 0, eyeSize, eyeSize, 1.5f*PI-lidPos, 1.5f*PI+lidPos, CHORD);
  stroke(100, 100, 10);
  strokeWeight(10);
  noFill();
  arc(0, 0, browSize, browSize * browFactor, 1.2f*PI, 1.8f*PI);
  popMatrix();
}
