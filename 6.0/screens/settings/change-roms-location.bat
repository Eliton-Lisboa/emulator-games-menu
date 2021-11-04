@echo off
setlocal enabledelayedexpansion

title !window-title! - Change roms location
mode !window-size-width!,14
color !window-color!

set "menu="
set "menu-show="
set "item="

set "result="
set "new-value="
set error-level=0

(
  set "menu="
  set "menu-show="

  call database\get\shared-locations "roms", menu, menu-show

  for %%x in ("" "Write a new location" "Back") do (
    call lib\center-text %%x, result
    set menu=!menu! %%x
    set menu-show=!menu-show! "!result!"
  )

)

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  call lib\draw-center-text "{&1&5}!user-roms-location!", 1
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  echo.

  :home-type
  if "!result!" == "Back" (
    exit
  ) else if "!result!" == "Write a new location" (
    call components\draw-input-errorlevel "Type new roms location", !error-level!
    set /p "new-value="

    if "!new-value!" == "back" exit
    if exist "!new-value!\*" (
      call database\update\locations "!user-name!", "roms", "!new-value!"
      set user-roms-location=!new-value!

      exit
    ) else (
      set error-level=3
      goto :home-type
    )

  ) else if "!result!" neq "" (
    call database\update\locations "!user-name!", "roms", "!result!"
    set user-roms-location=!result!

    exit
  )

  goto :home
)
