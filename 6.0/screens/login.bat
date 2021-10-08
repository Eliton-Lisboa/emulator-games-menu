
set "user-name="
set "user-pass="
set "user-pass-repeat="
set "user-pass-original="

set "error-level=f"

:home (
  cls
  echo.
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Console Games Menu {0c}-{06}-{02}-", 4
  echo.
  call lib\draw "spreadsheet"
  echo.
	call lib\draw-center-text "{0f}[{06}\.{0f}] Exit", 1
	call lib\draw-center-text "{0f}[{06}/.{0f}] Change name", 1
  echo.
  echo.

  :home-name (
    cecho  {0%error-level%}Type your user name:{0f} 
    set /p "user-name="

		if "%user-name%" == "\." screens\welcome

    if "%user-name%" == "" (
      set "error-level=c"
      goto :home-name
    )
    if not exist "data\users\%user-name%" (
      set "error-level=c"
      goto :home-name
    )

    set "error-level=f"
  )

  :home-pass (
    cecho  {0%error-level%}Type your user password:{0f} 
    set /p "user-pass="

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
