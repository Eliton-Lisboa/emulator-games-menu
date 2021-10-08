@echo off

setlocal enabledelayedexpansion

title %global-title% - Settings
mode %global-window-width%, %global-window-height%
color %global-color%

set "result="

:ini (
  set menu="Emulator location" "Roms location" "Delete account" "" Exit
  set "menu-show="

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Settings {0c}-{06}-{02}-", 4
  echo.
  call lib\draw "settings"
  echo.

  cmdmenusel f880 !menu-show!

  : -> ""Emulator location" "" "Exit""
  : call lib\get-array-vector '!menu!', !errorlevel!, result

  if !errorlevel! == 1 (
    start /wait /shared screens\settings\emulator-location
  )
  if !errorlevel! == 2 (
    start /wait /shared screens\settings\roms-location
  )
  if !errorlevel! == 3 (
    start /wait /shared messages\confirm

    set /p answer=<"temp\confirm.txt"

    if "!answer!" == "y" (
      rd /s /q "data\users\%user-name%"

      start index
      exit
    )
  )
  if !errorlevel! == 5 exit

  goto :home
)
