(asdf:defsystem #:shepherd
  :description "Maintaining cron-like recurrent tasks at defined timeslots"
  :author "Alex Ermolov <aaermolov@gmail.com>"
  ;TODO: provide license clause
  :version "0.1"
  :depends-on (#:cl-cron)
  :serial t
  :components ((:file "src/package")
               (:file "src/main")))
