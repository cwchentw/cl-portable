;; Load cl-portable through Quicklisp silently.
#+quicklisp (ql:quickload "cl-portable" :silent t)
;; Alternatively, load a local cl-portable.lisp script.
#-quicklisp (load "cl-portable.lisp" :print nil)

(import 'cl-portable::env)
(import 'cl-portable::platform)
(import 'cl-portable::quit-with-status)

;; Simulate a main function.
(defun main ()
  (if (equal :windows (platform))
                       ;; HOME equivalent on Windows
      (write-line (env "USERPROFILE"))
      (write-line (env "HOME")))
  #+ccl (finish-output)  ; Trick for Clozure CL.
  (quit-with-status 0))

;; Load the main function.
(main)