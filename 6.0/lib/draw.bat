setlocal enabledelayedexpansion & : [name]

	if exist "lib\drawings\%~1.txt" (
		echo.

		for /f "usebackq tokens=*" %%x in ("lib\drawings\%~1.txt") do (
			set value=%%x

			set value=!value:^&0=%global-color%!
			set value=!value:^&1=%global-color-background%!
			set value=!value:^&2=%global-color-font%!
			set value=!value:^&3=%global-color-error%!
			set value=!value:^&4=%global-color-warn%!

			cecho !value! & echo.
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