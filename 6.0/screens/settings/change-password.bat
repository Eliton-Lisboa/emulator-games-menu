@echo off
setlocal enabledelayedexpansion

title !window-title! - Change password
mode !window-size-width!,13
color !window-color!

set "new-value="
set error-level=0

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  echo.
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  :home-location (
    call components\draw-input-errorlevel "Type new emulator location", !error-level!
    call components\type-password new-value

    if "!new-value!" == "back" exit
    call database\update\pass !user-name!, "!new-value!", result

    if "!result!" == "y" (
      exit
    ) else (
      set error-level=3
      goto :home-location
    )

  )

)
