setlocal enabledelayedexpansion & : [user, &result]
  set "result="

  : valid name
  if exist "database\users\%~1\*" if exist "database\users\%~1\games-not-accepted.txt" (
    for /f "usebackq tokens=*" %%x in ("database\users\%~1\games-not-accepted.txt") do (
      set result=!result! "%%x"
    )
  )

(
  endlocal
  set "%~2=%result%"
  exit /b 0
)