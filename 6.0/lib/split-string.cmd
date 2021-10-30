setlocal enabledelayedexpansion & : [string, split char, &result]
  set string=%~1
  set "result="
  set "char="
  set length=0
  set index=0

  call lib\string-length "%~1", length
  set result="

  for /l %%x in (0, 1, !length!) do (
    set /a index+=1

    set char=!string:~%%x,1!

    if "!char!" == "%~2" (
      set result=!result!" "
    ) else (
      set result=!result!!char!
    )
  )

  set result=!result!"

(
  endlocal
  set "%~3=%result%"
  exit /b 0
)