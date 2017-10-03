class button {

  float posx, posy;
  int sizex, sizey;
  String name;
  int strsize;
  boolean state, mouseisover = false;
  char operator;
  int value = 0;

  button(String str, float x, float y, float s) {// big square button
    name = str;
    posx = x;
    posy = y;
    sizex = int(s);
    sizey = int(s);
    strsize = 32;
    state = true;
    operator = '0';
  }

  button( String str, float x, float y, float sx, float sy, int stsz) {// rectangle button
    name = str;
    posx = x;
    posy = y;
    sizex = int(sx);
    sizey = int(sy);
    strsize = stsz;
    state = true;
    operator = '0';
  }

  button( float x, float y, float s, char a, int stsz) {// operator
    name = "";
    posx = x;
    posy = y;
    sizex = int(s);
    sizey = int(s);
    strsize = stsz;
    state = false;
    operator = a;
  }

  void display() {
    color col;
    stroke(0);
    strokeWeight(2);
    if (state) {
      if (mouseisover) {
        col = color (0, 0, 200);
      } else {
        col = color(0, 0, 125);
      }
    } else { 
      col = color(125, 125, 125);
    }
    fill(col);
    rect(posx, posy, sizex, sizey, 10);
    textSize(strsize);
    textAlign(CENTER);
    fill(255); 
    if (operator == '0') {
      text(name, posx+sizex/2, posy+8+sizey/2);
    } else {  
      text(operator, posx+sizex/2, posy+18+sizey/2);
    }
  }

  boolean checkpressed() {
    if ((mouseX > posx) && (mouseX < posx + sizex) && (mouseY > posy) && (mouseY < posy + sizey) && state) {
      mouseisover = true;
      return true;
    } else {
      mouseisover = false;
      return false;
    }
  }

  void mempressed() {
    int res = 0;
    res = calc.getresult(res);
    butmem.value = res;
    butmem.selected= false;
    butmem.state = true;
    calc.clearstuff(); 
    activateoperators();
  }

  void equalpressed() {
    active.calcresult();
    butmem.value = 0;
    butmem.state = true;
    reset();
  }
}