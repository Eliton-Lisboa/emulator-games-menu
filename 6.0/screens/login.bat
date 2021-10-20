setlocal enabledelayedexpansion

title !window-title! - Login

set "menu="
set "menu-show="
set "tmp-user-name="
set "tmp-user-pass="

set "result="
set error-level=0

:ini (
  set "menu-show="

  call database\get\all-users menu
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
  call components\draw-title "Login"
  echo.
  call lib\draw "spreadsheet"
  echo.
  call lib\draw-center-text "Type {&1&4}'name'{&0} to reselect the name", 1
  call lib\draw-center-text "Type {&1&4}'recovery'{&0} to recovery account", 1
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  echo.

  :home-name (
    cmdmenusel f880 !menu-show!

    call lib\get-array-vector menu, !errorlevel!, result
    set result=!result:~1,-1!

    if "!result!" == "Back" screens\welcome
    if "!result!" == "" goto :ini

    set tmp-user-name=!result!
  )

  echo.

  :home-pass (
    call components\draw-input-errorlevel "Type your user password", !error-level!
    call components\type-password tmp-user-pass

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
