@echo off

set "global-title=Console Games Menu"
set global-color=0f
set global-window-width=60
set global-window-height=30

title %global-title%
mode %global-window-width%, %global-window-height%
color %global-color%

screens\welcome
