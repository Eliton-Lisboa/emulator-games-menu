setlocal enabledelayedexpansion & : [prop name, &result]
	set "result=no file"

  if not exist "configfile.ini" goto :done

  for /f "usebackq tokens=1,2 delims=^=" %%a in ("configfile.ini") do (
    if "%%a" == "%~1" set "result=%%b"
  )

  :done
(
	endlocal
	set "%~2=%result%"
	exit /b 0
)