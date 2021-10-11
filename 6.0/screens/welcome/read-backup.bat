@echo off
setlocal enabledelayedexpansion

title !global-title! - Read backup
mode !global-window-width!, 10
color !global-color!

set "error-level=!global-color-font!"
set "backup-user-name="

set "result="

:home (
  cls
  echo.
  call lib\draw-title "Read backup"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  :home-location (
    cecho {!global-color-background!!error-level!}Type the backup location:{!global-color!} 
    set /p "value="

    if "!value!" == "back" exit

    set value=!value:"=!

    if not exist "!value!" (
      set "error-level=!global-color-error!"
      goto :home-location
    ) else if "!value:~-11!" neq ".backup.ini" (
      set "error-level=!global-color-warn!"
      goto :home-location
    ) else (

      for /f "tokens=1,2 delims=^=" %%a in (!value!) do (
        if "%%a" == "user-name" set "backup-user-name=%%b"
      )

      if exist "data\users\!backup-user-name!\*" (
        set "error-level=!global-color-error!"
        goto :home-location
      ) else (
        md "data\users\!backup-user-name!"

        for /f "tokens=1,2 delims=^=" %%a in (!value!) do (
          if "%%a" neq "user-name" (
            echo %%b> "data\users\!backup-user-name!\%%a.ini"
          )
        )
      )

    )
  )

  exit
)
