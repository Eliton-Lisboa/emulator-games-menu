setlocal enabledelayedexpansion & : [name, location name, new value]
  if exist "database\users\%~1\*" (
    echo %~3> "database\users\%~1\share-%~2-location.txt"
  )

(
  endlocal
  exit /b 0
)