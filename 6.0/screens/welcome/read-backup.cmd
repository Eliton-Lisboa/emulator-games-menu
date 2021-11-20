setlocal enabledelayedexpansion
  set "backup-user-name="

  :location (
    start /wait /shared lib\file-selector "C:\Users", "y", "file", ".backup.ini"
    set /p new-value=< "temp\file-selector.txt"

    if "!new-value!" == "exit" goto :done

    if exist "!new-value!" (
      for /f "usebackq tokens=1,2 delims=^=" %%a in ("!new-value!") do (
        if "%%a" == "user-name" set backup-user-name=%%b
      )

      if exist "database\users\!backup-user-name!\*" (
        start /wait /shared messages\message "This user already exists."
      ) else (
        call database\backup\read-new-user "!new-value!"
        exit
      )
    )

    goto :location
  )

  :done
(
  endlocal
  exit /b 0
)