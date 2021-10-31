@echo off
setlocal enabledelayedexpansion

title !window-title! - Create backup
mode !window-size-width!, 10
color !window-color!

set "new-value="

set "result="
set error-level=0

:home (
  cls
  echo.
  call components\draw-title "Create backup"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  :home-location (
    call components\draw-input-errorlevel "Type the locations", !error-level!
    set /p "new-value="

    if "!new-value!" == "back" screens\settings\backup

    set new-value=!new-value:"=!

    if not exist "!new-value!\*" (
      set error-level=3
      goto :home-location
    )

    set error-level=0
  )

  call database\backup\create "!new-value!", result

  if !result! neq 0 (
    set error-level=!result!
    goto :home-location
  )

  exit
)
