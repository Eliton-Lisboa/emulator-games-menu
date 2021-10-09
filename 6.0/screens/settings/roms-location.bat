@echo off
setlocal enabledelayedexpansion

title !global-title! - Roms location
mode !global-window-width!, 8
color !global-color!

set "user-roms-location="

set "error-level=f"
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
  call lib\draw-center-text "{0c}-{06}-{02}-{0f} Your roms location {0c}-{06}-{02}-", 4
  call lib\draw-center-text "{06}!user-roms-location!", 0
  echo.
  call lib\draw-center-text "{0f}[{06}\.{0f}] Back", 1
  echo.
  echo.

  cmdmenusel f880 !menu-show!

	set index=0
	set "result="

  for %%x in (!menu!) do (
		set /a index=!index! + 1

		if "!index!" == "!errorlevel!" (
			set "result=%%x"
		)
	)
  set "result=!result:~1,-1!"

  if "!result!" == "None" (
    echo.
    :home-location
      cecho  {0!error-level!}Type your roms location:{0f} 
      set /p "new-value="

      if "!new-value!" == "\." goto :home
      if not exist "!new-value!" (
        set "error-level=c"
        goto :home-location
      )

      if "!new-value!" == "!user-roms-location!" (
        set "error-level=6"
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
