setlocal enabledelayedexpansion
	: [array : ref, vector number, &result]
	set index=0
	set "result="

	for %%x in (!%~1!) do (
		if "!index!" == "%~2" (
			set "result=%%x"
		)

		set /a index=!index! + 1
	)
(
	endlocal
	set "%~3=%result%"
	exit /b 0
)