setlocal enabledelayedexpansion & : [string, &result]
  set "result="
  set "str=%~1"
  set string-length=0
  set add=0

  call lib\string-length "%~1", string-length

  for /l %%x in (!string-length!, -1, 0) do (
    if !add! == 1 set result=!str:~%%x,1!!result!
    if "!str:~%%x,1!" == "." set add=1
  )

(
  endlocal
  set "%~2=%result%"
  exit /b 0
)