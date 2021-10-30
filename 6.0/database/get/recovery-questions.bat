setlocal enabledelayedexpansion & : [name, &result]
  set "result="

  if exist "database\users\%~1\*" (
    set /p result=< "database\users\%~1\recovery-questions.txt"
  )

(
  endlocal
  set "%~2=%result%"
  exit /b 0
)