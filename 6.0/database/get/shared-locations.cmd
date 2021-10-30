setlocal enabledelayedexpansion & : [location type, &result, &result to show]
  set "result="
  set "result-show="
  set "answer="

  for /f "tokens=*" %%x in ('dir /b "database\users"') do (

    if "%%x" neq "!user-name!" if exist "database\users\%%x\share-%~1-location.txt" (
      set /p answer=< "database\users\%%x\share-%~1-location.txt"

      if "!answer!" == "y" (
        set /p answer=< "database\users\%%x\%~1-location.txt"

        set result=!result! "!answer!"
        set result-show=!result-show! " %%x - !answer!"
      )
    )
  )

(
  endlocal
  set "%~2=%result%"
  set "%~3=%result-show%"
  exit /b 0
)