@echo off

title %global-title% - Emulator location
mode %global-window-width%, 10
color %global-color%

set "error-level=f"

:home (
  cls
  echo.
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Your emulator location {0c}-{06}-{02}-", 4
  echo.
  call lib\draw-center-text "{0f}[{06}\.{0f}] Exit", 1
  echo.
  echo.

  :home-location (
    cecho  {0%error-level%}Type your emulator location:{0f} 
    set /p "user-emulator-location="

    if "%user-emulator-location%" == "\." exit
    if not exist "%user-emulator-location%" (
      set "error-level=c"
      goto :home-location
    )
  )

  echo %user-emulator-location%> "data\users\%user-name%\emulator-location.txt"
  exit
)
