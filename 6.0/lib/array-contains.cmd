setlocal enabledelayedexpansion & : [array, item, &result]
  set "result=n"

  for %%x in (!%~1!) do (
    if %%x == "%~2" set "result=y"
  )

(
  endlocal
  set "%~3=%result%"
  exit /b 0
)

