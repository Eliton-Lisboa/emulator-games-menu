setlocal enabledelayedexpansion & : [string, item, &result]
  set "string=%~1"
  set "result=n"
  set "item="
  set string-length=0
  set item-length=0

  call lib\string-length "!string!", string-length
  call lib\string-length "%~2", item-length

  for /l %%x in (0, 1, !string-length!) do (
    set item=!string:~%%x,%item-length%!

    if "!item!" == "%~2" set "result=y"
  )

(
  endlocal
  set "%~3=%result%"
  exit /b 0
)