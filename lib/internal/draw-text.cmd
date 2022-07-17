setlocal enabledelayedexpansion & : [text]
	set "text=%~1"

	set text=!text:^&0=%window-color%!
	set text=!text:^&1=%window-color-background%!
	set text=!text:^&2=%window-color-font%!
	set text=!text:^&3=%window-color-error%!
	set text=!text:^&4=%window-color-warn%!
	set text=!text:^&5=%window-color-success%!

  cecho !text! {!window-color!} & echo.

(
	endlocal
	exit /b 0
)