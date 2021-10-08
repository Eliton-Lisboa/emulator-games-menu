setlocal enabledelayedexpansion & : [name]

	if exist "lib\drawings\%~1.txt" (
		echo.

		for /f "usebackq tokens=*" %%x in ("lib\drawings\%~1.txt") do (
			cecho %%x & echo.
		)

		echo.

		cecho {%global-color%}
	) else (
		set "result=Draw not found"
	)

(
	endlocal
	exit /b 0
)