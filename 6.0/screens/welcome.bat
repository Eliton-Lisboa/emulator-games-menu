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

  set menu=!menu! "Register" "Read backup" "" "Exit"

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-title "Console Games Menu"
  echo.
  call lib\draw "montain"
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Register" screens\register
  if "!result!" == "Login" screens\login
  if "!result!" == "Read backup" start /wait /shared screens\welcome\read-backup
  if "!result!" == "Exit" exit

  goto :ini
)
