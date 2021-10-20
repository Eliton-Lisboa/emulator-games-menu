@echo off
setlocal enabledelayedexpansion

title !window-title! - Backup
mode !window-size-width!, 10
color !window-color!

set "menu="
set "menu-show="

set "result="

:ini (
  set menu="Create backup" "Read backup" "" "Back"
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
  call components\draw-title "Backup"
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Create backup" screens\settings\backup\create-backup
  if "!result!" == "Read backup" screens\settings\backup\read-backup
  if "!result!" == "Back" exit

  goto :home
)
