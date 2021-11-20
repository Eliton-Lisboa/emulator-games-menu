:: Microsoft Windows CMD.exe version 10.0.19043.1288 ::

@echo off
setlocal enabledelayedexpansion

set "window-title=Console Games Menu"

set "window-size=60,30"
set window-size-width=60
set window-size-height=30
set "window-system-architecture=x86"

if exist "\Program Files (x86)" (
  set "window-system-architecture=x64"
)

set "window-color-background=0"
set "window-color-font=f"
set "window-color=!window-color-background!!window-color-font!"
set "window-color-error=c"
set "window-color-warn=6"
set "window-color-success=2"

set "window-libs-path=lib\"
set "window-components-path=components\"

title !window-title!
mode !window-size!
color !window-color!

screens\welcome
