(in-package :cl-user)

(defpackage :julian-test
  (:use :common-lisp :lisp-unit :julian))

(in-package :julian-test)

(defun div-by (x n)
  (= 0 (rem x n)))

(defun not-div-by (x n)
  (not (div-by x n)))

(defun is-leap (year)
  (or
   (div-by year 400)
   (and
    (div-by year 4)
    (not-div-by year 100))))

(define-test leap-years
    (let ((years (loop for i from 0 to 2100 collect i)))
      (loop for year in (remove-if-not #'is-leap years)
         do (assert-equal 366 (days-in-year year)))
      (loop for year in (remove-if #'is-leap years)
         do (assert-equal 365 (days-in-year year)))))

(define-test conversions
    (let ((years (loop for i from 0 to 2000 collect i))
          (months (loop for i from 1 to 12 collect i))
          (days (loop for i from 1 to 28 collect i)))
      (loop for year in years do
           (loop for month in months do
                (loop for day in days do
                     (let ((j (gregorian->julian year month day)))
                       (destructuring-bind (y m d) (julian->gregorian j)
                         (assert-equal year y)
                         (assert-equal month m)
                         (assert-equal day d))))))))

(run-tests)
