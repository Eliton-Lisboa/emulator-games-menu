setlocal & : [&width, &height]
  set "height="
  set "width="

  for /f "usebackq tokens=2 delims=:" %%x in (`call mode ^| findstr Lines`) do ( set "height=%%x" )
  for /f "usebackq tokens=2 delims=:" %%x in (`call mode ^| findstr Columns`) do ( set "width=%%x" )

  for /f "tokens=1-2 delims= " %%a in ("%width% %height%") do (
    set "width=%%a"
    set "height=%%b"
  )

(
  endlocal
  if "%~1" neq "" set "%~1=%width%"
  if "%~2" neq "" set "%~2=%height%"
  exit /b 0
)