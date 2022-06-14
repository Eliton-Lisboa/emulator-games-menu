@echo off
setlocal enabledelayedexpansion

title !window-title! - Change recovery questions
mode !window-size!
color !window-color!

set "new-user-questions-1="
set "new-user-questions-2="
set "new-user-questions-3="

set "new-answers-1="
set "new-answers-2="
set "new-answers-3="

:home (
  cls
  echo.
  call components\draw-title "Console Games Menu"
  echo.
  echo.
  call lib\draw-center-text "Type '{&1&4}back{&0}' to go back", 1
  echo.
  echo.

  :home-question-1 (
    set /p "new-user-questions-1=Question 1: "
    set /p "new-answers-1=Answer 1: "

    if "!new-user-questions-1!" == "" goto :home-questions-1
    if "!new-user-questions-1!" == "back" exit
  )

  :home-question-2 (
    set /p "new-user-questions-2=Question 2: "
    set /p "new-answers-2=Answer 2: "

    if "!new-user-questions-2!" == "" goto :home-questions-2
    if "!new-user-questions-2!" == "back" exit
  )

  :home-question-3 (
    set /p "new-user-questions-3=Question 3: "
    set /p "new-answers-3=Answer 3: "

    if "!new-user-questions-3!" == "" goto :home-questions-3
    if "!new-user-questions-3!" == "back" exit
  )

  call database\update\recovery-questions "!user-name!", "!new-user-questions-1!:!new-answers-1!;!new-user-questions-2!:!new-answers-2!;!new-user-questions-3!:!new-answers-3!"

  exit
)
