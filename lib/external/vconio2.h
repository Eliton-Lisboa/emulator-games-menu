#ifndef CONIO2_H
#define CONIO2_H

#include <iostream>
#include <string>
#include <stdio.h>
#include <windows.h>
#include <sstream>

using namespace std;

namespace vconio2 {
  struct {
    int lastColors;
  } conio2_vars;

  /*
    -- conversins
  */

  string inttostr(int number) {
    string res;
    stringstream ss;
    ss << number;
    ss >> res;
    return res;
  }

  int strtodec(string str) {
    int res;
    stringstream ss;
    ss << str;
    ss >> res;
    return res;
  }

  int strtohex(string code) {
    unsigned res;
    stringstream ss;
    ss << hex << code;
    ss >> res;
    return res;
  }

  int dectohex(int decimal) {
    unsigned res;
    stringstream ss;
    ss << hex << decimal;
    ss >> res;
    return res;
  }

  int hextodec(string code) {
    int res;
    stringstream ss;
    ss << hex << code;
    ss >> res;
    return res;
  }

  string hextostr(int code) {
    string res;
    stringstream ss;
    ss << hex << code;
    ss >> res;
    return res;
  }

  /*
    -- functions
  */

  class Buffer {
    COORD pos;
    COORD size;

    Buffer() {
      CONSOLE_SCREEN_BUFFER_INFO ScreenBufferInfos;
      GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &ScreenBufferInfos);

      pos = { 0, 0 };
      size = {
        short(ScreenBufferInfos.dwSize.X - pos.X),
        1
      };
    }

  };

  void cls() {
    system("cls");
  }

  void gotoxy(int x, int y) {
    SetConsoleCursorPosition(
      GetStdHandle(STD_OUTPUT_HANDLE),
      { short(x), short(y) }
    );
  }

  void cursorvsb(bool value) {
    CONSOLE_CURSOR_INFO CursorInfos;
    CursorInfos.dwSize = 100;
    CursorInfos.bVisible = value;
    SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), &CursorInfos);
  }

  void textcolor(unsigned hex, short fc = 0, short bgc = 0) {
    unsigned color = hex;

    if (hex == 0) color = fc + bgc * 16;

    SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color);
  }

  void printxy(string str, COORD pos) {
    CONSOLE_SCREEN_BUFFER_INFO ScreenBufferInfos;
    GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &ScreenBufferInfos);

    gotoxy(pos.X, pos.Y);
    cout << str;

    gotoxy(
      ScreenBufferInfos.dwCursorPosition.X,
      ScreenBufferInfos.dwCursorPosition.Y
    );
  }

  void cprintxy(string str, COORD pos, bool jmp = true, string bg = "colored") {
    string color = "";
    bool saveColor = false;
    bool safe = false;
    COORD nPos = pos;

    CONSOLE_SCREEN_BUFFER_INFO ScreenBufferInfos;
    GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &ScreenBufferInfos);

    string WindowColor = hextostr(dectohex(ScreenBufferInfos.wAttributes));

    if (WindowColor.length() == 1)
      WindowColor = "0" + WindowColor;

    for (int x = 0; x < str.length(); x++) {
      char ch = str[x];

      if (safe) {
        safe = false;
        nPos.X++;
        printxy({ ch }, nPos);
      }
      else {
        if (ch == '~') safe = true;
        else if (ch == '[') saveColor = true;
        else if (saveColor) {
          if (ch == ']') {
            saveColor = false;

            if (color == "") color = WindowColor;
            else if (color.length() == 1) color = WindowColor[0] + color;

            textcolor(strtohex(color));
            color = "";
          }
          else
            color += ch;
        }
        else {
          if (ch == ' ') {
            if (bg != "transparent")
              printxy({ ch }, nPos);
          }
          else
            printxy({ ch }, nPos);
          chPos++;
        }
      }
    }

    gotoxy(chPos, pos.Y);

    if (str[str.length() - 1] == ' ' && str[str.length() - 2] == ' ')
      cout << endl;

    textcolor(ScreenBufferInfos.wAttributes);

    if (jmp)
      gotoxy(ScreenBufferInfos.dwCursorPosition.X, ScreenBufferInfos.dwCursorPosition.Y);
  }

}

#endif