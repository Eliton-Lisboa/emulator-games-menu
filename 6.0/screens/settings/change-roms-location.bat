@echo off
setlocal enabledelayedexpansion

title !global-title! - Roms location
mode !global-window-width!, 8
color !global-color!

set "user-roms-location="

set "error-level=!global-color-font!f"
set "new-value="
set "result="
set "menu="
set "menu-show="
set height=8

:ini (
  if exist "data\users\!user-name!\roms-location.txt" set /p user-roms-location=<"data\users\!user-name!\roms-location.txt"

  set "menu="
  set "menu-show="

  call lib\all-folder-dirs "data\users\", result

  for %%x in (!result!) do (
    set "str=%%x"
    set "user=!str:~1,-1!"
    set /a height=!height! + 1

    if "!user!" neq "!user-name!" if exist "data\users\!user!\share-roms-location.txt" (
      set /p answer=<"data\users\!user!\share-roms-location.txt"

      if "!answer!" == "y" if exist "data\users\!user!\roms-location.txt" (
        set /p roms-location=<"data\users\!user!\roms-location.txt"
        set menu=!menu! "!roms-location!"

        if "!roms-location:~-1,1!" == "\" if "!roms-location:~-2,1!" neq "\" (
          set "roms-location=!roms-location!\"
        )

        set menu-show=!menu-show! " !user! - !roms-location!"
      )
    )
  )

  for %%x in ("None" "" "Back") do (
    set menu=!menu! %%x
    set /a height=!height! + 1

    call lib\center-text %%x, result
    set menu-show=!menu-show! "!result!"
  )

  if 8 gtr !height! set height=8

  mode !global-window-width!, !height!

  goto :home
)

:home (
  cls
  echo.
  call lib\draw-title "Your roms location"
  call lib\draw-center-text "{&1&4}!user-roms-location!", 0
  echo.
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  call lib\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "None" (
    echo.
    :home-location
      cecho  {!global-color-background!!error-level!}Type your roms location:{!global-color!} 
      set /p "new-value="

      if "!new-value!" == "back" goto :home

      if not exist "!new-value!" (
        set "error-level=!global-color-error!"
        goto :home-location
      )

      if "!new-value!" == "!user-roms-location!" (
        set "error-level=!global-color-warn!"
        goto :home-location
      )

    echo !new-value!> "data\users\!user-name!\roms-location.txt"
    set "user-roms-location=!new-value!"

    exit
  ) else if "!result!" == "Back" (
    exit
  ) else if "!result!" neq "" (
    echo !result!> "data\users\!user-name!\roms-location.txt"
    set "user-roms-location=!result!"

    exit
  )

  goto :home
)
