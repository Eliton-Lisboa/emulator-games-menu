setlocal enabledelayedexpansion & : [name, string]
  echo %~2> "database\users\%~1\recovery-questions.txt"

(
  endlocal
  exit /b 0
)