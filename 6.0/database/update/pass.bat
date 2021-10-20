setlocal enabledelayedexpansion & : [name, new pass, &result]
  set "result=y"
  set "tmp-result=y"
  set "tmp-user-pass=y"

  : valid
  call database\lib\valid-new-password "%~2", tmp-result
  if "!tmp-result!" == "n" (
    set "result=n"
    goto :end
  )

  echo %~2> "database\users\%~1\pass.txt"

  :end
(
  endlocal
  set "%~1=%result%"
  exit /b 0
)