class calculation { // stil needs order of operations check. //<>// //<>//

  int[] numbers = new int[3];
  char[] operators = new char[2];
  int result = 0;
  boolean ready=false;
  int numpos, oppos;
  String resultstr;

  calculation() {
    clearstuff();
  }

  void clearstuff() {
    for (int i = 0; i<numbers.length; i++) {
      numbers[i]=0;
    }
    for (int i = 0; i < operators.length; i++) {
      operators[i]='0';
    }
    numpos = 0;
    oppos = 0;
  }

  void addnumber(int x) {
    numbers[numpos] = x;
    numpos ++;
  }

  void addoperator(char a) {
    operators[oppos] = a;
    oppos ++;
    if (oppos >= operators.length) {
      oppos --; // NEEDS ERROR MESSAGE
    }
  }
  String getresultstring() {
    String temp = "";
    if (numbers[0] <0) { 
      return temp;
    }
    boolean num= true, opp = true;
    for (int i=0; i < 3; i++) {
      if (numbers[i]> 0) {
        temp = temp + numbers[i] + " ";
      } else { 
        num = false;
      }
      if (i < 2 && operators[i] != '0') { 
        temp = temp + operators[i] + " ";
      } else {
        opp = false;
      }      
      if (!num && !opp) { 
        return temp;
      }
    }
    return temp;
  }

  int getresult(int getresult) {
    int tempA = numbers[0];
    int tempB = numbers[1];
    int tempC = numbers[2];
    char oppA = operators[0];
    char oppB = operators[1];
    if (numpos == 0) {
      getresult = 0;
      return getresult;
    } else if (numpos == 1) {
      getresult = tempA;
      return getresult;
    } else if (numpos == 2) {
      getresult = checkoperator( tempA, oppA, tempB);
      return getresult;
    } else if (numpos == 3) {
      if ((oppB == 'x' || oppB == '\u00F7') && oppA != 'x' && oppA != '\u00F7') {
        tempB = checkoperator(tempB, oppB, tempC);
        tempA = checkoperator(tempA, oppA, tempB);
      } else {
        tempA = checkoperator(tempA, oppA, tempB);
        tempA = checkoperator(tempA, oppB, tempC);
      }
      getresult = tempA;
    }
    return getresult;
  }

  int checkoperator(int tempres, char ops, int num) {
    switch(ops) {
    case '+': 
      tempres += num;
      break;
    case '-' :
      tempres -= num;
      break;
    case 'x' :
      tempres *= num;      
      break;
    case '\u00F7':
      if (tempres % num == 0) {
        tempres /= num;
      } else {
        clearstuff();
        active.mistakebool=true;
        comment = "Deze som komt niet op een geheel getal uit. Probeer het nog een keer";
        commentbox.fillrect = color(255, 0, 0);
      }
      break;
    }
    return tempres;
  }

  void displayresultstr() {
    resultstr = getresultstring();
    if (active.winner) {
      resultstr= "winner";
      //set all buttons inactive (except restart and quit)
    }
    sumbox.text = resultstr;
  }
}