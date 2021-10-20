@echo off & : [message]
setlocal enabledelayedexpansion

title !window-title! - Message
mode !window-size-width!, 10
color !window-color!

set "menu="
set "menu-show="

set "result="

:ini (
  set menu="Yes" "No"

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  echo n> "temp\confirm.txt"

  goto :home
)

:home (
  cls
  echo.
  call components\draw-title "Confirm"
  echo.
  echo  %~1
  echo.
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Yes" echo y> temp\confirm.txt
  if "!result!" == "No" echo n> temp\confirm.txt

  exit
)
