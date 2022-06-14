setlocal enabledelayedexpansion & : [name]

	if exist "%~dp0\drawings\%~1.txt" (
		echo.

		for /f "usebackq tokens=*" %%x in ("%~dp0\drawings\%~1.txt") do (
			set value=%%x

			set value=!value:^&0=%window-color%!
			set value=!value:^&1=%window-color-background%!
			set value=!value:^&2=%window-color-font%!
			set value=!value:^&3=%window-color-error%!
			set value=!value:^&4=%window-color-warn%!
			set value=!value:^&5=%window-color-success%!

			cecho !value! & echo.
		)

		echo.

		cecho {!window-color!}
	) else (
		call "%~dp0\draw-center-text" "{&1&3}Draw not found", 1
	)

(
	endlocal
	exit /b 0
)