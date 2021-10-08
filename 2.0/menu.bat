@echo off
title Super nintendo - All Saved Games
color 0f
mode 60,1
chcp 65001
setlocal enabledelayedexpansion

:reload
(
    >"%temp%/windowsize.303" echo 9
    set gamelist=
    set "menugamelist=cmdmenusel f880"
    set normalgamelist=
    set /a listlines=1
    set /p emulatorlocation=<"\Users\%username%\.menuemulator\emulatorlocation.303"
    set /p romslocation=<"\Users\%username%\.menuemulator\romslocation.303"
    set /p gobackonfinishgame=<"\Users\%username%\.menuemulator\gobackonfinishgame.303"

    if "!romslocation!" == "" ( goto :settings )
    if "!emulatorlocation!" == "" ( goto :settings )

    echo. >"%temp%\tmpgame.303"
    dir /b "!romslocation:~1,-1!" >>"%temp%\tmpgame.303"
)

::  -------- Home
:home
cls

for /f "usebackq tokens=* skip=1" %%x in ("%temp%\tmpgame.303") do (

    set game=%%x
    set gamelist=!gamelist! "!game:~0,-4!"
    set normalgamelist=!normalgamelist! "!game!"
    set /a listlines=!listlines! + 1

    set /p line=<"%temp%\windowsize.303"
    mode 60,!line!
    set /a addednewline=!line! + 1
    >"%temp%/windowsize.303" echo !addednewline!

)

echo.
".\cecho" {06}         --- &&".\cecho" {0f}Super nintendo&&".\cecho" {06} - &&".\cecho" {0f}All Saved Games&&".\cecho"  {06} ---&&echo.
echo.
echo.
echo.

for %%y in (%gamelist%) do (
    set game=%%y

set menugamelist=!menugamelist! "   !game:~1,-1!"
)
set menugamelist=!menugamelist! " " "                          Settings"
set /a listlines=!listlines! + 2
!menugamelist!

set /a selectedlistitem=%errorlevel% + 1
set /a selectedminusone=!selectedlistitem! - 1
set game=
for /f "usebackq tokens=* skip=%selectedminusone%" %%z in ("%temp%/tmpgame.303") do (
        
    if "!game!" == "" (
        set line=%%z
        set game=!line!
    )
)

set /a lastlistitemminusone=!listlines! - 1
if "!selectedlistitem!" == "!listlines!" (
    goto :settings
)
if "!selectedlistitem!" == "!lastlistitemminusone!" (
    goto :settings
)

"!emulatorlocation:~1,-1!" "!game!"
del /s /q /f "stdout.txt"
del /s /q /f "stderr.txt"
if "!gobackonfinishgame!" == "true" ( goto :reload )

exit

::  -------- Settings
:settings
mode 60,20
cls

echo.
".\cecho" {06}                   --- &&".\cecho" {0f}Menu settings&&".\cecho" {06} ---&&echo.
echo.
echo.
echo.
"./cmdmenusel" f880 "                       Roms Location" "                     Emulator Location" "                   Closes when game ends" " " "                         Come back"

if "%errorlevel%" == "1" (
    cls

    echo.
    ".\cecho" {06}       --- &&".\cecho" {0f}Enter your new location for your roms&&".\cecho" {06} ---&&echo.
    ".\cecho" {06}                       [&&".\cecho" {0f}\.&&".\cecho" {06}]&&".\cecho" {0f} Come back&&echo.
    echo.
    ".\cecho" {04}            --- Write without double quotes ---&&echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    ".\cecho" {0f}Enter location ~&&".\cecho" {06}^> &&".\cecho" {0f}&& set /p "newromslocation="
    
    if "!newromslocation!" neq "\." (
        md "\Users\%username%\.menuemulator"
        >"\Users\%username%\.menuemulator\romslocation.303" echo "!newromslocation!"
    )

    goto :settings
)
if "%errorlevel%" == "2" (
    cls

    echo.
    ".\cecho" {06}     --- &&".\cecho" {0f}Enter your new location for your emulator&&".\cecho" {06} ---&&echo.
    ".\cecho" {06}                       [&&".\cecho" {0f}\.&&".\cecho" {06}]&&".\cecho" {0f} Come back&&echo.
    echo.
    ".\cecho" {04}            --- Write without double quotes ---&&echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    ".\cecho" {0f}Enter location ~&&".\cecho" {06}^> &&".\cecho" {0f}&& set /p "newemulatorlocation="
    
    if "!newemulatorlocation!" neq "\." (
        md "\Users\%username%\.menuemulator"
        >"\Users\%username%\.menuemulator\emulatorlocation.303" echo "!newemulatorlocation!"
    )

    goto :settings
)
if "%errorlevel%" == "3" (
        cls

    echo.
    ".\cecho" {06}                  --- &&".\cecho" {0f}Enter an option&&".\cecho" {06} ---&&echo.
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
    ".\cmdmenusel" f880 "                            Yes" "                            No" " " "                         Come back"

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
    goto :reload
)
if "%errorlevel%" == "5" (
    goto :reload
)
