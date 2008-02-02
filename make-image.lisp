;;; SBCL
#+sbcl
(progn
  (require 'asdf)
  (require 'stumpwm))
#+sbcl
(progn
  (load "stumpwm.asd")
  (sb-ext:save-lisp-and-die "stumpwm" :toplevel (lambda ()
                                                  ;; asdf requires sbcl_home to be set, so set it to the value when the image was built
                                                  (sb-posix:putenv (format nil "SBCL_HOME=~A" #.(sb-ext:posix-getenv "SBCL_HOME")))
                                                  (stumpwm:stumpwm)
                                                  0)
                            :executable t))

;;; CLISP

;; Is there a better way to use asdf.lisp than including it with stumpwm?
#+clisp
(progn
  (load "asdf.lisp")
  (load "stumpwm.asd")
  (load "/home/sabetts/cl/cl-ppcre-1.3.2/cl-ppcre.asd"))
#+clisp
(progn
  (asdf:oos 'asdf:load-op 'stumpwm))
#+clisp
(progn
  (ext:saveinitmem "stumpwm" :init-function (lambda ()
                                              (stumpwm:stumpwm)
                                              (ext:quit))
                   :executable t :keep-global-handlers t :norc t :documentation "The StumpWM Executable"))


#-(or sbcl clisp) (error "This lisp implementation is not supported.")
