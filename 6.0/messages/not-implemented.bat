@echo off
setlocal enabledelayedexpansion

title !global-title! - Message
mode !global-window-width!, 10
color !global-color!

set "menu-show="
set "result="

:ini (
  call lib\center-text "Back", result
  set menu-show="!result!"

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-title "Not implemented feature"
  echo.
  echo.
  echo.
  echo.
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  exit
)
