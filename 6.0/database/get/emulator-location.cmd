setlocal enabledelayedexpansion & : [name, &result]
  set "result="

  : valid name
  if exist "database\users\%~1\*" if exist "database\users\%~1\emulator-location.txt" (
    set /p result=< "database\users\%~1\emulator-location.txt"
  )

(
  endlocal
  set "%~2=%result%"
  exit /b 0
)