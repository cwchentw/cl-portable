;; Load cl-portable through Quicklisp silently.
#+quicklisp (ql:quickload "cl-portable" :silent t)
;; Alternatively, load a local cl-portable.lisp script.
#-quicklisp (load "cl-portable.lisp" :print nil)

(use-package 'cl-portable)

;; Simulate a main function.
(defun main ()
  (princ (pwd))
  #+ccl (finish-output)
  (quit-with-status 0))

;; Load the main function.
(main)