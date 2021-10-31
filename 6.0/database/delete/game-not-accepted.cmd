setlocal enabledelayedexpansion & : [user, game]
  set "games-list="
  set "item="

  call database\get\games-not-accepted "%~1", games-list
  call lib\remove-array-vector games-list, "%~2", games-list

  echo.> "database\users\%~1\games-not-accepted.txt"

  for %%x in (!games-list!) do (
    set item=%%x
    set item=!item:~1,-1!

    echo !item!>> "database\users\%~1\games-not-accepted.txt"
  )

(
  endlocal
  exit /b 0
)