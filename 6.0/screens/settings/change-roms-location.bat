@echo off
setlocal enabledelayedexpansion

title !window-title! - Change roms location
mode !window-size-width!,13
color !window-color!

set "new-value="
set error-level=0

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  call lib\draw-center-text "{&1&5}!user-roms-location!", 1
  echo.
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  echo.
  echo.

  :home-location (
    call components\draw-input-errorlevel "Type new roms location", !error-level!
    set /p "new-value="

    if "!new-value!" == "back" exit
    if exist "!new-value!\*" (
      call database\update\roms-location "!user-name!", "!new-value!"
      set user-roms-location=!new-value!

      exit
    ) else (
      set error-level=3
      goto :home-location
    )

  )

)
