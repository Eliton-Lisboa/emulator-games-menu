setlocal enabledelayedexpansion & : [local, &result in error level]
  set "file-path=%~1\console-games-menu-!user-name!.backup.ini"
  set result-error-level=0

  if exist "!file-path!" (
    start /wait /shared messages\confirm "The file already exists, do you wanna replace it?"

    set /p answer=< "temp\confirm.txt"
    if "!answer!" == "n" (
      set result-error-level=2
      goto :end
    )
  )

  echo user-name^=!user-name!> "!file-path!"

  for /f "tokens=*" %%x in ('dir /b "database\users\!user-name!\"') do (
    set prop-name=%%x
    set prop-name=!prop-name:~0,-4!
    set "prop-value="

    for /f "usebackq tokens=*" %%y in ("database\users\!user-name!\%%x") do (
      set "prop-value=!prop-value!;%%y"
    )

    echo !prop-name!:!prop-value:~1!>> "!file-path!"
  )

  :end
(
  endlocal
  set "%~2=%result-error-level%"
  exit /b 0
)