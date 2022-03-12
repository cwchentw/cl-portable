@echo off

rem Constants
set sbcl="sbcl"
set ccl="ccl"
set clisp="clisp"
set ecl="ecl"
set abcl="abcl"

rem Get the name of the script itself.
set self=%~n0%~x0

rem Get the root path of current batch script.
set rootdir=%~dp0

rem Get first argument.
set lisp=%1

if "" == "%lisp%" goto hint
if "/?" == "%lisp%" goto hint

if "usage" == "%lisp%" goto usage
if "help" == "%lisp%" goto usage

if %sbcl% == "%lisp%" goto runlisp
if %ccl% == "%lisp%" goto runlisp
if %clisp% == "%lisp%" goto runlisp
if %ecl% == "%lisp%" goto runlisp
if %abcl% == "%lisp%" goto runlisp

echo Unsupported Common Lisp implementation
exit /B 1

:hint
echo Use `%self% usage` or `%self% help` to show help info
exit /B 0

:usage
echo Usage: %self% [lisp] [param] ...
echo.
echo Valid Common Lisp implementation:
echo   sbcl
echo   ccl
echo   clisp
echo   ecl
echo   abcl
exit /B 0

:runlisp
rem Consume first argument.
shift

rem Collect remaining argument(s).
set args=
:collect_args
set arg=%1
shift
if "" neq "%arg%" set args=%args% %arg% && goto collect_args

rem Run specific Common Lisp implementation.
if %sbcl% == "%lisp%" goto runsbcl
if %ccl% == "%lisp%" goto runccl
if %clisp% == "%lisp%" goto runclisp
if %ecl% == "%lisp%" goto runecl
if %abcl% == "%lisp%" goto runabcl

rem Fallback as some error message.
echo Unknown Common Lisp implementation
exit /B 1

:runsbcl
sbclrun %rootdir%args.lisp %args%
exit /B 0

:runccl
rem `ccl` is a Clozure CL wrapper.
rem Hence, there is no need to add `--` here.
ccl %rootdir%args.lisp %args%
exit /B 0

:runclisp
clisp %rootdir%args.lisp %args%
exit /B 0

:runecl
ecl -shell %rootdir%args.lisp %args%
exit /B 0

:runabcl
rem `abcl` is an Armed Bear CL wrapper.
rem Hence, there is no need to add `--` here.
abcl %rootdir%args.lisp %args%
exit /B 0