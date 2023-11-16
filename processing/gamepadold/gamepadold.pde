import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import java.util.LinkedHashMap;
import processing.javafx.*;

// import org.gamecontrolplus.Configuration.*;

Guide guide;

public interface GuideConst {
  final String INFO_BUTTON = "info-button";
  final String INPUT_BUTTON = "button";
  final String INPUT_HAT = "hat";
  final String INPUT_SLIDER = "slider";
}

public class Guide implements GuideConst {
   
  PGraphics pg = createGraphics(0, 0);
  PGraphics gPreview = createGraphics(500, 500);
  PShape svgShape;
  PShape guideShape;
  LinkedHashMap<PShape, ArrayList<XML>> allShapes = new LinkedHashMap<PShape, ArrayList<XML>>();
  ArrayList<XML> inputs = new ArrayList<XML>();
  PFont font;
  ControlDevice gpad;

  protected float previewX = 0;
  protected float previewY = 0;
  protected float previewWidth;
  protected float previewHeight;
  protected float previewAlpha = 255;
  
  // enum input types
  
  // settings
  int highlightColor = color(0, 255, 255);
  int fontSize = 32;
  int margin = 1; // rem
  int highlightDuration = 2000;

  protected boolean preview = true;
  protected boolean infoDisabled = true;
  protected boolean isClosed = false;

  // private
  private boolean closed = true;
  private int closedDuration = 300;
  private int closedTime = -closedDuration;
  private float closedAmt = 0;
  private boolean hasResized = false;
  private XML highlightInput;
  private int highlightTimer = -1;

  // text
  String title = "";
  String paragaph = "";
  String info = "";
  String guideClose = "Back";

  Guide(PApplet app, String xmlName) {
    font = createFont("Arial", fontSize, true);
    XML xml = loadXML(xmlName);

    // svg
    String svgPath = xml.getChild("svg").getContent();
    svgShape = loadShape(svgPath);
    svgShape.disableStyle();

    XML[] rawInputs = xml.getChild("inputs").getChildren();

    // config controller
    String configPath = xml.getChild("gamepad-config").getContent();
    Configuration config = Configuration.makeConfiguration(app, configPath);
    ControlIO control = ControlIO.getInstance(app);
    gpad = control.filter(GCP.GAMEPAD).getMatchedDevice(configPath);
    if(gpad == null) println("no gamepad found");

    for(int i = 0; i < svgShape.getChildCount(); i++) {
      PShape shape = svgShape.getChild(i);
      allShapes.put(shape, new ArrayList<XML>());
    }

    // setup guide button
    XML guideXML = xml.getChild(INFO_BUTTON);
    if(guideXML != null) {
      String key = guideXML.getString("key");
      infoDisabled = guideXML.getInt("disabled") == 1;
      
      gpad.getButton(key).plug(this, "toggleGuide", ControlIO.ON_RELEASE);

      guideShape = findShape(svgShape, guideXML.getString("layer"));
      // remove shape
      allShapes.remove(guideShape);
    }

    // filter comments
    for(XML input:rawInputs) {
      String name = input.getName();
      if(name.startsWith("#")) continue;
      inputs.add(input);
    }

    for (XML button:inputs) {
      String name = button.getName();
      String key = button.getString("key");
      String layer = button.getString("layer");

      PShape shape = findShape(svgShape, layer);
      if(shape == null) {
        println("No svg object named '" + layer + "' for input '" + key + "'");
        continue;
      }

      if(allShapes.containsKey(shape)) {
        allShapes.get(shape).add(button);
      }
    }

    // texts
    title = xml.getChild("title").getContent();
    
    String[] textNodes = {};
    XML[] texts = xml.getChildren("paragraph");
    for(XML txt:texts) {
      textNodes = append(textNodes, txt.getContent());
    }
    paragaph = join(textNodes, "\n\n");

    nextHighlight();
    setPreviewWidth(500);
  }


  PShape findShape(PShape parent, String name) {

    for(int i = 0; i < parent.getChildCount(); i++) {
      PShape child = parent.getChild(i);
      
      if(child.getName().contains(name)) {
        return child;
      }
    }
    return null;  
  }

  void updateHighlight() {
    if(highlightTimer == -1) return;
    if(highlightTimer > millis()) return;

    int index = inputs.indexOf(highlightInput);
    index = (index + 1) % inputs.size();

    highlightInput = inputs.get(index);
    nextHighlight();
  }

  void nextHighlight(int duration) {
    highlightTimer = millis() + duration;
  }
  void nextHighlight() {
    nextHighlight(highlightDuration);
  }

  void stopHighlight() {
    highlightInput = null;
    highlightTimer = -1;
  }

  public void toggleGuide() {
    if(infoDisabled) return;
    closed = !closed;
    closedTime = millis();
    if(closed) {
      stopHighlight();
    } else {
      nextHighlight();
    }
  }

  void setFont(float scale, PGraphics pg) {
    pg.fill(255);
    pg.textFont(font);
    pg.textSize(rem(scale));
  }

  float easeInOutCubic(float t) {
    return t<.5 ? 4*t*t*t : (t-1)*(2*t-2)*(2*t-2)+1;
  }

  void setOpacity(float alpha) {
    previewAlpha = alpha;
  }

  void setPreviewPosition(float x, float y) {
    previewX = x;
    previewY = y;
  }

  void setPreviewWidth(float width) {
    previewWidth = width;
    float ratio = svgShape.width / svgShape.height;
    previewHeight = previewWidth / ratio;

    if(previewWidth != gPreview.width || previewHeight != gPreview.height) {
        gPreview = createGraphics(ceil(previewWidth), ceil(previewHeight));
    }
  }

  void update() {

    hasResized = false;
    if(width != pg.width || height != pg.height) {
      pg = createGraphics(width, height);
      hasResized = true;
    }

    closedAmt = easeInOutCubic(constrain(map(millis() - closedTime, 0, closedDuration, 0, 1), 0, 1));
    if(closed) closedAmt = 1 - closedAmt;
    isClosed = closedAmt == 0;
    float previewAmt = 1 - closedAmt;
    boolean previewOpen = previewAmt != 0;

    println(previewAmt);
    drawButtonOpen();

    if(previewOpen) {
      gPreview.beginDraw();
      gPreview.push();
      gPreview.clear();
      drawGamepad(gPreview, 0, 0, previewWidth);
      gPreview.pop();
      gPreview.endDraw();
      showImage(gPreview, previewX, previewY, lerp(0, previewAlpha, previewAmt));
    }

    if(isClosed) {
      // gPreview
      // gPreview.translate(width - svgShape.width/2, height/2);
      // drawGamepad(gPreview);
      // showImage(gPreview, 0, 0, lerp(0, 255, 1 - closedAmt));
      return;
    }

    info = "";

    updateHighlight();
    // if(closed) return;
    pg.beginDraw();
    pg.clear();
    pg.push();
    drawBackground();
    drawButtonClose();

    pg.translate(0, lerp(-100, 0, pow(closedAmt, 0.4)));
    drawText();
    
    pg.translate(width - svgShape.width, height/2 - svgShape.height/2);
    drawGamepad(pg, 0,0, svgShape.width);
    drawInfo(pg, svgShape.width/2, svgShape.height - rem(margin) * 2);

    pg.pop();
    pg.endDraw();

    showImage(pg, 0, 0, lerp(0, 255, closedAmt));
  }

  void showImage(PGraphics pg, float x, float y, float alpha) {
    push();
    tint(255, alpha);
    image(pg, x, y);
    pop();
  }

  void drawBackground() {
    push();
    rectMode(CORNER);
    noStroke();
    fill(50, lerp(0, 200, closedAmt));
    rect(0, 0, width, height);
    pop();
  }

  void drawButtonOpen() {
    if(infoDisabled) return;
    push();
    resetMatrix();
    stroke(128);
    noFill();
    strokeWeight(rem(0.1));
    translate(rem(margin) * 2, height - rem(margin) * 2);
    getMatrix();
    shape(guideShape, 0, 0);
    pop();
  }

  void drawButtonClose() {
    if(infoDisabled) return;
    pg.push();
    pg.strokeWeight(rem(0.1));
    pg.translate(rem(margin) * 2, height - rem(margin) * 2);
    pg.getMatrix();
    pg.shape(guideShape, 0, 0);
    setFont(1, pg);
    pg.textAlign(LEFT, CENTER);
    pg.translate(rem(margin) * 2, 0);
    pg.text(guideClose, 0, 0);
    pg.pop();
  }

  float rem(float scalar) {
    return fontSize * scalar;
  }

  void pushText(PGraphics pg, String txt, float maxWidth, float maxHeight) {
    pg.text(txt, 0, 0, maxWidth, maxHeight);
    pg.translate(0, pg.textAscent() + pg.textDescent() + rem(1));
  }

  void drawText() {
    float maxWidth = width - svgShape.width - rem(margin) * 2;
    
    pg.push();
    pg.textAlign(LEFT, TOP);
    pg.translate(rem(margin), rem(margin));
    // uppercase
    setFont(2, pg);
    pushText(pg, title.toUpperCase(), width, height);

    setFont(1, pg);
    pushText(pg, paragaph, maxWidth, height);

    pg.pop();
  }

  void drawInputs(PGraphics pg) {
    pg.push();

    for(PShape shape:allShapes.keySet()) {
      shape.resetMatrix();

      float posX = 0;
      float posY = 0;
      boolean pressed = false;
      boolean moving = false;
      boolean disabled = true;
      boolean highlight = false;
      pg.push();

      for(XML input:allShapes.get(shape)) {


        String key = input.getString("key");
        String name = input.getName();
        if(input == highlightInput) highlight = true;
        disabled = input.getInt("disabled") == 1;

        switch(name) {
          case INPUT_BUTTON:
          pressed = gpad.getButton(key).pressed();
          break;
          case INPUT_HAT:
          String hatPos = input.getString("pos");
          ControlHat hat = gpad.getHat(key);
          pressed = hatPos.contains(""+hat.getPos());
          break;
          case INPUT_SLIDER:
          ControlSlider slider = gpad.getSlider(key);
          float value = slider.getValue(); //-1 to 1

          if(highlight) {
            // value = sin(millis() * 0.005);
          }

          float start = input.getFloat("start");
          float end = input.getFloat("end");
          String way = input.getString("way");
          String[] ways = split(way, " ");
          float x = float(ways[0]);
          float y = float(ways[1]);
          float d = abs(start - end);

          float pos = map(value, -1, 1, start, end);
          if(abs(pos) > d * 0.1 && !highlight) {
            moving = true;
          }

          posX += x * pos;
          posY += y * pos;
          break;
        }

        if(pressed || moving || highlight) {
          info = input.getContent();

          if(!highlight) {
            stopHighlight();
            nextHighlight(3000);
          }
        }
      }
      
      if(!disabled) {
        pg.fill(255);
        pg.stroke(0);
      }
      
      pg.translate(posX, posY);
      if(pressed || highlight || moving) {
        pg.fill(highlightColor);
      }
      

      pg.shape(shape, 0, 0);
      pg.pop();

    }
    pg.pop();
  }

  void drawGamepad(PGraphics pg, float x, float y, float width) {

    pg.push();
    float scaleFactor = width / svgShape.width;
    pg.scale(scaleFactor, scaleFactor);
    pg.translate(x, y); 
    pg.strokeCap(ROUND);
    pg.strokeJoin(ROUND);
    pg.strokeWeight(rem(0.1) / scaleFactor);
    pg.noFill();
    pg.stroke(255);

    drawInputs(pg);
    pg.pop();
  }
  void drawInfo(PGraphics pg, float x, float y) {
    pg.push();
    setFont(1, pg);
    pg.textAlign(CENTER, TOP);
    pg.translate(x, y);
    float width = svgShape.width * 0.6;
    pg.text(info, -width/2, 0, width, height);
    pg.pop();
  }

}


void setup() {
  size(1920, 1080);
  surface.setResizable(true);
  guide = new Guide(this, "config.xml");
}
void draw() {
  background(0);
  ellipse(width/2, height/2, 100, 100);
  

  float pw = 500; // controller width
  guide.setPreviewPosition(width - pw, height - guide.previewHeight);
  guide.setPreviewWidth(pw);
  guide.setOpacity(128);
  guide.update();
}
