setlocal enabledelayedexpansion & : [pass, &result]
  set "result=y"
  set "if-or=n"
  set "char="
  set length=0
  set pass=%~1

  if "%~1" == "" (
    set "result=n"
    goto :end
  )

  : if is composed by just letters and numbers
  set /a length=!length! - 1
  for /l %%x in (0, 1, !length!) do (
    set char=!pass:~%%x,1!

    set "if-or=n"
    for %%y in (a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9) do (
      if "!char!" == "%%y" set "if-or=y"
    )

    if "!if-or!" == "n" (
      set "result=n"
      goto :end
    )
  )

  :end
(
  endlocal
  set "%~2=%result%"
  exit /b 0
)