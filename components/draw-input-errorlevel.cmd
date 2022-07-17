setlocal enabledelayedexpansion & : [text, errorlevel]
  : 0 - normal
  : 1 - success
  : 2 - warn
  : 3 - error

  set "color=f"

  if %~2 == 1 set "color=2"
  if %~2 == 2 set "color=4"
  if %~2 == 3 set "color=c"

  vecho /end:pointer [!color!]%~1: 

(
  endlocal
  exit /b 0
)