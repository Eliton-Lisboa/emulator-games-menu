@echo off
setlocal enabledelayedexpansion

title !global-title! - Change name
mode !global-window-width!, 10
color !global-color!

set "error-level=!global-color-font!"
set "new-value="

:home (
  cls
  echo.
  call lib\draw-title "Your name"
  echo.
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  echo.
  echo.

  :home-name (
    cecho  {0!error-level!}Type your new name:{0f} 
    set /p "new-value="

    if "!new-value!" == "back" exit

    if "!new-value!" == "!user-name!" (
      set "error-level=!global-color-warn!"
      goto :home-name
    )

    if exist "data\users\!new-value!" (
      set "error-level=!global-color-error!"
      goto :home-name
    )

  )

  ren "data\users\!user-name!" "!new-value!"

  start index
  exit
)
