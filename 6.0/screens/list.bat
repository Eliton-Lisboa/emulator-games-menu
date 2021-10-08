
set "user-emulator-location="
set "user-roms-location="

set "result="

:ini (
  set "menu="
  set "menu-show="

  if exist "data\users\%user-name%\emulator-location.txt" (
    set /p user-emulator-location=<"data\users\%user-name%\emulator-location.txt"
  ) else (
    start /wait /shared screens\settings\emulator-location

    if exist "data\users\%user-name%\emulator-location.txt" (
      set /p user-emulator-location=<"data\users\%user-name%\emulator-location.txt"
    ) else exit
  )

  if exist "data\users\%user-name%\roms-location.txt" (
    set /p user-roms-location=<"data\users\%user-name%\roms-location.txt"
  ) else (
    start /wait /shared screens\settings\roms-location

    if exist "data\users\%user-name%\roms-location.txt" (
      set /p user-roms-location=<"data\users\%user-name%\roms-location.txt"
    ) else exit
  )

  for /f "tokens=*" %%x in ('dir /b "%user-roms-location%"') do (
    set menu=!menu! "%%x"

    call lib\remove-at-first-char-by-last "%%x", ".", result
    call lib\center-text "!result!", result
    set menu-show=!menu-show! "!result!"
  )

  for %%x in ("" Settings Back Exit) do (
    set menu=!menu! "%%x"
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

)

:home (
  cls
  echo.
  call lib\draw "controll"
  echo.

  cmdmenusel f880 %menu-show%

  set index=0
	set "result="

	for %%x in (!menu!) do (
		set /a index=!index! + 1

		if "!index!" == "!errorlevel!" (
      set "result=%%x"
		)
	)
  set result=!result:~1,-1!

  if "!result!" == "Settings" (
    start /wait /shared screens\settings

    if not exist "data\users\%user-name%" exit
  ) else if "!result!" == "Back" (
    start index
    exit
  ) else if "!result!" == "Exit" (
    exit
  ) else if !result! neq "" (
    !user-emulator-location! "!user-roms-location!\!result!"
  )

  goto :home
)
