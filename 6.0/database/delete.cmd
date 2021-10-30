setlocal enabledelayedexpansion & : [user, &result]
  set "result=y"
  set "answer="

  start /wait /shared messages\confirm-pass %~1

  set /p answer=< "temp\confirm-pass.txt"

  if "!answer!" == "y" (
    rd /s /q "database\users\%~1"

    start index
  )

(
  endlocal
  set "%~2=%result%"
  exit /b 0
)