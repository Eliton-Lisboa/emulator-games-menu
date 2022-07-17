setlocal enabledelayedexpansion
: [&result]
  set "result="
  editv64 -m -p "" result

(
	endlocal
  set "%~1=%result%"
	exit /b 0
)

