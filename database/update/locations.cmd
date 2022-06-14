setlocal enabledelayedexpansion & : [name, location name, location]
  set location=%~3

  if "!location:~-1,1!" == "\" (
    set location=!location:~0,-1!
  )

  if exist "database\users\%~1\*" (
    echo !location!> "database\users\%~1\%~2-location.txt"
  )

(
  endlocal
  exit /b 0
)