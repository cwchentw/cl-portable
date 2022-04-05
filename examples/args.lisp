;; Load cl-portable through Quicklisp silently.
#+quicklisp (ql:quickload "cl-portable" :silent t)
;; Alternatively, load a local cl-portable.lisp script.
#-quicklisp (load "cl-portable.lisp" :print nil)

(import 'cl-portable::argument-script)
(import 'cl-portable::argument-vector)
(import 'cl-portable::quit-with-status)

;; Simulate a main function.
(defun main ()
  ;; Print out unprocessed arguments.
  (write-line "Unprocessed argument vector:")
  (write-line (princ-to-string (argument-vector)))
    
  (write-line "")  ; Separator.

  ;; Print out processed arguments.
  (write-line "Processed argument(s) in scripting mode:")
  (write-line (princ-to-string (argument-script)))

  #+ccl (finish-output)  ; Trick for Clozure CL.
  (quit-with-status))

;; Call the main function.
(main)
