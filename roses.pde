// https://en.wikipedia.org/wiki/Rose_curve
int n = 3;
int d = 2;
int size = 200;
int n_points = 360;

Scrollbar scroll_n;
Scrollbar scroll_d;

void setup() {
  scroll_n = new Scrollbar(10, 30, 1, 11, "n", n, 400);
  scroll_n.is_int = true;
  scroll_d = new Scrollbar(10, 70, 1, 11, "d", d, 400);
  scroll_d.is_int = true;

  size(480, 640);
};

void draw() {
  background(0);

  scroll_n.update();
  scroll_n.display();
  scroll_d.update();
  scroll_d.display();

  // Set Origin to centre and flip y-axis
  scale(1, -1);
  translate(width / 2, -height / 2);

  // Draw Outline
  noFill();
  stroke(200, 200, 200);
  strokeWeight(1);
  beginShape();
  for (float theta = 0; theta <= 360; theta += 0.1) {
    float k = scroll_n.value / scroll_d.value;
    float r = size * cos(k * theta);
    float x = r * cos(theta);
    float y = r * sin(theta);
    vertex(x, y);
  }
  endShape();
};
