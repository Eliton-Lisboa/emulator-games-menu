setlocal enabledelayedexpansion

set "result="

set "menu="
set "menu-show="

:ini (
  set "menu="
  set "menu-show="

  call lib\all-folder-dirs "data\users\", result

  if "!result!" neq "" (
    set menu="Login"
  )

  set menu=!menu! "Register" "" "Exit"

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Console Games Menu {0c}-{06}-{02}-", 4
  echo.
  call lib\draw "montain"
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector "!menu!", !errorlevel!, result

  if "!result:~1,-1!" == "Exit" exit
  if "!result:~1,-1!" == "Register" screens\register
  if "!result:~1,-1!" == "Login" screens\login

  goto :ini
)
