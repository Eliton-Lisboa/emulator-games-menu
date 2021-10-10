@echo off
setlocal enabledelayedexpansion

title !global-title! - Change password
mode !global-window-width!, 10
color !global-color!

set "error-level=f"
set "new-value="

:home (
  cls
  echo.
  call lib\draw-title "Your password"
  echo.
  call lib\draw-center-text "Type {06}'back'{!global-color!} to go back", 1
  echo.
  echo.

  :home-pass (
    cecho  {0!error-level!}Type your new password:{!global-color!} 

    if "!global-system-architecture!" == "x64" (
      editv64 -m -p "" new-value
    ) else if "!global-system-architecture!" == "x86" (
      editv32 -m -p "" new-value
    )

    if "!new-value!" == "back" exit

    if "!new-value!" == "!user-pass!" (
      set "error-level=c"
      goto :home-pass
    )
  )

  echo !new-value!> "data\users\!user-name!\pass.txt"
  set "user-pass=!new-value!"

  exit
)
