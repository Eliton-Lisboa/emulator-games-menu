
set "user-name="
set "user-pass="
set "user-pass-repeat="

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
  call lib\draw-center-text "{0f}[{06}/..{0f}] Change pass", 1
  echo.

  :home-name (
    cecho  {0%error-level%}Type your name:{0f} 
    set /p "user-name="

    if "%user-name%" == "\." screens\welcome
    if exist "data\users\%user-name%" (
      set "error-level=c"
      goto :home-name
    )

    set "error-level=f"
  )


  :home-pass (
    cecho  {0%error-level%}Type your password:{0f} 
    set /p "user-pass="

    if "%user-pass%" == "\." screens\welcome
    if "%user-pass%" == "/." goto :home-name
    if "%user-pass%" == "" (
      set "error-level=c"
      goto :home-pass
    )

    set "error-level=f"
  )

  :home-pass-repeat (
    cecho  {0%error-level%}Repeat your password:{0f} 
    set /p "user-pass-repeat="

    if "%user-pass-repeat%" == "\." screens\welcome
    if "%user-pass%" == "/." goto :home-name
    if "%user-pass%" == "/.." goto :home-pass
    if "%user-pass-repeat%" neq "%user-pass%" (
      set "error-level=c"
      goto :home-pass-repeat
    )
  )

  md "data\users\%user-name%"
  echo %user-pass%> "data\users\%user-name%\pass.txt"

  screens\list
)
