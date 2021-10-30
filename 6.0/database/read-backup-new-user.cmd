setlocal enabledelayedexpansion & : [local]
  set "result="
  set "backup-user-name="

  for /f "usebackq tokens=1,2 delims=^=" %%a in ("%~1") do (
    echo ok - %%a

    if "%%a" == "user-name" (
      set backup-user-name=%%b
      md "database\users\!backup-user-name!"
    ) else if "!backup-user-name!" neq "" (
      call database\update\%%a !backup-user-name!, "%%b", result
    )

  )

(
  endlocal
  exit /b 0
)