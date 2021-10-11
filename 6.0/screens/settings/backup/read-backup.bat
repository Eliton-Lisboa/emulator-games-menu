@echo off
setlocal enabledelayedexpansion

title !global-title! - Read backup
mode !global-window-width!, 10
color !global-color!

set "backup-user-name="
set "menu="
set "menu-show="
set "tmp-menu="
set "value="
set "temp-value="
set index=0

set "result="

:ini (
  set "menu="
  set "menu-show="

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-title "Read backup"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  :home-location (
    cecho {!global-color-background!!error-level!}Type the locations:{!global-color!} 
    set /p "value="

    if "!value!" == "back" screens\settings\backup

    set value=!value:"=!

    if not exist "!value!" (
      set "error-level=!global-color-error!"
      goto :home-location
    ) else if "!value:~-11!" neq ".backup.ini" (
      set "error-level=!global-color-error!"
      goto :home-location
    ) else (

      for /f "tokens=1,2 delims=^=" %%a in (!value!) do (
        if "%%a" neq "user-name" if "%%a" neq "pass" (
          set menu=!menu! "y"

          set prop-name=%%a
          set prop-name=!prop-name:-= !
          set prop-value=%%b

          if "!prop-value:~-1,1!" == "\" set "prop-value=!prop-value!\"

          set menu-show=!menu-show! " y - !prop-name!: !prop-value!"
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
  call lib\draw-title "Select informations to save"
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  set item=!errorlevel!
  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Done" (
    set index=0

    for /f "tokens=1,2 delims=^=" %%a in (!value!) do (
      if "%%a" neq "user-name" if "%%a" neq "pass" (
        set /a index=!index! + 1

        call lib\get-array-vector menu, !index!, result

        if !result! == "y" (
          echo %%b> "data\users\!user-name!\%%a.txt"
        )
      )
    )

    exit
  ) else if "!result!" == "Back" (
    goto :ini
  ) else if "!result!" neq "" (
    set "tmp-menu="
    set index=0

    for %%x in (!menu!) do (
      if %%x neq "" if %%x neq "Back" if %%x neq "Done" (

        set /a index=!index! + 1

        if !index! == !item! (
          set "temp-value=y"

          if %%x == "y" (
            set "temp-value=n"
          )

          set tmp-menu=!tmp-menu! "!temp-value!"
        ) else (
          set tmp-menu=!tmp-menu! %%x
        )

      )
    )

    set menu=!tmp-menu!
    set "menu-show="
    set index=0

    for /f "tokens=1,2 delims=^=" %%a in (!value!) do (
      if "%%a" neq "user-name" if "%%a" neq "pass" (
        set /a index=!index! + 1

        call lib\get-array-vector menu, !index!, result

        set prop-name=%%a
        set prop-name=!prop-name:-= !
        set prop-value=%%b

        if "!prop-value:~-1,1!" == "\" set "prop-value=!prop-value!\"

        set menu-show=!menu-show! " !result! - !prop-name!: !prop-value!"
      )
    )

    for %%x in ("" "Done" "Back") do (
      set menu=!menu! %%x

      call lib\center-text %%x, result
      set menu-show=!menu-show! "!result!"
    )
  )

  goto :read
)
