setlocal enabledelayedexpansion & : [name, pass, &result]
  set "result=y"

  : verify name
  if not exist "database\users\%~1" (
    set "result=n"
    goto :end
  )

  : verify pass
  set /p tmp=< "database\users\%~1\pass.txt"

  if "!tmp!" neq "%~2" set "result=n"

  :end
(
  endlocal
  set "%~3=%result%"
  exit /b 0
)