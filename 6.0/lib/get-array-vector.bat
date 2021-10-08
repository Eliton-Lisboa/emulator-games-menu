setlocal enabledelayedexpansion & : [array, vector number, &result]
	set index=0
	set "result="

	for %%x in (%~1) do (
		set /a index=!index! + 1

		if "!index!" == "%~2" (
			set "result=%%x"
		)
	)

(
	endlocal
	set "%~3=%result%"
	exit /b 0
)