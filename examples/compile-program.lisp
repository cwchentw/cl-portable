;; Load cl-portable through Quicklisp silently.
#+quicklisp (ql:quickload "cl-portable" :silent t)
;; Alternatively, load a local cl-portable.lisp script.
#-quicklisp (load "cl-portable.lisp" :print nil)

(use-package 'cl-portable)

;; Simulate a main function.
(defun main ()
  (write-line "Hello World")
  ;; Trick for Clozure CL.
  #+ccl (finish-output)
  (quit-with-status 0))

;; Set a proper executable name
;;  according to current OS.
(if (equal :windows (platform))
    (defvar *program* "program.exe")
    (defvar *program* "program"))

(compile-program *program* #'main)
(quit-with-status)