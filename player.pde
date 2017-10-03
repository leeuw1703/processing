class player {

  boolean[] scoreboard = new boolean[16];
  String name;
  int goal, mistake;
  boolean winner = false, mistakebool = false;
  float score;
  textbox scoreboardnum = new textbox(0, 0, 50, 50, color(0), color(255), 35, "", 1, 5, color(0), 1, 'c');
  textbox namebox = new textbox (0, 0, 208, 31, color(250, 250, 0), color(0), 25, "", 10, 0, color(0), 2, 'c');


  player (String n) {
    name = n;
    resetscore();
  }

  void resetscore() {
    for (int i =0; i<scoreboard.length; i++) {
      scoreboard[i]=false;
    }
    mistake = 0;
    winner = false;
    goal = 1;
    score=0;
  }

  void displayscoreboard() {
    int startx = 470, startyplayer = 10, startyboard = startyplayer + 40;
    color col;
    String str = "" + name;
    namebox.posx = startx;
    namebox.posy = startyplayer;
    namebox.text = str;
    for (int i = 0; i < scoreboard.length; i++) { // block of 1 to 16
      if (scoreboard[i]) {
        col= color(25, 25, 25); // red color still to do
      } else { 
        col = color (255, 0, 0);// black are done
      }
      if (i == goal-1) { 
        col = color(0, 255, 0); // green for current goal
      }
      str = "" + (i+1);
      scoreboardnum.posx = (startx + (i%4)*52);
      scoreboardnum.posy = (startyboard + floor(i/4)*52);
      scoreboardnum.fillrect = col;
      scoreboardnum.text = str;
      scoreboardnum.show();
    }
    //textbox score
  }

  void calcresult() {
    int res = 0;
    res = calc.getresult(res);
    if (res == goal) {
      scoreboard[goal - 1]= true;
      goal ++;
      score += pointscorrect;
      if (goal > 16) { 
        winner = true;
      }
    } else {
      mistakebool = true;
    }
    if (mistakebool) {
      mistake ++;
        if (mistake >2) {
        mistake = 0;        
        endturn.state = false;
        a = 10;
        time = millis();
      }
      score += pointswrong;
      mistakebool = false;
    }
  }
}