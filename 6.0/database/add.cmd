setlocal enabledelayedexpansion & : [name, password]
  md "database\users\%~1"
  echo %~2> "database\users\%~1\pass.txt"

(
  endlocal
  exit /b 0
)