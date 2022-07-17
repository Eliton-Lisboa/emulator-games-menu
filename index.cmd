:: Microsoft Windows CMD.exe version 10.0.19043.1288 ::

@echo off
setlocal enabledelayedexpansion


set "program-title=SNES Manager"

: error color = c
: warn color = 6
: success color = 2

set "path=%path%;lib\internal\;lib\external\"
set "path=%path%;components\"


title !window-title!
mode 60,30
color 0f


screens\welcome