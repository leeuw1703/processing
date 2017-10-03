class textbox {

  int posx, posy, sizex, sizey;// position x and y value, and x- and y-size of box
  color fillrect, coltext; //color of background of box an of text in box
  int textsize; // size of text in box
  String text; // the text in the box
  int offsetx; // offset of the x-position of the text in the box
  int offsety; // offset of the y-position of the text in the box
  color strokecol; // color of the outline of the box
  int strokeweight; // thickness of the outline of the box
  char a; // alignment of the text in the box, 'c' for center, 'r' for right, otherwise left.

  textbox(int x, int y, int sx, int sy, color fr, color ct, int ts, String tx, int ox, int oy, color sc, int sw, char b) {
    posx = x;
    posy = y;
    sizex = sx;
    sizey= sy;
    fillrect = fr;
    coltext = ct;
    textsize = ts; 
    text = tx; 
    offsetx = ox; 
    offsety = oy;
    strokecol = sc;
    strokeweight = sw;
    a = b;
    
  }

  void show() {
    if (a == 'c') { 
      textAlign (CENTER, TOP);
    } else if (a == 'r') { 
      textAlign (RIGHT, TOP);
    } else { 
      textAlign (LEFT, TOP);
    }
    stroke(strokecol);
    strokeWeight(strokeweight);
    fill(fillrect);
    rect(posx, posy, sizex, sizey);
    fill(coltext);
    textSize(textsize);
    text(text, posx+offsetx, posy+offsety, sizex-offsetx, sizey-offsety);
  }
}