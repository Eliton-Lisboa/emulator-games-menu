@echo off
title Super nintendo - All Saved Games
color 0f
mode 60,1
chcp 65001
setlocal enabledelayedexpansion

:reload
(
    ::  language
    set /p language=<"\Users\%username%\.menuemulator\language.303"
    if not exist ".language\!language!\" (
        >"msg.vbs" echo MsgBox "Error: the selected language '!language!' does not exist                         the default language will be changed to english", 0+16+0+4096, "Error"
        msg.vbs
        del /s /q /f msg.vbs
        >"\Users\%username%\.menuemulator\language.303" echo en
        set "language=en"
    )

    set /p MainTitle=<".language\!language!\maintitle.303"
    set /p MainChcp=<".language\!language!\mainchcp.303"
    set /p MainHeader=<".language\!language!\mainheader.303"
    set /p SettingsHeader=<".language\!language!\settingsheader.303"
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

    ::  files
    set normalgamelist=
    set "menugamelist=cmdmenusel f880"
    set /a gamelistlines=0
    set /p emulatorlocation=<"\Users\%username%\.menuemulator\emulatorlocation.303"
    set /p romslocation=<"\Users\%username%\.menuemulator\romslocation.303"
    set /p gobackonfinishgame=<"\Users\%username%\.menuemulator\gobackonfinishgame.303"
    >"%temp%\windowsize.303" echo 9

    if "!romslocation!" == "" ( goto :settings )
    if "!emulatorlocation!" == "" ( goto :settings )

    dir /b "!romslocation:~1,-1!" >"%temp%\tmpgame.303"
    for /f "usebackq tokens=*" %%x in ("%temp%\tmpgame.303") do (
        set game=%%x
        set normalgamelist=!normalgamelist! "!game!"
        set menugamelist=!menugamelist! "   !game:~0,-4!"
        set /a gamelistlines=!gamelistlines! + 1

        set /p line=<"%temp%\windowsize.303"
        mode 60,!line!
        set /a addednewline=!line! + 1
        >"%temp%/windowsize.303" echo !addednewline!
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

set /a selectedlistitem=%errorlevel%
set /a selectedminusone=!selectedlistitem! - 1
set game=
set /a line=0
for %%x in (!normalgamelist!) do (

    if "!game!" == "" (
        if "!line!" == "!selectedminusone!" (
            set gameline=%%x
            set game=!gameline!
        )
    )
    set /a line=!line! + 1
)

set /a lastlistitemminusone=!gamelistlines! - 1
if "!selectedlistitem!" == "!gamelistlines!" (
    goto :settings
)
if "!selectedlistitem!" == "!lastlistitemminusone!" (
    goto :settings
)

"!emulatorlocation:~1,-1!" "!game:~1,-1!"
if exist "stdout.txt" ( del /s /q /f "stdout.txt" >nul )
if exist "stderr.txt" ( del /s /q /f "stderr.txt" >nul )
if "!gobackonfinishgame!" == "true" ( goto :reload )

exit

::  -------- Settings
:settings
mode 60,20
cls

echo.
!SettingsHeader!&&echo.
".\cecho" {08} 4.0
echo.
echo.
!CmdMenuSelSettings!

if "%errorlevel%" == "1" (
    cls

    echo.
    !RomsLocationHeader!&&echo.
    !EnterToComeBack!&&echo.
    echo.
    !DoNotTypeQuotes!&&echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    !EnterRomsLocation!
    set /p "newromslocation="
    
    if "!newromslocation!" neq "\." (
        md "\Users\%username%\.menuemulator"
        >"\Users\%username%\.menuemulator\romslocation.303" echo "!newromslocation!"
    )

    goto :settings
)
if "%errorlevel%" == "2" (
    cls

    echo.
    !EmulatorLocationHeader!&&echo.
    !EnterToComeBack!&&echo.
    echo.
    !DoNotTypeQuotes!&&echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    !EnterEmulatorLocation!
    set /p "newemulatorlocation="
    
    if "!newemulatorlocation!" neq "\." (
        md "\Users\%username%\.menuemulator"
        >"\Users\%username%\.menuemulator\emulatorlocation.303" echo "!newemulatorlocation!"
    )

    goto :settings
)
if "%errorlevel%" == "3" (
    cls

    echo.
    !CloseOnCloseGameHeader!&&echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    !CmdMenuSelCloseOnCloseGame!

    if "!errorlevel!" == "1" (
        md "\Users\%username%\.menuemulator"
        >"\Users\%username%\.menuemulator\gobackonfinishgame.303" echo false
    )
    if "!errorlevel!" == "2" (
        md "\Users\%username%\.menuemulator"
        >"\Users\%username%\.menuemulator\gobackonfinishgame.303" echo true
    )
    if "!errorlevel!" == "3" (
        goto :settings
    )
    if "!errorlevel!" == "4" (
        goto :settings
    )

    goto :settings
)
if "%errorlevel%" == "4" (
    set /a languageslistlines=0
    set normallanguagelist=
    set "languageslist=cmdmenusel f880"
    dir /b ".language\" >"%temp%\tmplanguages.303"
    >"%temp%\languagewindowsize.303" echo 9

    for /f "usebackq tokens=*" %%x in ("%temp%\tmplanguages.303") do (
        set langlanguage=%%x

        set languageslist=!languageslist! "   !langlanguage!"
        set /a languageslistlines=!languageslistlines! + 1
        set normallanguagelist=!normallanguagelist! "!langlanguage!"
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

    if "!selectedlistitem!" == "!langlastlistitemminusone!" (
        goto :settings
    )
    if "!selectedlistitem!" == "!languageslistlines!" (
        goto :settings
    )

    set selectedlanguage=
    set /a line=0
    set /a selectedlistitemminusone=!selectedlistitem! - 1
    for %%x in (!normallanguagelist!) do (

        if "!selectedlanguage!" == "" (

            if "!line!" == "!selectedlistitemminusone!" (
                set selectedlanguage=%%x
            )
        )
        set /a line=!line! + 1
    )

    >"\Users\%username%\.menuemulator\language.303" echo !selectedlanguage:~1,-1!
    goto :settings

)
if "%errorlevel%" == "5" (
    goto :reload
)
if "%errorlevel%" == "6" (
    goto :reload
)
