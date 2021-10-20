setlocal enabledelayedexpansion & : [name, location]
  set location=%~2

  if "!location:~-1,1!" == "\" (
    set location=!location:~0,-1!
  )

  if exist "database\users\%~1\" (
    echo !location!> "database\users\%~1\emulator-location.txt"
  )

(
  endlocal
  exit /b 0
)