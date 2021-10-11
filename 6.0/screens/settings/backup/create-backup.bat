@echo off
setlocal enabledelayedexpansion

title !global-title! - Create backup
mode !global-window-width!, 10
color !global-color!

set "value="

set "result="
set "error-level=f"

:home (
  cls
  echo.
  call lib\draw-title "Create backup"
  echo.
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  echo.
  echo.

  :home-location (
    cecho {!global-color-background!!error-level!}Type the locations:{!global-color!} 
    set /p "value="

    if "!value!" == "back" screens\settings\backup

    set value=!value:"=!

    if not exist "!value!\*" (
      set "error-level=!global-color-error!"
      goto :home-location
    ) else (
      set "error-level=!global-color-font!"

      if exist "!value!\console-games-menu-!user-name!.backup.txt" (
        set "error-level=!global-color-warn!"
        start /wait /shared messages\confirm "The file already exists, do you want to replace it?"

        set /p answer=<"temp\confirm.txt"
        if "!answer!" == "n" goto :home-location
      )
    )
  )

  echo user-name: !user-name!> "!value!\console-games-menu-!user-name!.backup.txt"

  call lib\all-folder-dirs "data\users\!user-name!", result

  for %%x in (!result!) do (
    set prop-name=%%x
    set prop-name=!prop-name:~1,-5!

    set /p prop-value=<"data\users\!user-name!\!prop-name!.txt"

    echo !prop-name!^=!prop-value!>> "!value!\console-games-menu-!user-name!.backup.ini"
  )

  exit
)
