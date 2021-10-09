@echo off

title %global-title% - Change name
mode %global-window-width%, 10
color %global-color%

set "error-level=f"
set "new-value="

:home (
  cls
  echo.
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Your name {0c}-{06}-{02}-", 4
  echo.
  call lib\draw-center-text "{0f}[{06}\.{0f}] Back", 1
  echo.
  echo.

  :home-name (
    cecho  {0%error-level%}Type your new name:{0f} 
    set /p "new-value="

    if "%new-value%" == "\." exit
    if "%new-value%" == "%user-name%" (
      set "error-level=6"
      goto :home-name
    )

    if exist "data\users\%new-value%" (
      set "error-level=c"
      goto :home-name
    )

  )

  ren "data\users\%user-name%" "%new-value%"

  start index
  exit
)
