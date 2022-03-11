;; Load cl-portable through Quicklisp silently.
#+quicklisp (ql:quickload "cl-portable" :silent t)
;; Alternatively, load a local cl-portable.lisp script.
#-quicklisp (load "cl-portable.lisp" :print nil)

(use-package 'cl-portable)

;; Simulate a main function.
(defun main ()
  (write-line "你好，世界")
  (write-line "こんにちは世界")
  (write-line "안녕 세상")
  ;; Trick for Clozure CL.
  #+ccl (finish-output)
  (quit-with-status 0))

;; Load the main function.
(main)