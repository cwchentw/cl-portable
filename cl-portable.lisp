(in-package :cl-user)

(defpackage :cl-portable
  (:use :cl)
  (:documentation
    "Portable Common Lisp Code")
  (:export #-ccl :false
           #-ccl :true
           :quit-with-status
           :compile-program
           :argument-vector
           :argument-script
           :platform
           :getenv))

(in-package :cl-portable)

#-ccl (defconstant false nil "false is an alias to nil")
#-ccl (defconstant true t "true is an alias to t")

(defun quit-with-status (&optional status)
  "Quit a program with optional exit status in a portable way."
  (when (null status)  ;; Fallback to default status
    (setq status 0))   ;;  when no status is assigned.
  ;; Disable exit in Swank session.
  ;; Just return status code to the caller.
  #+swank  status
  ;; Exit a program when not in Swank session.
  #+sbcl   (sb-ext:quit :unix-status status)
  #+ccl    (if (string= "Microsoft Windows" (software-type))
               (ccl:external-call "exit" :int status)
               (ccl:quit status))
  #+clisp  (ext:quit status)
  #+ecl    (ext:quit status)
  #+abcl   (ext:quit :status status)
  ;; Fallback for uncommon CL implementation
  #-(or sbcl ccl clisp ecl abcl)
    (cl-user::quit status))

(defun compile-program (program main)
  (declare (string program) (function main))
  "Compile a program to an executable. Support SBCL, CCL and CLISP."
  #+sbcl  (sb-ext:save-lisp-and-die program
                                    :toplevel main
                                    :executable t)
  #+ccl   (ccl:save-application program
                                :toplevel-function main
                                :prepend-kernel t)
  #+clisp (ext:saveinitmem program
                           :init-function main
                           :executable t
                           :quiet t
                           :script nil)
  #-(or sbcl ccl clisp)
    (error "Unsupported Common Lisp implementation"))

(defun argument-vector ()
  (declare (ftype (function () list) argument-vector))
  "Unprocessed argv (argument vector)"
  #+sbcl   sb-ext:*posix-argv*
  #+ccl    ccl:*command-line-argument-list*
  #+clisp  ext:*args*
  #+abcl   ext:*command-line-argument-list*
  #+ecl    (ext:command-args)
  #-(or sbcl ccl clisp abcl ecl)
    (error "Unsupported Common Lisp implementation"))

(defun argument-script ()
  (declare (ftype (function () list) argument-vector))
  "Processed command-line argument(s) in scripting mode."
  (let* ((args (argument-vector))
         #+sbcl   (args (rest args))
         #+ccl    (args (rest (rest (rest (rest (rest (rest args)))))))
         #+abcl   (args (rest args))
         #+ecl    (args (rest (rest (rest args))))
         ;; In CLISP, no loading script in argument(s).
        )
    (cons *load-truename* args)))

(defun platform ()
  (declare (ftype (function () symbol) platform))
  "Detect platform type in a portable way."
  #+sbcl   (cond ((string= "Win32" (software-type)) :windows)
                 ((string= "Darwin" (software-type)) :macos)
                 ((string= "Linux" (software-type)) :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #+ccl    (cond ((string= "Microsoft Windows" (software-type)) :windows)
                 ((string= "Darwin" (software-type)) :macos)
                 ((string= "Linux" (software-type)) :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #+clisp  (cond ((not (not (find :win32 *features*))) :windows)
                 ((not (not (find :macos *features*))) :macos)
                 ((string= "Linux"
                           (let ((s (ext:run-program "uname"
                                                     :output :stream)))
                             (read-line s)))
                   :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #+ecl    (cond ((string= "NT" (software-type)) :windows)
                 ((string= "Darwin" (software-type)) :macos)
                 ((string= "Linux" (software-type)) :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #+abcl   (cond ((not (not (find :windows *features*))) :windows)
                 ((string= "Mac OS X" (software-type)) :macos)
                 ((string= "Linux" (software-type)) :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #-(or sbcl ccl clisp ecl abcl)
    (error "Unsupported Common Lisp implementation"))

(defun getenv (var &optional default)
  (or #+sbcl (sb-ext:posix-getenv var)
      #+ccl (ccl:getenv var)
      #+clisp (ext:getenv var)
      #+ecl (si:getenv var)
      #+abcl (ext:getenv var)
    default))