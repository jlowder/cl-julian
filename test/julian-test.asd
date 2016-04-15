(defsystem julian-test
  :author "Jason Lowdermilk <jlowdermilk@gmail.com>"
  :license "MIT"
  :description "Unit tests for cl-julian"
  :depends-on (:lisp-unit
               :julian)
  :components ((:file "julian-test")))
