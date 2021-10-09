setlocal enabledelayedexpansion & : [text, &result]
	set space_add=0
	set length=0
	set "result="

	call lib\string-length "%~1", length

	set /a space_add=!global-window-width! / 2
	set /a space_add=!space_add! - !length! / 2
	set /a space_add=!space_add! - 2

	for /l %%# in (0, 1, !space_add!) do (
		set "result=!result! "
	)

	set "result=!result!%~1"

(
	endlocal
	set "%~2=%result%"
	exit /b 0
)