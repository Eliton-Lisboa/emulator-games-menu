@echo off
setlocal enabledelayedexpansion

title !window-title! - Change emulator location
mode !window-size-width!,14
color !window-color!

set "menu="
set "menu-show="
set "item="

set "result="
set "new-value="

(
  set "menu="
  set "menu-show="

  call database\get\shared-locations "emulator", menu, menu-show

  for %%x in ("" "New location" "Back") do (
    call lib\center-text %%x, result
    set menu=!menu! %%x
    set menu-show=!menu-show! "!result!"
  )

)

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  call lib\draw-center-text "{&1&5}!user-emulator-location!", 1
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  echo.

  :home-select
  if "!result!" == "Back" (
    exit
  ) else if "!result!" == "New location" (
    start /wait /shared lib\file-selector "\Users", "y", "file", ".exe", "Select new emulator location"
    set /p new-value=< "temp\file-selector.txt"

    if "!new-value!" == "exit" exit

    call database\update\locations "!user-name!", "emulator", "!new-value!"
    set user-emulator-location=!new-value!

    exit
  ) else if "!result!" neq "" (
    call database\update\locations "!user-name!", "emulator", "!result!"
    set user-emulator-location=!result!

    exit
  )

  goto :home
)
