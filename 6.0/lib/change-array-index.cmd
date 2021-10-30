setlocal enabledelayedexpansion & : [array : ref, vector number, new value, &result]
	set "result="
	set index=0

  for %%x in (!%~1!) do (
    set /a index+=1

    if !index! == %~2 (
      set result=!result! %3
    ) else (
      set result=!result! %%x
    )
  )

(
	endlocal
	set "%~4=%result%"
	exit /b 0
)