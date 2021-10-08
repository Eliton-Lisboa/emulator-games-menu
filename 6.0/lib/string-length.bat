setlocal & : [string, &result]
  set "string=%~1"
  set "result=0"

  :loop
  if "%string%" neq "" (
    set "string=%string:~1%"
    set /a result=%result% + 1
    goto :loop
  )

(
  endlocal
  set "%~2=%result%"
  exit /b 0
)