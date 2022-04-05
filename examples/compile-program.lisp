;; Load cl-portable through Quicklisp silently.
#+quicklisp (ql:quickload "cl-portable" :silent t)
;; Alternatively, load a local cl-portable.lisp script.
#-quicklisp (load "cl-portable.lisp" :print nil)

(import 'cl-portable::compile-program)
(import 'cl-portable::platform)
(import 'cl-portable::quit-with-status)

;; Simulate a main function.
(defun main ()
  (write-line "Hello World")
  #+ccl (finish-output)  ; Trick for Clozure CL.
  (quit-with-status 0))

;; Set a proper executable name according to current OS.
(if (equal :windows (platform))
    (defvar *program* "program.exe")
    (defvar *program* "program"))

;; Compile the script into an executable.
(compile-program *program* #'main)
;; Quit the script.
(quit-with-status)