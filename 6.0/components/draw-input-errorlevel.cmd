setlocal enabledelayedexpansion & : [text, errorlevel]
  : 0 - normal
  : 1 - success
  : 2 - warn
  : 3 - error

  set "color=f"

  if %~2 == 1 set "color=!window-color-success!"
  if %~2 == 2 set "color=!window-color-warn!"
  if %~2 == 3 set "color=!window-color-error!"

  cecho  {!window-color-background!!color!}%~1:{!window-color!} 

(
  endlocal
  exit /b 0
)