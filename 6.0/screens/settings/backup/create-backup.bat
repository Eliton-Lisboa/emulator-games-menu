@echo off
setlocal enabledelayedexpansion

title !window-title! - Create backup
mode !window-size-width!, 10
color !window-color!

set "answer="

set "result="
set "new-value="

:home (
  cls
  echo.
  call components\draw-title "Create backup"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  :home-location (
    start /wait /shared lib\file-selector "C:\Users", "y", "folder", ""
    set /p new-value=< "temp\file-selector.txt"

    if "!new-value!" == "exit" screens\settings\backup

    if exist "!new-value!\*" (
      start /wait /shared messages\confirm "The file already exists, do you wanna replace it?"
      set /p answer=< "temp\confirm.txt"

      if "!answer!" == "n" goto :home-location
    ) else (
      goto :home-location
    )
  )

  call database\backup\create "!new-value!", result

  if !result! neq 0 (
    set error-level=!result!
    goto :home-location
  )

  exit
)
