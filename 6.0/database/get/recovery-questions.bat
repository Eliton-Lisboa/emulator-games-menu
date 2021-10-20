setlocal enabledelayedexpansion & : [name, &result]
  set "result="

  if exist "database\users\%~1\*" (
    for /f "usebackq tokens=*" %%x in ("database\users\%~1\recovery-questions.txt") do (
      set result=!result!=%%x
    )

  )

  set result=!result:~1!
(
  endlocal
  set "%~2=%result%"
  exit /b 0
)