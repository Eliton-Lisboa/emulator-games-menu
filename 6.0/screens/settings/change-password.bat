@echo off

title %global-title% - Change password
mode %global-window-width%, 10
color %global-color%

set "error-level=f"
set "new-value="

:home (
  cls
  echo.
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Your password {0c}-{06}-{02}-", 4
  echo.
  call lib\draw-center-text "{0f}[{06}\.{0f}] Exit", 1
  echo.
  echo.

  :home-pass (
    cecho  {0%error-level%}Type your new password:{0f} 

    if "%global-system-architecture%" == "x64" (
      editv64 -m -p "" new-value
    ) else if "%global-system-architecture%" == "x86" (
      editv32 -m -p "" new-value
    )

    if "%new-value%" == "\." exit
    if "%new-value%" == "%user-pass%" (
      set "error-level=c"
      goto :home-pass
    )
  )

  echo %new-value%> "data\users\%user-name%\pass.txt"
  set "user-pass=%new-value%"

  exit
)
