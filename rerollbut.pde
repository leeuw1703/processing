class roll {

  float posx, posy;
  int sizex, sizey;
  String name;
  int strsize;
  boolean selectable;
  boolean mouseisover;
  //int value = 0;
  button endturn;

  roll() {
    posx = 10;
    posy = 10;
    sizex = 78;
    sizey = 78;
    name = "Gooi";
    strsize = 28;
    selectable = true;
    mouseisover = false;
    endturn = new button(name, posx, posy, sizex, sizey, strsize);
  }

  boolean checkpressed() {
    if ((mouseX > posx) && (mouseX < posx + sizex) && (mouseY > posy) && (mouseY < posy + sizey) && selectable) {
      mouseisover = true;
      time = millis();
      a = 1;
      selectable = false;
      return true;
    } else {
      mouseisover = false;
      return false;
    }
  }

  void show() {
    endturn.display();
  }
}