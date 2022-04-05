;; Load cl-portable through Quicklisp silently.
#+quicklisp (ql:quickload "cl-portable" :silent t)
;; Alternatively, load a local cl-portable.lisp script.
#-quicklisp (load "cl-portable.lisp" :print nil)

(import 'cl-portable::quit-with-status)

;; Simulate a main function.
(defun main ()
  (write-line "你好，世界")
  (write-line "こんにちは世界")
  (write-line "안녕 세상")
  #+ccl (finish-output)  ; Trick for Clozure CL.
  (quit-with-status 0))

;; Load the main function.
(main)