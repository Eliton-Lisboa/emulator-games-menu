@echo off
setlocal enabledelayedexpansion

set "global-title=Console Games Menu"
set "global-color-background=0"
set "global-color-font=f"
set "global-color=!global-color-background!!global-color-font!"
set global-window-width=60
set global-window-height=30
set "global-system-architecture=x64"

set "global-color-error=c"
set "global-color-warn=6"

if not exist "\Program Files (x86)" (
  set "global-system-architecture=x86"
)

title !global-title!
mode !global-window-width!, !global-window-height!
color !global-color!

screens\welcome
