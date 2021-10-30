setlocal enabledelayedexpansion & : [name, string]
  set "new-value="
  set "questions="
  set index=0

  call lib\split-string "%~2", ";", questions

  echo. > "database\users\%~1\recovery-questions.txt"

  for %%x in (!questions!) do (
    set /a index+=1
    set "new-value="

    for /f "tokens=1,2 delims=:" %%a in (%%x) do (
      set new-value=%%a=%%b
    )

    echo !new-value!>> "database\users\%~1\recovery-questions.txt"
  )

(
  endlocal
  exit /b 0
)