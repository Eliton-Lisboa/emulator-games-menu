@echo off
chcp 65001
mode 40,30
cls

echo [building...]
: g++ lisch\bs-compatibility.cpp -o lisch -std=c++0x
g++ vecho\main.cpp -o vecho -std=c++0x

echo [starting...]
: call lisch /type:select /format:table "Open" "Close" "" "Exit"

call vecho /end:pointer [4]Hola: 
echo ola
