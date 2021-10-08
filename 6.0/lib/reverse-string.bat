setlocal enabledelayedexpansion & : [string, &result]
	set "result="
  set string-length=0
  set "str=%~1"

  call lib\string-length "%~1", string-length

	for /l %%x in (!string-length!, -1, 0) do (
		set result=!result!!str:~%%x,1!
	)

(
	endlocal
	set "%~2=%result%"
	exit /b 0
)