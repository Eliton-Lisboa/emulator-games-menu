setlocal enabledelayedexpansion & : [user, game, &result]
  set "result=n"
  set "games-list="

  call database\get\games-not-accepted "%~1", games-list
  call lib\array-contains games-list, "%~2", result

(
  endlocal
  set "%~3=%result%"
  exit /b 0
)