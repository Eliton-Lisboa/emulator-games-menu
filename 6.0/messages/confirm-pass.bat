@echo off & : [user]
setlocal enabledelayedexpansion

title !window-title! - Message
mode !window-size-width!, 10
color !window-color!

set error-level=0
set "new-value="
set "result="

:ini (
  echo n> "temp\confirm-pass.txt"

  goto :home
)

:home (
  cls
  echo.
  call components\draw-title "Confirm password"
  echo.
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.

  :home-type (
    call components\draw-input-errorlevel "Type your password", !error-level!
    call components\type-password new-value

    if "!new-value!" == "back" exit

    call database\valid\login "%~1", "!new-value!", result

    if "!result!" == "y" (
      echo y> "temp\confirm-pass.txt"
    ) else (
      set error-level=3
      goto :home-type
    )
  )

  exit
)
