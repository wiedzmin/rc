(in-package #:shepherd)

(defmacro with-interactive-interrupt (&body body)
  `(handler-case
       (progn ,@body)
     (sb-sys:interactive-interrupt ()
       (format t "Exiting due to an interactive interrupt.~%")
       (sb-ext:exit :code 1))))

(defun get-now-timestamp ()
  (multiple-value-bind
        (second minute hour date month year day-of-week dst-p tz)
      (get-decoded-time)
    (format nil "[~2,'0d/~2,'0d/~d ~2,'0d:~2,'0d:~2,'0d (GMT~@d)]"
            date
            month
            year
            hour
            minute
            second
            (- tz))))

#+sbcl
(defun check-mail-personal-full ()
  (format t "~a Checking channel: aaermolov@gmail.com~%" (get-now-timestamp))
  (sb-impl::run-program "/usr/bin/mbsync" '("aaermolov@gmail.com")))

#+sbcl
(defun check-mail-personal-inbox ()
  (format t "~a Checking channel: aaermolov@gmail.com-inbox~%" (get-now-timestamp))
  (sb-impl::run-program "/usr/bin/mbsync" '("aaermolov@gmail.com-inbox")))

#+sbcl
(defun update-notmuch-db ()
  (format t "~a Updating notmuch DB~%" (get-now-timestamp))
  (sb-impl::run-program "/usr/bin/notmuch" '("new")))

#+sbcl
(defun cleanup-trash-and-spam ()
  (format t "~a Cleaning trash and spam~%" (get-now-timestamp))
  (sb-impl::run-program "/usr/bin/imapfilter" '()))

#+sbcl
(defun shepherd-main ()
  (with-interactive-interrupt
    (cl-cron:make-cron-job 'check-mail-personal-full :step-min 25)
    (cl-cron:make-cron-job 'check-mail-personal-inbox :step-min 5)
    (cl-cron:make-cron-job 'update-notmuch-db :step-min 2)
    (cl-cron:make-cron-job 'cleanup-trash-and-spam :step-min 60)
    (cl-cron:start-cron)
    (bordeaux-threads::join-thread cl-cron::*cron-dispatcher-thread*)))

#+sbcl
(defun save-image-shepherd ()
  (sb-ext:save-lisp-and-die "shepherd"
                            :compression t
                            :executable t
                            :toplevel #'shepherd-main))
