setlocal enabledelayedexpansion
: [name]

	if exist "%~dp0\drawings\%~1.txt" (
		echo.

		for /f "usebackq tokens=*" %%x in ("%~dp0\drawings\%~1.txt") do (
			vecho %%x  
		)

		echo.
	) else (
		call "%~dp0\draw-center-text" "{&1&3}Draw not found", 1
	)

(
	endlocal
	exit /b 0
)