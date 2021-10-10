@echo off
setlocal enabledelayedexpansion

title !global-title! - Confirm password
mode !global-window-width!, 10
color !global-color!

set "error-level=!global-color-font!"
set "value="

:ini (
  echo n> temp\confirm-password.txt

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-title "Confirm your password"
  echo.
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  echo.
  echo.

  :home-pass (
    cecho  {!global-color-background!!error-level!}Type your user password:{!global-color!} 

    if "!global-system-architecture!" == "x64" (
      editv64 -m -p "" value
    ) else if "!global-system-architecture!" == "x86" (
      editv32 -m -p "" value
    )

    if "!value!" == "back" exit

    if "!value!" neq "!user-pass!" (
      set "error-level=!global-color-error!"
      goto :home-pass
    ) else (
      echo y> temp\confirm-password.txt
    )
  )

  exit
)
