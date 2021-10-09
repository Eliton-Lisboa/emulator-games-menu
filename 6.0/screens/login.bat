
set "user-name="
set "user-pass="
set "user-pass-repeat="
set "user-pass-original="

set "error-level=f"
set "menu="
set "menu-show="
set "result="

:ini (
  call lib\all-folder-dirs "data\users\", menu
  set menu=!menu! Back

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Console Games Menu {0c}-{06}-{02}-", 4
  echo.
  call lib\draw "spreadsheet"
  echo.
	call lib\draw-center-text "{0f}[{06}\.{0f}] Back", 1
	call lib\draw-center-text "{0f}[{06}/.{0f}] Change name", 1
  echo.

  :home-name (
    cmdmenusel f880 !menu-show!

    set index=0
    set "result="

    for %%x in (!menu!) do (
      set /a index=!index! + 1

      if "!index!" == "!errorlevel!" (
        set "result=%%x"
      )
    )

    if "!result!" == "Back" screens\welcome
    set "user-name=!result!"

    echo.
  )

  :home-pass (
    cecho  {0%error-level%}Type your user password:{0f} 

    if "%global-system-architecture%" == "x64" (
      editv64 -m -p "" user-pass
    ) else if "%global-system-architecture%" == "x86" (
      editv32 -m -p "" user-pass
    )

		if "%user-pass%" == "\." screens\welcome
		if "%user-pass%" == "/." goto :home-name

		set /p user-pass-original=<"data\users\%user-name%\pass.txt"

    if "%user-pass%" neq "%user-pass-original%" (
      set "error-level=c"
      goto :home-pass
    )
  )

  screens\list
)
