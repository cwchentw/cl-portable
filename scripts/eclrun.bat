@echo off

rem Get the root path of current batch script.
set rootdir=%~dp0

rem Check whether ECL is available.
%rootdir%\ecl2.exe --version 2>nul 1>&2 || (
    echo No ECL on the system >&2
    exit /B 1
)

rem Get the path of a Lisp script from first argument.
set script=%1

rem Check whether the Lisp script is valid.
rem Run in batch mode if %script% is a file.
if exist %script% goto batch_mode

rem Fallback to interactive mode.
goto interactive_mode

:batch_mode
rem Consume one argument, which is %script%
shift

set args=
:collect_args
set arg=%1
if not "x%arg%" == "x" (
    set args=%args% %arg%

    rem Consume one more argument.
    shift

    goto collect_args
)

%rootdir%\ecl2.exe ^
    --eval "(load (concatenate 'string (ext:getenv \"USERPROFILE\") \"/\" \".eclrc\"))" ^
    --encoding ":utf-8" ^
    --shell %script% %args%

rem Exit the program with inherited return value.
exit /B %ERRORLEVEL%

:interactive_mode
%rootdir%\ecl2.exe %*