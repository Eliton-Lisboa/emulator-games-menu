@echo off
setlocal enabledelayedexpansion

title !window-title! - Settings
mode !window-size!
color !window-color!

set "result="
set "index="

:ini (
  set menu="Emulator location" "Roms location" "Change name" "Change password" "Share locations" "Recovery account" "Backup" "Delete account" "" "Back"
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
  call components\draw-title "Settings"
  echo.
  call lib\draw "settings"
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Emulator location" start /wait /shared screens\settings\change-emulator-location
  if "!result!" == "Roms location" start /wait /shared screens\settings\change-roms-location
  @REM if "!result!" == "Change name" (
  @REM   start /wait /shared screens\settings\change-name

  @REM   if not exist "data\users\!user-name!" exit
  @REM )
  if "!result!" == "Change password" (
    start /wait /shared messages\confirm-pass !user-name!

    set /p answer=< "temp\confirm-pass.txt"

    if "!answer!" == "y" (
      start /wait /shared screens\settings\change-password
    )
  )
  @REM if "!result!" == "Share locations" start /wait /shared screens\settings\share-locations
  if "!result!" == "Recovery account" start /wait /shared screens\settings\recovery
  if "!result!" == "Backup" start /wait /shared screens\settings\backup
  if "!result!" == "Delete account" (
    start /wait /shared messages\confirm-pass !user-name!

    set /p answer=< "temp\confirm-pass.txt"

    if "!answer!" == "y" (
      start /wait /shared /min database\delete !user-name!, result

      if "!result!" == "y" exit /b 1
    )
  )
  if "!result!" == "Back" exit

  goto :home
)
