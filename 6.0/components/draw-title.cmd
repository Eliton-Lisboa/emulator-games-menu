setlocal enabledelayedexpansion & : [text]
	call !window-libs-path!\draw-center-text "{&1&3}-{&1&4}-{&1&5}-{&1&2} %~1 {&1&3}-{&1&4}-{&1&5}-", 4

(
	endlocal
	exit /b 0
)