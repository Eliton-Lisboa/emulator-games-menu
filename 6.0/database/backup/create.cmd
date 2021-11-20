setlocal enabledelayedexpansion & : [local, &result in error level]
  set "file-path=%~1\console-games-menu-!user-name!.backup.ini"
  set result-error-level=0

  echo user-name^=!user-name!> "!file-path!"

  for /f "tokens=*" %%x in ('dir /b "database\users\!user-name!\"') do (
    set prop-name=%%x
    set prop-name=!prop-name:~0,-4!
    set "prop-value="

    for /f "usebackq tokens=*" %%y in ("database\users\!user-name!\%%x") do (
      set "prop-value=!prop-value!;%%y"
    )

    set prop-value=!prop-value:~1!

    echo !prop-name!=!prop-value!>> "!file-path!"
  )

  :end
(
  endlocal
  set "%~2=%result-error-level%"
  exit /b 0
)