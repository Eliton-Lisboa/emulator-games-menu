@echo off

title %global-title% - Emulator location
mode %global-window-width%, 10
color %global-color%

set "error-level=f"
set "new-value="

:home (
  cls
  echo.
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Your emulator location {0c}-{06}-{02}-", 4
  call lib\draw-center-text "{06}%user-emulator-location%", 0
  echo.
  call lib\draw-center-text "{0f}[{06}\.{0f}] Exit", 1
  echo.
  echo.

  :home-location (
    cecho  {0%error-level%}Type your emulator location:{0f} 
    set /p "new-value="

    if "%new-value%" == "\." exit
    if not exist "%new-value%" (
      set "error-level=c"
      goto :home-location
    )

    if "%new-value%" == "%user-emulator-location%" (
      set "error-level=6"
      goto :home-location
    )
  )

  echo %new-value%> "data\users\%user-name%\emulator-location.txt"
  set "user-emulator-location=%new-value%"

  exit
)
