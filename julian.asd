(defsystem julian
    :name "julian"
    :version "0.9.0"
    :author "Jason Lowdermilk <jlowdermilk@gmail.com>"
    :license "MIT"
    :description "Julian data conversion library"
    :long-description "Lisp implementation of the functions described
in 'Simple Formulae for Julian Day Numbers and Calendar Dates' by D.A.
Hatcher, R. Astr. Soc. 1984 (http://adsabs.harvard.edu/abs/1984QJRAS..25...53H)"
    :components
    ((:module "src"
              :components ((:file "julian")))))
