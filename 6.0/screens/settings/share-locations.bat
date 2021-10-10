@echo off
setlocal enabledelayedexpansion

title !global-title! - Share locations
mode !global-window-width!, 10
color !global-color!

set "menu="
set "result="
set "new-value="

:ini (
  set "menu="

  if not exist "data\users\!user-name!\share-emulator-location.txt" echo n> "data\users\!user-name!\share-emulator-location.txt"
  if not exist "data\users\!user-name!\share-roms-location.txt" echo n> "data\users\!user-name!\share-roms-location.txt"

  set /p user-share-emulator-location=<"data\users\!user-name!\share-emulator-location.txt"
  set /p user-share-roms-location=<"data\users\!user-name!\share-roms-location.txt"

  if "!user-share-emulator-location!" neq "y" if "!user-share-emulator-location!" neq "n" set "user-share-emulator-location=n"
  if "!user-share-roms-location!" neq "y" if "!user-share-roms-location!" neq "n" set "user-share-roms-location=n"

  call lib\center-text "Emulator location - !user-share-emulator-location!", result
  set menu="!result!"

  call lib\center-text "Roms location - !user-share-roms-location!", result
  set menu=!menu! "!result!"

  call lib\center-text "Back", result
  set menu=!menu! "" "!result!"

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-title "Share locations"
  echo.
  echo.
  echo.

  cmdmenusel f880 !menu!

  if !errorlevel! == 1 (
    set "new-value=y"
    if "!user-share-emulator-location!" == "y" set "new-value=n"

    echo !new-value!> "data\users\!user-name!\share-emulator-location.txt"
  )
  if !errorlevel! == 2 (
    set "new-value=y"
    if "!user-share-roms-location!" == "y" set "new-value=n"

    echo !new-value!> "data\users\!user-name!\share-roms-location.txt"
  )
  if !errorlevel! == 4 exit

  goto :ini
)
