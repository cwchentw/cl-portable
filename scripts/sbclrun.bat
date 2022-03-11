@echo off

rem Check whether SBCL is available.
sbcl --version >nul 2>&1 || (
    echo No SBCL on the system >&2
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
rem %script% is the first argument. Hence, there is no need to shift first argument.
sbcl --noinform ^
  --eval "(setf sb-impl::*default-external-format* :UTF-8)" ^
  --eval "(load (concatenate 'string (sb-ext:posix-getenv \"USERPROFILE\") \"\\\\\" \".sbclrc\"))" ^
  --script %*

rem Exit the program with inherited return value.
exit /B %ERRORLEVEL%

:interactive_mode
sbcl %*