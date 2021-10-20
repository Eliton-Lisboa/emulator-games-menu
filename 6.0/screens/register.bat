setlocal enabledelayedexpansion

title !window-title! - Register

set "new-user-name="
set "new-user-pass="
set "new-user-pass-repeat="
set "new-user-questions-1="
set "new-user-questions-2="
set "new-user-questions-3="

set "new-answers-1="
set "new-answers-2="
set "new-answers-3="

set "if-or=n"

:home (
  cls
  echo.
  call components\draw-title "Register"
  echo.
  call lib\draw "spreadsheet"
  echo.
  call lib\draw-center-text "Type {&1&4}'name'{&0} to rewrite the name", 1
  call lib\draw-center-text "Type {&1&4}'pass'{&0} to rewrite the password", 1
  call lib\draw-center-text "Type {&1&4}'back'{&0} to go back", 1
  echo.

  :home-name (
    cecho  Type your name: 
    set /p "new-user-name="
    set "if-or=n"

    if "!new-user-name!" == "name" goto :home-name
    if "!new-user-name!" == "pass" set "if-or=y"
    if "!new-user-name!" == "back" screens\welcome

    call database\lib\valid-new-name "!new-user-name!", result
    if "!result!" == "n" set "if-or=y"

    if "!if-or!" == "y" (
      echo.
      call lib\draw-text " {&1&3}Must contain only letters and numbers."
      call lib\draw-text " {&1&3}Must contain less than eight characters."
      call lib\draw-text " {&1&3}It must not be the name of an existing user."
      echo.

      goto :home-name
    )

  )

  :home-pass (
    cecho  Type your password: 
    call components\type-password new-user-pass
    set "if-or=n"

    if "!new-user-pass!" == "name" goto :home-name
    if "!new-user-pass!" == "pass" goto :home-pass
    if "!new-user-pass!" == "back" screens\welcome

    call database\lib\valid-new-password "!new-user-pass!", result
    if "!result!" == "n" set "if-or=y"

    if "!if-or!" == "y" (
      echo.
      call lib\draw-text " {&1&3}Must contain only letters and numbers."
      echo.

      goto :home-pass
    )

  )

  :home-pass-repeat (
    cecho  Repeat your password: 
    call components\type-password new-user-pass-repeat

    if "!new-user-pass-repeat!" == "name" goto :home-name
    if "!new-user-pass-repeat!" == "pass" goto :home-pass
    if "!new-user-pass-repeat!" == "back" screens\welcome
    if "!new-user-pass-repeat!" neq "!new-user-pass!" goto :home-pass-repeat

  )

  (
    echo.
    echo  Create account recovery questions and answers:
    echo.

    :home-question-1 (
      cecho  Question 1: 
      set /p "new-user-questions-1="
      cecho  Answer 1: 
      set /p "new-answers-1="

      if "!new-user-questions-1!" == "" goto :home-questions-1
    )

    :home-question-2 (
      cecho  Question 2: 
      set /p "new-user-questions-2="
      cecho  Answer 2: 
      set /p "new-answers-2="

      if "!new-user-questions-2!" == "" goto :home-questions-2
      if "!new-user-questions-2!" == "!new-user-questions-1!" goto :home-questions-2
    )

    :home-question-3 (
      cecho  Question 3: 
      set /p "new-user-questions-3="
      cecho  Answer 3: 
      set /p "new-answers-3="

      if "!new-user-questions-3!" == "" goto :home-questions-3
      if "!new-user-questions-3!" == "!new-user-questions-1!" goto :home-questions-3
      if "!new-user-questions-3!" == "!new-user-questions-2!" goto :home-questions-3
    )

  )

  call database\add "!new-user-name!", "!new-user-pass!"
  call database\update\questions "!new-user-name!", "!new-user-questions-1!", "!new-answers-1!", "!new-user-questions-2!", "!new-answers-2!", "!new-user-questions-3!", "!new-answers-3!"

  set "user-name=!new-user-name!"
  set "user-pass=!new-user-pass!"

  screens\list
)
