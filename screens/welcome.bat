setlocal enabledelayedexpansion

title !window-title! - Welcome

set "menu="
set "menu-show="

set "result="

(
  set menu="Login" "Register" "Read backup" "" "Exit"
  set "menu-show="

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

)

:home (
  cls
  echo.
  call components\draw-title "Welcome"
  echo.
  call lib\draw "montain"
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Register" screens\register
  if "!result!" == "Login" screens\login
  if "!result!" == "Read backup" call screens\welcome\read-backup
  if "!result!" == "Exit" exit

  goto :home
)
