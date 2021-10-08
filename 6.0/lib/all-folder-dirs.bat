setlocal enabledelayedexpansion & : [dir, &result]
	set "result="

  for /f "tokens=*" %%x in ('dir /b "%~1"') do (
    set result=!result! "%%x"
  )

(
	endlocal
	set "%~2=%result%"
	exit /b 0
)