import processing.javafx.*;

// import org.gamecontrolplus.Configuration.*;

GamepadGUI helper;

void setup() {
  size(1920, 1080, FX2D);
  surface.setResizable(true);
  
  // helper setup
  helper = new GamepadGUI(this, "gamepadgui/config.xml");
}
void draw() {
  background(255);
  
  // helper preview
  float pw = 500; // controller width
  helper.setPreviewPosition(width - pw, height - helper.previewHeight);
  helper.setPreviewWidth(pw);
  helper.update();
}
