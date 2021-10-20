@echo off
setlocal enabledelayedexpansion

title !window-title! - Read backup
mode !window-size-width!, 10
color !window-color!

set "menu="
set "menu-show="
set "tmp-menu="

set "backup-user-name="
set "new-value="
set "temp-new-value="
set "if-or=n"
set index=0
set error-level=0

set "result="

:ini (
  set "menu="
  set "menu-show="

  goto :home
)

:home (
  cls
  echo.
  call components\draw-title "Read backup"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  :home-location (
    call components\draw-input-errorlevel "Type the locations", !error-level!
    set /p "new-value="

    if "!new-value!" == "back" screens\settings\backup

    set new-value=!new-value:"=!
    set "if-or=n"

    if not exist "!new-value!" set "if-or=y"
    if "!new-value:~-11!" neq ".backup.ini" set "if-or=y"

    if "!if-or!" == "y" (
      set error-level=3
      goto :home-location
    ) else (

      for /f "tokens=1,2 delims=^=" %%a in (!new-value!) do (
        if "%%a" neq "user-name" if "%%a" neq "pass" (
          set menu=!menu! "y"

          set prop-name=%%a
          set prop-name=!prop-name:-= !
          set prop-new-value=%%b
          : problem: recovery-questions=Ok=kO;Lm=mL;Op=pO

          set menu-show=!menu-show! " y - !prop-name!: !prop-new-value!"
        )
      )

      for %%x in ("" "Done" "Back") do (
        set menu=!menu! %%x

        call lib\center-text %%x, result
        set menu-show=!menu-show! "!result!"
      )

      goto :read
    )

  )

)

:read (
  cls
  echo.
  call components\draw-title "Select informations to save"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  set item=!errorlevel!
  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  @REM if "!result!" == "Done" (
  @REM   set index=0

  @REM   for /f "tokens=1,2 delims=^=" %%a in (!new-value!) do (
  @REM     if "%%a" neq "user-name" if "%%a" neq "pass" (
  @REM       set /a index=!index! + 1

  @REM       call lib\get-array-vector menu, !index!, result

  @REM       if !result! == "y" (
  @REM         echo %%b> "data\users\!user-name!\%%a.txt"
  @REM       )
  @REM     )
  @REM   )

  @REM   exit
  @REM ) else
  if "!result!" == "Back" (
    goto :ini
  )
  @REM ) else if "!result!" neq "" (
  @REM   set "tmp-menu="
  @REM   set index=0

  @REM   for %%x in (!menu!) do (
  @REM     if %%x neq "" if %%x neq "Back" if %%x neq "Done" (

  @REM       set /a index=!index! + 1

  @REM       if !index! == !item! (
  @REM         set "temp-new-value=y"

  @REM         if %%x == "y" (
  @REM           set "temp-new-value=n"
  @REM         )

  @REM         set tmp-menu=!tmp-menu! "!temp-new-value!"
  @REM       ) else (
  @REM         set tmp-menu=!tmp-menu! %%x
  @REM       )

  @REM     )
  @REM   )

  @REM   set menu=!tmp-menu!
  @REM   set "menu-show="
  @REM   set index=0

  @REM   for /f "tokens=1,2 delims=^=" %%a in (!new-value!) do (
  @REM     if "%%a" neq "user-name" if "%%a" neq "pass" (
  @REM       set /a index=!index! + 1

  @REM       call lib\get-array-vector menu, !index!, result

  @REM       set prop-name=%%a
  @REM       set prop-name=!prop-name:-= !
  @REM       set prop-new-value=%%b

  @REM       if "!prop-new-value:~-1,1!" == "\" set "prop-new-value=!prop-new-value!\"

  @REM       set menu-show=!menu-show! " !result! - !prop-name!: !prop-new-value!"
  @REM     )
  @REM   )

  @REM   for %%x in ("" "Done" "Back") do (
  @REM     set menu=!menu! %%x

  @REM     call lib\center-text %%x, result
  @REM     set menu-show=!menu-show! "!result!"
  @REM   )
  @REM )

  goto :read
)
