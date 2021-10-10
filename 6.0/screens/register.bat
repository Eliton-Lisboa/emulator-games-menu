setlocal enabledelayedexpansion

set "user-name="
set "user-pass="
set "user-pass-repeat="

set "error-level=!global-color-font!"

:home (
  cls
  echo.
  call lib\draw-title "Console Games Menu"
  echo.
  call lib\draw "spreadsheet"
  echo.
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  call lib\draw-center-text "Type {&1&4}'name'{&0} to rewrite the name", 1
  call lib\draw-center-text "Type {&1&4}'pass'{&0} to rewrite the password", 1
  echo.

  :home-name (
    cecho  {!global-color-background!!error-level!}Type your name:{!global-color!} 
    set /p "user-name="

    if "!user-name!" == "back" screens\welcome

    if exist "data\users\!user-name!" (
      set "error-level=!global-color-error!"
      goto :home-name
    )

    set "error-level=!global-color-font!"
  )

  :home-pass (
    cecho  {!global-color-background!!error-level!}Type your password:{!global-color!} 

    if "!global-system-architecture!" == "x64" (
      editv64 -m -p "" user-pass
    ) else if "!global-system-architecture!" == "x86" (
      editv32 -m -p "" user-pass
    )

    if "!user-pass!" == "back" screens\welcome
    if "!user-pass!" == "name" goto :home-name

    if "!user-pass!" == "" (
      set "error-level=!global-color-error!"
      goto :home-pass
    )

    set "error-level=!global-color-font!"
  )

  :home-pass-repeat (
    cecho  {!global-color-background!!error-level!}Repeat your password:{!global-color!} 

    if "!global-system-architecture!" == "x64" (
      editv64 -m -p "" user-pass-repeat
    ) else if "!global-system-architecture!" == "x86" (
      editv32 -m -p "" user-pass-repeat
    )

    if "!user-pass-repeat!" == "back" screens\welcome
    if "!user-pass!" == "name" goto :home-name
    if "!user-pass!" == "pass" goto :home-pass

    if "!user-pass-repeat!" neq "!user-pass!" (
      set "error-level=!global-color-error!"
      goto :home-pass-repeat
    )
  )

  md "data\users\!user-name!"
  echo !user-pass!> "data\users\!user-name!\pass.txt"

  screens\list
)
