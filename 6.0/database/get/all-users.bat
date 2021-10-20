setlocal enabledelayedexpansion & : [&result]
  set "result="

  for /f "tokens=*" %%x in ('dir /b "database\users\"') do (
    set result=!result! "%%x"
  )

(
  endlocal
  set "%~1=%result%"
  exit /b 0
)