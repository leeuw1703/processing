class dice { 
  float posx, posy;
  int value;
  boolean state, selected;
  int size = 80;
  boolean[] eyes = new boolean[7];
  int strsize;
  color col; //255 for active;  125 for inactive; 175 for selected

  dice(float x, float y, int val) {
    posx = x;
    posy = y;
    value = val;
    for (int i = 0; i < eyes.length; i++) {
      eyes[i] = false;
    }
    state = true;
    selected = false;
  }

  dice(float x, float y) { // memwindow
    posx = x;
    posy = y;
    value = -1;
    state = true;
    selected = true;
    strsize = 76;
  }

  boolean checkpressed() {
    return (mouseX > posx) && (mouseX < posx + size) && (mouseY > posy) && (mouseY < posy + size) && !selected && state;
  }

  void checkfill() {
    if (state) {
      if (selected) {
        col = color(50);
      } else { 
        col= color(255);
      }
    } else { 
      col = color(125);
    }
  }

  void dicereset() {
    if (!endturn.state) {
      value= floor(random(6));
    }
    state=true;
    selected = false;
  }

  void butmemreset() {
    state=true;
    selected = true;
    value=-1;
  }

  void butshow() {
    checkfill();
    stroke(0);
    strokeWeight(2);
    fill(col);
    rect(posx, posy, size, size, 10);
    textSize(strsize);
    textAlign(CENTER);
    fill(0); 
    if (value > 0) {
      text(value, posx+size/2, posy+26+size/2);
    }
  }

  void show() {
    checkfill();
    fill(col);
    stroke(0);
    strokeWeight(2);
    rect (posx, posy, size, size, 10);
    fill (0);
    noStroke();
    ellipseMode(CENTER);
    int esize=16;
    int x1= 16, x2 = 40, x3 = 64;
    if (value >= 3) { 
      ellipse(posx+x1, posy+x1, esize, esize);
       ellipse(posx+x3, posy+x3, esize, esize);
    } //left top eye and right bottom eye
    if (value >= 1) { 
      ellipse(posx+x3, posy+x1, esize, esize);
       ellipse(posx+x1, posy+x3, esize, esize);
    } // rigth top eye and left bottom eye
    if (value == 5) { 
      ellipse(posx+x1, posy+x2, esize, esize);
       ellipse(posx+x3, posy+x2, esize, esize);
    } // left middle row eye and rigth middle row eye
    if (value%2 == 0) { 
      ellipse(posx+x2, posy+x2, esize, esize);
    } // center eye
  }
}