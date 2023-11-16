

// !!! PLEASE DO NOT MODIFY THIS TAB !!! ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––– !!! PLEASE DO NOT MODIFY THIS TAB !!!

/*
 This tab imports and manages the sound elements within the program.
 The 'UIsound' variables link custom sound effects to program interactions like functions.
 The 'bgSound' variable enables to implement background music within their designs. The sound is playing at on loop if active.
 */


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– FIXED VARIABLES ––––––––––

// Soundfiles
SoundFile UIsound_add_1, UIsound_add_2, UIsound_delete_1, UIsound_delete_2, UIsound_switch_1, UIsound_switch_2,
  UIsound_random_1, UIsound_random_2, UIsound_set_1, UIsound_set_2, UIsound_setMax, UIsound_reset_1, UIsound_reset_2,
  UIsound_export, UIsound_exportComplete, UIsound_powerMove;
SoundFile bgSound;

// Oscilliators
Pulse UIsound_pulse;
SinOsc UIsound_sinOsc;
TriOsc UIsound_triOsc;


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SETUP SOUND –––––––––––––––

void setupSound() {
  UIsound_add_1 = new SoundFile(this, "interface/sound/Add1.mp3");
  UIsound_add_2 = new SoundFile(this, "interface/sound/Add2.mp3");
  UIsound_delete_1 = new SoundFile(this, "interface/sound/Delete1.mp3");
  UIsound_delete_2 = new SoundFile(this, "interface/sound/Delete2.mp3");
  UIsound_switch_1 = new SoundFile(this, "interface/sound/Switch1.mp3");
  UIsound_switch_2 = new SoundFile(this, "interface/sound/Switch2.mp3");
  UIsound_random_1 = new SoundFile(this, "interface/sound/Random1.mp3");
  UIsound_random_2 = new SoundFile(this, "interface/sound/Random2.mp3");
  UIsound_set_1 = new SoundFile(this, "interface/sound/Set1.mp3");
  UIsound_set_2 = new SoundFile(this, "interface/sound/Set2.mp3");
  UIsound_setMax = new SoundFile(this, "interface/sound/SetMax.mp3");
  UIsound_reset_1 = new SoundFile(this, "interface/sound/Reset1.mp3");
  UIsound_reset_2 = new SoundFile(this, "interface/sound/Reset2.mp3");
  UIsound_export = new SoundFile(this, "interface/sound/Export1.mp3");
  UIsound_exportComplete = new SoundFile(this, "interface/sound/Export2.mp3");
  UIsound_powerMove = new SoundFile(this, "interface/sound/PowerMove.mp3");

  File soundFolder = new File(dataPath("input/sound/"));
  File [] soundFiles = soundFolder.listFiles();
  if (soundFiles != null) {
    for (int i = 0; i<soundFiles.length; i++) {
      File tempFile = soundFiles[i];
      if (match(""+tempFile, ".aiff") != null || match(""+tempFile, ".mp3") != null) {
        bgSound = new SoundFile(this, "" + tempFile);
        break;
      }
    }
  }

  if (backgroundSound == true && bgSound != null) {
    bgSound.loop();
  }


  UIsound_pulse = new Pulse(this);
  UIsound_sinOsc = new SinOsc(this);
  UIsound_triOsc = new TriOsc(this);
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– PLAY INTERFACE SOUND ––––––

void playSound(String command) {
  switch(command) {
  case "add":
    UIsound_add_1.play(1.0, 0.3);
    break;
  case "delete":
    UIsound_delete_1.play(1.0, 0.3);
    break;
  case "switch file":
    UIsound_switch_1.play(1.0, 0.3);
    break;
  case "switch active":
    UIsound_switch_1.play(1.0, 0.3);
    break;
  case "reorder":
    UIsound_set_1.play(1.0, 0.3);
    break;
      case "reorder max":
    UIsound_setMax.play(1.0, 0.3);
    break;
  case "switch letter":
    UIsound_set_2.play(1.0, 0.3);
    break;
  case "add letter":
    UIsound_add_2.play(1.0, 0.3);
    break;
  case "delete letter":
    UIsound_delete_2.play(1.0, 0.3);
    break;
  case "switch mode":
    UIsound_switch_2.play(1.0, 0.3);
    break;
  case "strokeweight":
    UIsound_set_2.play(1.0, 0.3);
    break;
  case "strokeweight max":
    UIsound_setMax.play(1.0, 0.3);
    break;
  case "color":
    UIsound_set_2.play(1.0, 0.3);
    break;
  case "background color":
    UIsound_set_1.play(1.0, 0.3);
    break;
  case "random":
    UIsound_random_2.play(1.0, 0.3);
    break;
  case "all random":
    UIsound_random_1.play(1.0, 0.3);
    break;
  case "delete drawing":
    UIsound_delete_2.play(1.0, 0.3);
    break;
  case "repetition":
    UIsound_set_2.play(1.0, 0.3);
    break;
  case "repetition max":
    UIsound_setMax.play(1.0, 0.3);
    break;
  case "delete repetition":
    UIsound_delete_2.play(1.0, 0.3);
    break;
  case "set animation speed":
    UIsound_set_2.play(1.0, 0.3);
    break;
  case "set animation speed max":
    UIsound_setMax.play(1.0, 0.3);
    break;
  case "delete animation":
    UIsound_delete_2.play(1.0, 0.3);
    break;
  case "reset":
    UIsound_reset_1.play(1.0, 0.3);
    break;
  case "export start":
    UIsound_export.play(1.0, 0.3);
    break;
  case "export finish":
    UIsound_exportComplete.play(1.0, 0.3);
    break;
  case "activate power move":
    UIsound_powerMove.play(1.0, 0.3);
    break;
  case "confirm power move":
    UIsound_add_2.play(1.0, 0.3);
    break;
  case "delete power move":
    UIsound_delete_2.play(1.0, 0.3);
    break;
  case "reset power move":
    UIsound_reset_2.play(1.0, 0.3);
    break;
  case "add combo":
    UIsound_set_2.play(1.0, 0.3);
    break;
  case "valid combo":
    UIsound_add_2.play(1.0, 0.3);
    break;
  case "invalid combo":
    UIsound_delete_2.play(1.0, 0.3);
    break;
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– INTERFACE SOUND –––––––––––

void playSound(String command, float value) {
  switch(command) {
  case "move":
    UIsound_sinOsc.play(height-value, 0.05);
    break;
  case "scale":
    UIsound_pulse.play(value*100, 0.01);
    break;
  case "rotate":
    UIsound_triOsc.play(value*TWO_PI, 0.05);
    break;
  }
}

void endSound(String command) {
  switch(command) {
  case "move":
    UIsound_sinOsc.stop();
    break;
  case "scale":
    UIsound_pulse.stop();
    break;
  case "rotate":
    UIsound_triOsc.stop();
    break;
  }
}


// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– BACKGROUND SOUND ––––––––––

void stopBackgroundSound() {
  if (bgSound != null) {
    bgSound.stop();
  }
}

void playBackgroundSound() {
  if (bgSound != null) {
    bgSound.loop();
  }
}
