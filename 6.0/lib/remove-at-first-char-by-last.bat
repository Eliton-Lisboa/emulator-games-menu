setlocal enabledelayedexpansion & : [string, char, &result]
  set "result="
  set string-length=0
  set add=0

  call lib\string-length "%~1", string-length

  for /l %%x in (!string-length!, -1, 0) do (
    set "str=%~1"

    if !add! == 1 (
      set result=!result!!str:~%%x,1!
    )

    if "!str:~%%x,1!" == "%~2" set add=1
  )

  call lib\reverse-string "!result!", result

(
  endlocal
  set "%~3=%result%"
  exit /b 0
)