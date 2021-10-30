setlocal enabledelayedexpansion & : [text, &result]
	set add=0
	set length=0
	set "result="

	call lib\string-length "%~1", length

	set /a add=!window-size-width! / 2
	set /a add=!add! - !length! / 2
	set /a add=!add! - 2

	for /l %%z in (0, 1, !add!) do (
		set "result=!result! "
	)

	set "result=!result!%~1"

(
	endlocal
	set "%~2=%result%"
	exit /b 0
)