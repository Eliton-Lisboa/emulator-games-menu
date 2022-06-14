@echo off
setlocal enabledelayedexpansion

title File Selector
color 0f
mode 60,30

: [
:   root folder,
:   back to the root folder: y or n,
:   folder or file,
:   accepted extenssions: .jpg;.png,
:   title: string
: ]

set "menu="
set "menu-show="
set "temp="
set "size="
set "res="
set "result="
set if-or=0

set "config-libs-path="
set "config-components-path="

set params-root-folder=%~1
set params-back-root-folder=%~2
set params-select-type=%~3
set "params-accepted-extenssions="

:valid (
  if not exist "%~1" (
    echo "%~1" not exists :(> "temp\file-selector.txt"
    exit
  )

  if "%~2" neq "y" if "%~2" neq "n" set "params-back-root-folder=n"
  if "%~3" neq "file" if "%~3" neq "folder" set "params-select-type=file"
)

:ini (
  echo exit> "temp\file-selector.txt"

  for /f "usebackq tokens=1,2 delims=^=" %%a in ("%~dp0\file-selector-configfile.ini") do (
    if "%%a" == "libs-path" (
      call config\get-configfile-prop "libs-path", result
      set "config-libs-path=!result!\%%b"
    )
    if "%%a" == "components-path" (
      call config\get-configfile-prop "components-path", result
      set "config-components-path=!result!\%%b"
    )
  )

  call !config-libs-path!\string-length "%~4", result

  for /l %%x in (0, 1, !result!) do (
    set res=%~4
    set res=!res:~%%x,1!

    if "!res!" == ";" (
      set "params-accepted-extenssions=!params-accepted-extenssions! "
    ) else (
      set "params-accepted-extenssions=!params-accepted-extenssions!!res!"
    )
  )

)

:reload (
  set "menu="
  set "menu-show="
  set size=0
  echo.> "temp\file-selector-filter.txt"

  for /f "tokens=*" %%x in ('dir /b "!params-root-folder!"') do (
    if exist "!params-root-folder!\%%x\*" (
      set /a size=!size! + 1
      set menu=!menu! "%%x"

      call !config-libs-path!\center-text "%%x\\", result
      set menu-show=!menu-show! "!result!"
    )
  )

  if "!params-select-type!" == "file" (
    if "!params-accepted-extenssions!" neq "" (
      set "temp="

      for %%x in (!params-accepted-extenssions!) do (
        for /f "tokens=*" %%y in ('dir /b "!params-root-folder!" ^| findstr ".%%x"') do (
          set temp=!temp! %%y
        )
      )


      for %%x in (!temp!) do (
        set /a size=!size! + 1
        set menu=!menu! "%%x"

        call !config-libs-path!\center-text "%%x", result
        set menu-show=!menu-show! "!result!"
      )

    ) else (
      for /f "tokens=*" %%x in ('dir /b "!params-root-folder!"') do (
        if not exist "!params-root-folder!\%%x\*" (
          set /a size=!size! + 1
          set menu=!menu! "%%x"

          call !config-libs-path!\center-text "%%x", result
          set menu-show=!menu-show! "!result!"
        )
      )

    )
  )

  for %%x in ("" "Exit") do (
    set /a size=!size! + 1
    set menu=!menu! %%x

    call !config-libs-path!\center-text %%x, result
    set menu-show=!menu-show! "!result!"

    if %%x == "" (
      set if-or=0

      if "!params-root-folder!" neq "%~1" set if-or=1
      if "!params-back-root-folder!" == "y" set if-or=1

      if "!params-select-type!" == "folder" (
        set /a size=!size! + 1
        set menu=!menu! "Select folder"

        call !config-libs-path!\center-text "Select folder", result
        set menu-show=!menu-show! "!result!"
      )

      if !if-or! == 1 (
        set /a size=!size! + 1
        set menu=!menu! "Back"

        call !config-libs-path!\center-text "Back", result
        set menu-show=!menu-show! "!result!"
      )

    )

  )

  set /a size=!size! + 8

  if !size! lss 30 (
    mode 60,30
  ) else (
    mode 60,!size!
  )
)

:home (
  cls
  echo.
  call !config-components-path!\draw-title "File Selector"
  call !config-libs-path!\draw-center-text "{0f}%~5", 1
  echo.
  call !config-libs-path!\draw-center-text "{0f}!params-root-folder!", 1
  echo.
  echo.

  cmdmenusel f880 !menu-show!

  call !config-libs-path!\get-array-vector menu, !errorlevel!, result
  set result=!result:~1,-1!

  if "!result!" == "Exit" (
    echo exit> "temp\file-selector.txt"
    exit
  ) else if "!result!" == "Back" (
    call !config-libs-path!\go-back-folder "!params-root-folder!", result

    if "!result!" == "" set "result=\"

    set params-root-folder=!result!

    goto :reload
  ) else if "!result!" == "Select folder" (
    echo !params-root-folder!> "temp\file-selector.txt"

    exit
  ) else if "!result!" neq "" (
    if exist "!params-root-folder!\!result!\*" (
      set "params-root-folder=!params-root-folder!\!result!"
      goto :reload
    ) else (
      echo !params-root-folder!\!result!> "temp\file-selector.txt"
      exit
    )
  )

  goto :home
)
