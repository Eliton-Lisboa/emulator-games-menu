setlocal enabledelayedexpansion & : [name, string]
  set "questions="
  set "item="
  set index=0

  call lib\split-string "%~2", ";", questions

  echo. > "database\users\%~1\recovery-questions.txt"

  for %%x in (!questions!) do (
    set /a index+=1

    set item=%%x
    set item=!item:~1,-1!

    echo !item!>> "database\users\%~1\recovery-questions.txt"
  )

(
  endlocal
  exit /b 0
)