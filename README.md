# cl-portable

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Write portable Common Lisp code.

## System Requirements

One of the following Common Lisp implementations:

* [SBCL (Steel Bank Common Lisp)](http://www.sbcl.org/)
* [Clozure Common Lisp](https://ccl.clozure.com/)
* [CLISP](https://clisp.sourceforge.io/)
* [Embeddable Common Lisp](https://ecl.common-lisp.dev/)
* [ABCL (Armed Bear Common Lisp)](https://armedbear.common-lisp.dev/)

Among those implementations, SBCL is recommended for Lisp newcomers.

## Install

```shell
$ cd path/to/quicklisp/local-projects
$ git clone https://github.com/cwchentw/cl-portable.git
```

## Use the Library

### Compiler

* `compile-program`: compile a Common Lisp script in a portable way ([ex](/examples/compile-program.lisp))

### Console

* `argument-vector`: unprocessed command-line argument(s) as a list ([Windows](/examples/args.bat), [Unix](/examples/args))
* `argument-script`: command-line argument(s) as a list in scripting mode ([Windows](/examples/args.bat), [Unix](/examples/args))
* `pwd`: present working directory ([ex](/examples/pwd.lisp))

### System

* `env`: to get an environment variable ([ex](/examples/env.lisp))
* `platform`: to detect the underlying OS in a portable way
  * `:windows`: a Windows family OS
  * `:macos`: macOS
  * `:linux`: GNU/Linux
  * `:unix`: a Unix other than macOS and GUN/Linux
* `quit-with-status`: to `quit` in a portable way, returning an exit status code

## Use the Wrappers

### SBCL

* Install SBCL
* Copy the wrapper to a valid path of **PATH** ([Windows](/scripts/sbclrun.bat), [Unix](/scripts/sbclrun))

### Clozure CL

* Download a binary tarball of Clozure CL
* Add the root path of *ccl* to **PATH**
* Copy the wrapper to the root path of *ccl* ([Windows](/scripts/ccl.bat), [Unix](/scripts/ccl))

### CLISP

For Windows users:

* Download a binary tarball of CLISP
* Add the root path of *clisp* to **PATH**
* Copy [the wrapper](/scripts/clisprun.bat) to the root path of *clisp*

For Unix users:

* Install CLISP
* Copy [the wrapper](/scripts/clisprun) to a valid path of **PATH**

### ECL

For Windows users:

* Download a source tarball of ECL
* Compile ECL with MSVC
* Add *path\to\ecl\msvc* to **PATH**
* Copy [the wrapper](/scripts/eclrun.bat) to *path\to\ecl\msvc*

For Unix users:

* Install ECL
* Copy [the wrapper](/scripts/eclrun) to a valid path of **PATH**

### ABCL

* Install OpenJDK 17
* Download a binary tarball of ABCL
* Add the root path of *abcl* to **PATH**
* Copy the wrapper to the root path of *abcl* ([Windows](/scripts/abcl.bat), [Unix](/scripts/abcl))

## Copyright

Copyright (c) 2022 Michelle Chen. Licensed under MIT
