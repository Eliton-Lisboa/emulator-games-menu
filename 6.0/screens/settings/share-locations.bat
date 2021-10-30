@echo off
setlocal enabledelayedexpansion

title !window-title! - Share locations
mode !window-size!
color !window-color!

set "menu="
set "menu-show="
set "check-list="
set "prop-name="
set "answer="

set index=0
set error-level=0
set "result="
set result-index=0
set "item="

:ini (
  for /f "tokens=*" %%x in ('dir /b "database\users\!user-name!" ^| findstr "location"') do (
    set item=%%x

    if "!item:~0,5!" neq "share" (
      set /p answer=< "database\users\!user-name!\share-%%x"

      if "!answer!" neq "y" if "!answer!" neq "n" (
        set "answer=n"
      )

      set check-list=!check-list! !answer!
      set menu=!menu! "!answer!"

      set prop-name=%%x
      set prop-name=!prop-name:~0,-4!
      set prop-name=!prop-name:-= !
      set prop-name=!prop-name:location=!

      call lib\center-text "!answer! - !prop-name!", result

      set menu-show=!menu-show! "!result!"
    )
  )

  for %%x in ("" "Done" "Back") do (
    set menu=!menu! %%x

    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  goto :home
)

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  set result-index=!errorlevel!
  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Done" (
    set index=0

    for /f "tokens=*" %%x in ('dir /b "database\users\!user-name!" ^| findstr "location"') do (
      set /a index+=1

      set prop-name=%%x
      set prop-name=!prop-name:~0,-4!
      set prop-name=!prop-name:-=!
      set prop-name=!prop-name:location=!

      call lib\get-array-vector check-list, !index!, result
      call database\update\share-locations !user-name!, !prop-name!, !result!
    )

    exit
  ) else if "!result!" == "Back" (
    exit
  ) else if "!result!" neq "" (
    set "new-value=n"

    call lib\get-array-vector check-list, !result-index!, result

    if "!result!" == "n" set "new-value=y"

    call lib\change-array-index check-list, !result-index!, !new-value!, check-list

    set "menu="
    set "menu-show="
    set index=0

    for /f "tokens=*" %%x in ('dir /b "database\users\!user-name!" ^| findstr "location"') do (
      set /a index+=1
      set item=%%x

      if "!item:~0,5!" neq "share" (
        call lib\get-array-vector check-list, !index!, result

        set menu=!menu! "!result!"

        set prop-name=%%x
        set prop-name=!prop-name:~0,-4!
        set prop-name=!prop-name:-=!
        set prop-name=!prop-name:location=!

        call lib\center-text "!result! - !prop-name!", result

        set menu-show=!menu-show! "!result!"
      )
    )

    for %%x in ("" "Done" "Back") do (
      set menu=!menu! %%x

      call lib\center-text %%x, result
      set menu-show=!menu-show! "!result!"
    )
  )

  goto :home
)
