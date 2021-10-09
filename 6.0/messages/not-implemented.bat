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
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Not implemented feature {0c}-{06}-{02}-", 4
  echo.
  echo.
  echo.
  echo.
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  exit
)
