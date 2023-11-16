PShape shape;

void setup() {
  size(400, 400);

  PFont font = createFont("Arial", 96, true);
  shape = font.getShape('c');
}

void draw() {
  background(0);

  strokeWeight(2);
  stroke(255);
  noFill();
  translate(width/2, height/2);

  // distort the shape
  for (int i = 0; i < shape.getVertexCount(); i++) {
    PVector v = shape.getVertex(i);
    v.x += random(-1,1);
    v.y += random(-1,1);
    shape.setVertex(i, v.x,v.y);
  }

  // draw the shape
  beginShape();
  for (int i = 0; i < shape.getVertexCount(); i++) {
    PVector v = shape.getVertex(i);
    vertex(v.x,v.y);
  } 
  endShape(CLOSE);
}
