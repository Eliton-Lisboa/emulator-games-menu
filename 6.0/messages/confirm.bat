@echo off

title %global-title% - Message
mode %global-window-width%, 10
color %global-color%

set "result1="
set "result2="

:ini (
  echo n> temp\confirm.txt

  goto :home
)

:home (
  cls
  echo.
  cecho  {06}Are you sure you want to do this? & echo.
  echo.
  echo.
  echo.
  echo.

  call lib\center-text "Yes", result1
  call lib\center-text "No", result2

  cmdmenusel f880 "%result1%" "%result2%"

  if %errorlevel% == 1 (
    echo y> temp\confirm.txt
  ) else if %errorlevel% == 2 (
    echo n> temp\confirm.txt
  )

  exit
)
