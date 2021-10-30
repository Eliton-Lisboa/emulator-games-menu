@echo off & : [message]
setlocal enabledelayedexpansion

title !window-title! - Message
mode !window-size-width!, 10
color !window-color!

set "menu="
set "menu-show="

set "result="

:ini (
  set menu="Ok"

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  goto :home
)

:home (
  cls
  echo.
  call components\draw-title "Message"
  echo.
  echo  %~1
  echo.
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  exit
)
