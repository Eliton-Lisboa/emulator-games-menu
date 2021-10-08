@echo off
color 0f
mode 60,1
setlocal enabledelayedexpansion

:reload
(
  ::  errors
  if not exist ".language" (
    >"msg.vbs" echo MsgBox "Error: language pack not found!                                                 to proceed download the package.", 0+16+0+4096, "Error"
    msg.vbs
    del /s /q /f msg.vbs
    exit
  )

  if not exist ".point\" (
    md ".point\"
    >".point\language.303" echo en
  )

  set /p language=<".point\language.303"
  if not exist ".language\!language!\" (
    >"msg.vbs" echo MsgBox "Error: the selected language '!language!' does not exist                         the default language will be changed to english", 0+16+0+4096, "Error"
    msg.vbs
    del /s /q /f msg.vbs
    >".point\language.303" echo en
    set "language=en"
  )

  ::  language
  set /p MainVersion=<".language\mainversion.303"
  set /p MainTitle=<".language\!language!\maintitle.303"
  set /p MainChcp=<".language\!language!\mainchcp.303"
  set /p IsErrorMessage=<".language\!language!\iserrormessage.303"
  set /p MainHeader=<".language\!language!\mainheader.303"
  set /p SettingsHeader=<".language\!language!\settingsheader.303"
  set /p SettingsErrorHeader=<".language\!language!\settingserrorheader.303"
  set /p RomsLocationHeader=<".language\!language!\romslocationheader.303"
  set /p DoNotTypeQuotes=<".language\!language!\donottypequotes.303"
  set /p EnterToComeBack=<".language\!language!\entertocomeback.303"
  set /p EmulatorLocationHeader=<".language\!language!\emulatorlocationheader.303"
  set /p CloseOnCloseGameHeader=<".language\!language!\closeonclosegameheader.303"
  set /p CmdMenuSelSettings=<".language\!language!\menus\cmdmenuselsettings.303"
  set /p MainCmdMenuSelSettings=<".language\!language!\menus\maincmdmenuselsettings.303"
  set /p CmdMenuSelCloseOnCloseGame=<".language\!language!\menus\cmdmenuselcloseonclosegame.303"
  set /p EnterRomsLocation=<".language\!language!\enter\romslocation.303"
  set /p EnterEmulatorLocation=<".language\!language!\enter\emulatorlocation.303"
  set /p SelectLanguageHeader=<".language\!language!\selectlanguageheader.303"
  set /p SelectLanguageSelected=<".language\!language!\selectlanguageselected.303"
  set /p CmdMenuSelComeBackButton=<".language\!language!\menus\cmdmenuselcomebackbutton.303"
  title !MainTitle!
  chcp !MainChcp! >nul

  if not exist ".point\" (
    md ".point\"
    >".point\language.303" echo en
    set "isError=true"

    goto :settings
  )

  ::  files
  set normalgamelist=
  set "isError=false"
  set "menugamelist=cmdmenusel f880"
  set /a line=9
  set /a gamelistlines=0
  set /p emulatorlocation=<".point\emulatorlocation.303"
  set /p romslocation=<".point\romslocation.303"
  set /p gobackonfinishgame=<".point\gobackonfinishgame.303"

  if "!romslocation!" == "" ( goto :settings )
  if "!emulatorlocation!" == "" ( goto :settings )

  dir /b "!romslocation:~1,-1!" >"%temp%\tmpgame.303"
  for /f "usebackq tokens=*" %%x in ("%temp%\tmpgame.303") do (
    set game=%%x
    set normalgamelist=!normalgamelist! "!game!"
    set menugamelist=!menugamelist! "   !game:~0,-4!"
    set /a gamelistlines=!gamelistlines! + 1

    mode 60,!line!
    set /a line=!line! + 1
  )

)

::  -------- Home
:home

cls
echo.
!MainHeader!&&echo.
echo.
echo.
echo.
set menugamelist=!menugamelist! !MainCmdMenuSelSettings!
set /a gamelistlines=!gamelistlines! + 2

!menugamelist!

set /a selectedlistitem=!errorlevel!
set /a selectedminusone=!selectedlistitem! - 1
set game=
set /a line=0
for %%x in (!normalgamelist!) do (

  if "!game!" == "" if "!line!" == "!selectedminusone!" (
    set gameline=%%x
    set game=!gameline!
  )
  set /a line=!line! + 1
)

set /a lastlistitemminusone=!gamelistlines! - 1
if "!selectedlistitem!" == "!gamelistlines!" ( goto :settings )
if "!selectedlistitem!" == "!lastlistitemminusone!" ( goto :settings )

"!emulatorlocation:~1,-1!" "!game:~1,-1!"
if exist "stdout.txt" ( del /s /q /f "stdout.txt" >nul )
if exist "stderr.txt" ( del /s /q /f "stderr.txt" >nul )

if "!gobackonfinishgame!" == "false" ( goto :reload )
exit

::  -------- Settings
:settings
mode 60,20
cls

echo.
!SettingsHeader!&&echo.
".\cecho" {08} !MainVersion!
if "!isError!" == "true" (
  !settingserrorheader!&&echo.
)
echo.
echo.
!CmdMenuSelSettings!

if "%errorlevel%" == "1" (
  :selectromslocation
  cls

  echo.
  !RomsLocationHeader!&&echo.
  !EnterToComeBack!&&echo.
  echo.
  !DoNotTypeQuotes!&&echo.
  for /l %%x in (0,1,7) do ( echo. )
  if "!isError!" == "true" (
      !IsErrorMessage!
  )
  echo.
  echo.

  !EnterRomsLocation!
  set /p "newromslocation="
  
  if "!newromslocation!" neq "\." (
    if not exist "!newromslocation!" (
      set "isError=true"
      goto :selectromslocation
    ) else (
      set "isError=false"
      md ".point\"
      >".point\romslocation.303" echo "!newromslocation!"
    )

  )

  goto :settings
)
if "%errorlevel%" == "2" (
  :selectemulatorlocation
  cls

  echo.
  !EmulatorLocationHeader!&&echo.
  !EnterToComeBack!&&echo.
  echo.
  !DoNotTypeQuotes!&&echo.
  for /l %%x in (0,1,7) do ( echo. )
  if "!isError!" == "true" (
    !IsErrorMessage!
  )
  
  !EnterEmulatorLocation!
  set /p "newemulatorlocation="
  
  if "!newemulatorlocation!" neq "\." (
    set "isError=false"
    md ".point\"
    >".point\emulatorlocation.303" echo "!newemulatorlocation!"
  )

  goto :settings
)
if "%errorlevel%" == "3" (
  cls

  echo.
  !CloseOnCloseGameHeader!&&echo.
  for /l %%x in (0,1,9) do ( echo. )
  
  !CmdMenuSelCloseOnCloseGame!
  set selectedlistitem=!errorlevel!

  md ".point\"
  if "!selectedlistitem!" == "1" (
    >".point\gobackonfinishgame.303" echo true
  )
  if "!selectedlistitem!" == "2" (
    >".point\gobackonfinishgame.303" echo false
  )

  goto :settings
)
if "%errorlevel%" == "4" (
  cls


)
if "%errorlevel%" == "5" (

  set /a languageslistlines=0
  set normallanguagelist=
  set "languageslist=cmdmenusel f880"
  dir /b ".language\" >"%temp%\tmplanguages.303"
  set /a line=9

  for /f "usebackq tokens=*" %%x in ("%temp%\tmplanguages.303") do (
    set langlanguage=%%x

    if "!langlanguage!" neq "mainversion.303" (
      set languageslist=!languageslist! "   !langlanguage!"
      set /a languageslistlines=!languageslistlines! + 1
      set normallanguagelist=!normallanguagelist! "!langlanguage!"
    )

    if !line! gtr 20 (
      echo "!line!"
      pause
      mode 60,!line!
    )
    set /a line += 1
  )
  set languageslist=!languageslist! !CmdMenuSelComeBackButton!
  set /a languageslistlines=!languageslistlines! + 2

  cls
  echo.
  !SelectLanguageHeader!&&echo.
  !SelectLanguageSelected!&& echo !language! &&echo.
  echo.
  echo.
  !languageslist!
  set /a selectedlistitem=!errorlevel!
  set /a langlastlistitemminusone=!languageslistlines! - 1

  if "!selectedlistitem!" == "!langlastlistitemminusone!" ( goto :settings )
  if "!selectedlistitem!" == "!languageslistlines!" ( goto :settings )

  set selectedlanguage=
  set /a line=0
  set /a selectedlistitemminusone=!selectedlistitem! - 1
  for %%x in (!normallanguagelist!) do (

    if "!selectedlanguage!" == "" if "!line!" == "!selectedlistitemminusone!" (
      set selectedlanguage=%%x
    )
    set /a line=!line! + 1
  )

  >".point\language.303" echo !selectedlanguage:~1,-1!
  goto :settings
)
set /p emulatorlocation=<".point\emulatorlocation.303"
set /p romslocation=<".point\romslocation.303"

if "!emulatorlocation!" == "" ( set "isError=true" && goto :settings )
if "!romslocation!" == "" ( set "isError=true" && goto :settings )

set "isError=false"
goto :reload
