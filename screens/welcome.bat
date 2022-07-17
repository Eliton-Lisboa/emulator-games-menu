setlocal enabledelayedexpansion

title !program-title! - Welcome

set menu="Login" "Register" "Read backup" "" "Exit"
set result=

(
  cls
  echo.
  call draw-title Welcome
  echo.
  call draw "montain"
  echo.

  lisch /format:list /type:select !menu!

  call get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Register" screens\register
  if "!result!" == "Login" screens\login
  if "!result!" == "Read backup" call screens\welcome\read-backup
  if "!result!" == "Exit" exit
)
