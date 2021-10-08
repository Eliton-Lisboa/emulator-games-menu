@echo off

title %global-title% - Message
mode %global-window-width%, 10
color %global-color%

set "result1="
set "result2="

:home (
  cls
  echo.
  cecho  {0c}Error:{0f} Not found roms location! & echo.
  echo.
  echo.
  echo.
  echo.

  call lib\center-text "Open settings", result1
  call lib\center-text "Exit", result2

  cmdmenusel f880 "%result1%" "%result2%"

  if %errorlevel% == 1 (
    screens\settings\roms-location
  )

  exit
)
