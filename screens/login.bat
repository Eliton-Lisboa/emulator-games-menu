setlocal enabledelayedexpansion

title !window-title! - Login

set "menu="
set "tmp-user-name="
set "tmp-user-pass="

set "result="
set error-level=0

:ini (
  call database\get\all-users menu
  set menu=!menu! "" "Back"
)

(
  cls
  echo.
  call draw-title Login
  echo.
  call draw spreadsheet
  echo.
  vecho /x:center Type [6]'name'[] to reselect the name  
  vecho /x:center Type [6]'recovery'[] to recovery account  
  vecho /x:center Type [6]'back'[] to go back  
  echo.

  :home-name (
    lisch /format:list /type:select !menu!

    call get-array-vector menu, !errorlevel!, result
    set result=!result:~1,-1!

    if "!result!" == "Back" screens\welcome
    if "!result!" == "" goto :ini

    set tmp-user-name=!result!
  )

  echo.

  :home-pass (
    call draw-input-errorlevel "Type your user password", !error-level!
    call type-password tmp-user-pass

    if "!tmp-user-pass!" == "back" screens\welcome
    if "!tmp-user-pass!" == "name" goto :ini
    if "!tmp-user-pass!" == "recovery" (
      set user-name=!tmp-user-name!
      start /wait /shared screens\settings\recovery
      goto :home-pass
    )

    call database\valid\login "!tmp-user-name!", "!tmp-user-pass!", result

    if "!result!" == "n" (
      set error-level=3
      goto :home-pass
    )
  )

  set user-name=!tmp-user-name!
  set user-pass=!tmp-user-pass!

  screens\list
)
