/* three dice 1 to 16 game by Lars Wilms //<>// //<>// //<>// //<>//
Roll six-sided dice and try to make the numbers 1 to 16 in sequence using simple math(s) (+ - * /) and the values on the dice.
 **/
/* to do list:
 quit button unicode for power is not availible: draw yourself use arc and line
 play against computer??? AI
 win animation also block endturn- and resetbutton and dice and operators, only restart and end button active
 message errors
 score? correct answers are points; mistakes cost points, dice rolls cost points, time cost points. depending on level
 next roll, first other players get oppertunity to make the goal of current player with current dice. if they can scoreboard of current players starts over at 1.
 ...
 */


// initialise playbuttons
button endturn = new button ("Gooi", 10, 10, 78, 78, 28);
button butreset = new button ("Oeps", 10, 100, 78, 78, 27);
button restart = new button ("\u21BA", 10, 190, 78, 78, 60);
button quit = new button ("\u23FB", 700, 10, 50, 50, 30);
dice butmem = new dice (370, 10);
//initialise operator buttons
button opplus = new button (150, 120, 50, '+', 65);
button opminus = new button(220, 120, 50, '-', 70);
button opmult = new button(290, 120, 50, 'x', 65);
button opdiv = new button(360, 120, 50, '\u00F7', 65);
button opqual = new button(220, 190, 50, '=', 65);
button opmem = new button(290, 190, 50, 'M', 50);
//initilise dice
dice d1= new dice(100, 10, floor(random(6)));
dice d2= new dice(190, 10, floor(random(6)));
dice d3= new dice(280, 10, floor(random(6)));
//initialise textboxes
textbox sumbox = new textbox (10, 280, 400, 36, color(250, 250, 0), color(0), 25, "", 10, 3, color(0), 2, 'c');
textbox turnbox = new textbox (470, 280, 280, 36, color(250, 250, 0), color(0), 25, "", 10, 3, color(0), 2, 'l');
textbox commentbox = new textbox (10, 320, 780, 70, color(250, 250, 0), color(0), 18, "", 10, 5, color(0), 2, 'l');
//initialise gameplay
calculation calc = new calculation();
player players[] = {new player("Speler 1"), new player("Speler 2")};
player active= new player("");
String comment = "";
int turn = 1, a=1;
int time, time1;
int playernumber = 0;
final int pointscorrect = 100; // number of points for correct answer
final int pointswrong = -30; // number of points for incorrect answer
final int pointsreset = -10; //number of points for reset button use
final int pointsroll = -5; //number of points for reroll of dice
final int pointstime = -1; //number of points for each second of play
final String standardtext = ("Gebruik de dobbelstenen en de +, -, x en " + '\u00F7' + " om het rode cijfer te maken. Je mag elke dobbelsteen maar een keer gebruiken, maar je hoeft ze niet allemaal te gebruiken. ");

void setup() {
  size (800, 400);
  active= players[playernumber];
  comment = standardtext;
}

void draw() { 
  background(50);
  time1 = int(time + sq(a) * 2);// dice roll
  if (!endturn.state && millis() > time1) {
    d1.dicereset();
    d2.dicereset();
    d3.dicereset();
    a++;
    if (a>30) {
      reset();
      a=0;
    }
  } // end dice roll
  show(); // buttons and dice
  mouseover();// check mouseover on reset and next turn buttons
  calc.displayresultstr(); //sum result rectangle
  active.displayscoreboard(); //score 1 to 16 and name of active player
}

void mousePressed() {
  if (endturn.checkpressed()) {
    endturn.state = false;
    time = millis();
    a = 1;
  } else if (butreset.checkpressed()) {
    reset();
  } else if (butmem.checkpressed()) {
    butmem.state = false;
    calc.addnumber(butmem.value);
    activateoperators();
  } else if (opplus.checkpressed()) {
    calc.addoperator('+'); 
    activateoperators();
  } else if (opminus.checkpressed()) {
    calc.addoperator('-');
    activateoperators();
  } else if (opmult.checkpressed()) {
    calc.addoperator('x');
    activateoperators();
  } else if (opdiv.checkpressed()) {
    calc.addoperator('\u00F7');
    activateoperators();
  } else if (opqual.checkpressed()) {
    opqual.equalpressed();
  } else if (opmem.checkpressed()) {
    opmem.mempressed();
  } else if (restart.checkpressed()) {
    restart();
  } else if (quit.checkpressed()) {
    exit();
  } else if (d1.checkpressed()) {
    d1.selected = true;
    calc.addnumber(d1.value+1);
    d1.checkfill();
    activateoperators();
  } else if (d2.checkpressed()) {
    d2.selected = true;
    calc.addnumber(d2.value+1);
    d2.checkfill();
    activateoperators();
  } else if (d3.checkpressed()) {
    d3.selected = true;
    calc.addnumber(d3.value+1);
    d3.checkfill();
    activateoperators();
  }
}
void mouseover() {
  endturn.checkpressed();
  butreset.checkpressed();
  restart.checkpressed();
  quit.checkpressed();
}

void restart() {
  background(50);
  playernumber = players.length;
  for (int i = 0; i < players.length; i++) {
    players[i].resetscore();
  }
  calc.resultstr = "";
  endturn.state = false;
  turn =1;
  a=1;
  time = millis();
}


void reset() {
  d1.dicereset();
  d2.dicereset();
  d3.dicereset();
  if (!endturn.state) {     
    endturn.state= true;
    playernumber ++;
    if (playernumber >= players.length) {
      playernumber = 0;
      turn ++;
    }
    active= players[playernumber];
    comment= standardtext;
    commentbox.fillrect = color(255,255,0);
  }
  butmem.butmemreset();
  opplus.state = false;
  opminus.state = false;
  opmult.state = false;
  opdiv.state = false;
  opqual.state = false;
  opmem.state = false;
  calc.clearstuff();
}

void show() {
  endturn.display();
  butreset.display();
  restart.display();
  quit.display();
  butmem.butshow();
  opplus.display();
  opminus.display();
  opmult.display();
  opdiv.display();
  opqual.display();
  opmem.display();
  d1.show();
  d2.show();
  d3.show();
  turnbox.text = ("Turn: " + turn + ". Mistake: " + active.mistake);
  turnbox.show();
  sumbox.show();
  active.namebox.show();
  commentbox.text = comment;
  commentbox.show();
}

void activateoperators() {
  opplus.state = !opplus.state;
  opminus.state = !opminus.state;
  opmult.state = !opmult.state;
  opdiv.state = !opdiv.state;
  opqual.state = !opqual.state;
  opmem.state = !opmem.state;
  d1.state = !d1.state;
  d2.state = !d2.state;
  d3.state = !d3.state;
}