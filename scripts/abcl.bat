@echo off
rem Place the script to the root path of ABCL.

rem Check whether Java is available.
java -version >nul 2>&1 || (
    echo No Java on this system 1>&2
    exit /B 1
)

rem Get the root path of current batch script.
set rootdir=%~dp0

rem Check whether ABCL is available.
if not exist %rootdir%abcl.jar (
    echo No ABCL on this system >&2
    exit /B 1
)

if exist %rootdir%abcl-contrib.jar (
    set require_abcl_contrib=--eval "(require :abcl-contrib)"
) else (
    set require_abcl_contrib=

    echo No ABCL contrib JAR on the system >&2
    rem ABCL contrib JAR is not a mandatory part of ABCL.
    rem Hence, we don't exit the wrapper.
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

java -jar %rootdir%abcl.jar --noinform %require_abcl_contrib% --load %script% -- %args%
rem %script% is the first argument. Hence, there is no need to shift first argument.

rem Exit the program with inherited return value.
exit /B %ERRORLEVEL%

:interactive_mode
java -jar %rootdir%abcl.jar %require_abcl_contrib% %*
