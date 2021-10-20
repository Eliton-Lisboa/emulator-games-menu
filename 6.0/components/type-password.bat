setlocal enabledelayedexpansion & : [&result]
  set "result="

  if "!window-system-architecture!" == "x64" (
    editv64 -m -p "" result
  ) else if "!window-system-architecture!" == "x86" (
    editv32 -m -p "" result
  )

(
	endlocal
  set "%~1=%result%"
	exit /b 0
)

