int __scrollbar_id = 0;
int __scrollbar_selected = 0;

class Scrollbar {
  // scrollbar
  float x;
  float y;
  float w;
  float h;

  // slider
  float x2;
  float y2;
  float w2;
  float h2;

  int id;
  boolean is_selected = false;
  float min;
  float max;
  float value;
  String label = "";

  boolean is_int = false;

  Scrollbar(float x, float y, float min, float max, String l) {
    this(x, y, min, max, l, min, max - min);
  }

  Scrollbar(float x, float y, float min, float max, String l, float v) {
    this(x, y, min, max, l, v, max - min);
  }

  Scrollbar(float x, float y, float min, float max, String l, float v, float w) {
    ++__scrollbar_id;
    this.id = __scrollbar_id;

    this.x = x;
    this.y = y;
    this.w = w;
    this.min = min;
    this.max = max;

    this.h = 8;
    this.value = constrain(v, min, max);
    this.label = l;

    this.w2 = this.h;
    this.h2 = this.h * 2;
    this.y2 = this.y - (this.h2/4);
    this.x2 = map(
      this.value,
      this.min, this.max,
      this.x, this.x + this.w - this.w2
    );
  }

  boolean isOverSlider() {
    return (
      mouseX > this.x &&
      mouseX < (this.x + this.w) &&
      mouseY > this.y &&
      mouseY < (this.y + this.h)
    );
  }

  void update() {
    if (mousePressed && isOverSlider() && (__scrollbar_selected == 0)) {
      is_selected = true;
      __scrollbar_selected = id;
    } else if (!mousePressed) {
      is_selected = false;
      __scrollbar_selected = 0;
    };

    if (is_selected && (__scrollbar_selected == id)) {
      this.x2 = constrain(mouseX - (this.w2/2), this.x, this.x + this.w - (this.w2));

      this.value = map(
        this.x2,
        this.x, this.x + this.w - this.w2,
        this.min, this.max
      );

      if (this.is_int) {
        this.value = round(this.value);

        this.x2 = map(
          this.value,
          this.min, this.max,
          this.x, this.x + this.w - this.w2
        );
      }
    }
  }

  void display() {
    // Draw Bar
    stroke(255);
    fill(100);
    rect(this.x, this.y, this.w, this.h, 8);

    // Draw Slider
    stroke(150);
    fill(200);
    rect(this.x2, this.y2, this.w2, this.h2, 4);

    // Draw Label
    textSize(16);
    text(this.label, this.x, this.y - 8);

    // Draw Value
    textSize(16);
    text(this.value, this.x + this.w + 8, this.y + this.h);
  }
}
