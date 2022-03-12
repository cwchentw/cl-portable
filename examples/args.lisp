;; Load cl-portable through Quicklisp silently.
#+quicklisp (ql:quickload "cl-portable" :silent t)
;; Alternatively, load a local cl-portable.lisp script.
#-quicklisp (load "cl-portable.lisp" :print nil)

(use-package 'cl-portable)

;; Simulate main function.
(defun main ()
  ;; Print out unprocessed arguments.
  (write-line "Unprocessed argument vector:")
  (write-line (princ-to-string (argument-vector)))
    
  (write-line "")  ; Separator.

  ;; Print out processed arguments.
  (write-line "Processed argument(s) in scripting mode:")
  (write-line (princ-to-string (argument-script)))

  #+ccl (finish-output)  ;; Trick for Clozure CL.
  (quit-with-status))

;; Assume args.lisp runs in scripting mode.
(main)
