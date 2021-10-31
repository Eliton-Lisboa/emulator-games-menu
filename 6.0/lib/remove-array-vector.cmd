setlocal enabledelayedexpansion & : [array : ref, item, &result]
	set "result="

  for %%x in (!%~1!) do (
    if %%x neq %2 set result=!result! %%x
  )


(
	endlocal
	set "%~3=%result%"
	exit /b 0
)