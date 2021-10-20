setlocal enabledelayedexpansion & : [name, question1, answer1, question2, answer2, question3, answer3]
  echo %~2=%~3> "database\users\%~1\recovery-questions.txt"
  echo %~4=%~5>> "database\users\%~1\recovery-questions.txt"
  echo %~6=%~7>> "database\users\%~1\recovery-questions.txt"

(
  endlocal
  exit /b 0
)