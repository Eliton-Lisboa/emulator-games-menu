setlocal enabledelayedexpansion & : [name, game name]
  set "result="

  : valid name
  if exist "database\users\%~1\*" (
    echo %~2>> "database\users\%~1\games-not-accepted.txt"
  )

(
  endlocal
  set "%~2=%result%"
  exit /b 0
)