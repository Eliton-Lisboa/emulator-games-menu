setlocal enabledelayedexpansion & : [text, change colors count]
	set "result=%~1"
	set add=0

	set result=!result:^&0=%window-color%!
	set result=!result:^&1=%window-color-background%!
	set result=!result:^&2=%window-color-font%!
	set result=!result:^&3=%window-color-error%!
	set result=!result:^&4=%window-color-warn%!
	set result=!result:^&5=%window-color-success%!

	call "%~dp0\center-text" "!result!", result
	set /a add=%~2 * 3 + 3

	for /l %%z in (0, 1, %add%) do (
		set "result= !result!"
	)

	cecho !result! {!window-color!} & echo.

(
	endlocal
	exit /b 0
)