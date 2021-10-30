setlocal enabledelayedexpansion

title !window-title! - List

set "user-roms-location="
set "user-emulator-location="
set "menu="
set "menu-show="

set "result="
set "folder="

(
  call database\get\emulator-location "!user-name!", user-emulator-location
  call database\get\roms-location "!user-name!", user-roms-location
  call database\get\roms-location "!user-name!", folder

  if "!user-emulator-location!" == "" (
    start /wait /shared screens\settings\change-emulator-location

    call database\get\emulator-location "!user-name!", user-emulator-location
    if "!user-emulator-location!" == "" exit
  )

  if "!user-roms-location!" == "" (
    start /wait /shared screens\settings\change-roms-location

    call database\get\roms-location "!user-name!", user-roms-location
    call database\get\roms-location "!user-name!", folder
    if "!user-roms-location!" == "" exit
  )

)

:reload (
  set "menu="
  set "menu-show="

  for /f "tokens=*" %%x in ('dir /b "!folder!"') do (
    if exist "!folder!\%%x\*" (
      set menu=!menu! "%%x\\"

      call lib\center-text "%%x\\", result
      set menu-show=!menu-show! "!result!"
    )
  )

  for /f "tokens=*" %%x in ('dir /b "!folder!"') do (
    if not exist "!folder!\%%x\*" (
      set menu=!menu! "%%x"

      call lib\remove-extenssion "%%x", result
      call lib\center-text "!result!", result
      set menu-show=!menu-show! "!result!"
    )
  )

  for %%x in ("" "Settings") do (
    set menu=!menu! %%x

    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  if "!folder!" neq "!user-roms-location!" (
    set menu=!menu! "Go back"

    call lib\center-text "Go back", result
    set menu-show=!menu-show! "!result!"
  )

  for %%x in ("Back" "Exit") do (
    set menu=!menu! %%x

    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

)

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  echo.
  call lib\draw "controll"
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Settings" (
    start /wait /shared screens\settings

    set /p answer=< "temp\settings.txt"
    if "!answer!" == "exit" exit

    goto :reload
  )
  if "!result!" == "Go back" (
    call lib\go-back-folder "!folder!", folder
    goto :reload
  ) 
  if "!result!" == "Back" screens\welcome
  if "!result!" == "Exit" exit
  if "!result!" neq "" (

    if "!result:~-1,1!" == "\" (
      set "folder=!folder!\!result:~0,-2!"
    ) else (
      !user-emulator-location! "!folder!\!result!"
    )

  )

  goto :reload
)
