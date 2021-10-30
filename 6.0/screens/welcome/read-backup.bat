@echo off
setlocal enabledelayedexpansion

title !window-title! - Read backup
mode !window-size-width!, 20
color !window-color!

set "menu="
set "menu-show="

set "backup-user-name="
set "backup-local="
set "check-list="
set "new-value="
set "if-or=n"
set index=0
set error-level=0

set "prop-name="
set "prop-value="

set "result="
set "result-index="

:ini (
  set "menu="
  set "menu-show="

  goto :home
)

:home (
  cls
  echo.
  call components\draw-title "Read backup"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  :home-location (
    call components\draw-input-errorlevel "Type the locations", !error-level!
    set /p "new-value="

    if "!new-value!" == "back" exit

    set new-value=!new-value:"=!
    set "if-or=n"

    if not exist "!new-value!" set "if-or=y"
    if "!new-value:~-11!" neq ".backup.ini" set "if-or=y"

    if "!if-or!" == "y" (
      set error-level=3
      goto :home-location
    ) else (
      set backup-local=!new-value!

      for /f "usebackq tokens=1,2 delims=^=" %%a in ("!backup-local!") do (
        if "%%a" == "user-name" set backup-user-name=%%b
      )

      if exist "database\users\!backup-user-name!\*" (
        start /wait /shared messages\message "This user already exists."
        set error-level=3
        goto :home-location
      ) else (
        call database\read-backup-new-user "!backup-local!"
        exit
      )

    )

  )

)
