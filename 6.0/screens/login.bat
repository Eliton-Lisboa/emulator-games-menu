setlocal enabledelayedexpansion

set "user-name="
set "user-pass="
set "user-pass-repeat="
set "user-pass-original="

set "error-level=f"
set "menu="
set "menu-show="
set "result="

:ini (
  set "menu="
  set "menu-show="

  call lib\all-folder-dirs "data\users\", menu
  set menu=!menu! "" "Back"

  for %%x in (!menu!) do (
    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-title "Console Games Menu"
  echo.
  call lib\draw "spreadsheet"
  echo.
	call lib\draw-center-text "Type {06}'back'{!global-color!} to go back", 1
	call lib\draw-center-text "Type {06}'name'{!global-color!} to rewrite the name", 1
  echo.

  (
    cmdmenusel f880 !menu-show!

    call lib\get-array-vector menu, !errorlevel!, result
    set result=!result:~1,-1!

    if "!result!" == "Back" screens\welcome
    if "!result!" == "" goto :ini

    set "user-name=!result!"

    echo.
  )

  :home-pass (
    cecho  {0!error-level!}Type your user password:{0f} 

    if "!global-system-architecture!" == "x64" (
      editv64 -m -p "" user-pass
    ) else if "!global-system-architecture!" == "x86" (
      editv32 -m -p "" user-pass
    )

		if "!user-pass!" == "back" screens\welcome
		if "!user-pass!" == "name" goto :ini

		set /p user-pass-original=<"data\users\!user-name!\pass.txt"

    if "!user-pass!" neq "!user-pass-original!" (
      set "error-level=c"
      goto :home-pass
    )
  )

  screens\list
)
