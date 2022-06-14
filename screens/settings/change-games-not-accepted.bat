@echo off
setlocal enabledelayedexpansion

title !window-title! - Change extensions not accepted
mode !window-size-width!,14
color !window-color!

set "menu="
set "menu-show="

set "result="
set "new-value="

:ini (
  set "menu="
  set "menu-show="

  call database\get\games-not-accepted "!user-name!", menu

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  if "!menu!" neq "" (
    set menu=!menu! ""
    set menu-show=!menu-show! ""
  )

  for %%x in ("Add a new game" "Back") do (
    call lib\center-text %%x, result
    set menu=!menu! %%x
    set menu-show=!menu-show! "!result!"
  )

)

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  echo.
  echo.
  echo.
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Back" (
    exit
  ) else if "!result!" == "Add a new game" (
    screens\settings\change-games-not-accepted\add
  ) else if "!result!" neq "" (
    start /wait /shared messages\confirm "Do you wanna remove this game: !result!?"

    set /p answer=< "temp\confirm.txt"

    if "!answer!" == "y" (
      call database\delete\game-not-accepted "!user-name!", !result!
      goto :ini
    )
  )

  goto :home
)
