@echo off
setlocal enabledelayedexpansion

title !window-title! - Change extensions not accepted
mode !window-size-width!,14
color !window-color!

set "games-not-accepted="

set "new-value="
set "result="
set error-level=0

:ini (
  call database\get\games-not-accepted "!user-name!", games-not-accepted
)

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  echo.
  echo.
  echo.
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  echo.

  :add-type (
    call components\draw-input-errorlevel "Type the game name", !error-level!
    set /p "new-value="

    set new-value=!new-value:"=!
    call lib\array-contains games-not-accepted, "!new-value!", result

    if "!new-value!" == "" goto :add-type
    if "!new-value!" == "back" screens\settings\change-games-not-accepted

    if "!result!" == "y" (
      set error-level=3
      goto :add-type
    )
  )

  call database\add\game-not-accepted "!user-name!", "!new-value!"

  goto :ini
)