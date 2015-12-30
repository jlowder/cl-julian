(in-package :cl-user)

(defpackage :julian
  (:use :common-lisp)
  (:export
   :julian->gregorian
   :gregorian->julian
   :day-of-year
   :days-in-year
   :days-in-month
   :leap-year-p
   :days-between))

(in-package :julian)

(defun a-prime (year month)
  (- year (truncate (/ (- 12 month) 10))))

(defun m-prime (month)
  (mod (- month 3) 12))

(defun j-y (year month)
  (truncate (* 365.25 (+ (a-prime year month) 4712))))

(defun j-d (month)
  (truncate (+ (* 30.6 (m-prime month)) 1/2)))

(defun j-n (year month day)
  (+ (j-y year month) (j-d month) day 59))

(defun j-g (year month)
  (- (truncate (* (truncate (+ (/ (a-prime year month) 100) 49)) 3/4)) 38))

(defun gregorian->julian (year month day)
  (- (j-n year month day) (j-g year month)))

(defun r-g (julian)
  (- (truncate (+ (* (truncate (/ (- julian 4479.5) 36524.25)) 3/4) 1/2)) 37))

(defun g-n (julian)
  (+ julian (r-g julian)))

(defun g-year (julian)
  (- (truncate (/ (g-n julian) 365.25)) 4712))

(defun g-d-prime (julian)
  (truncate (mod (- (g-n julian) 59.25) 365.25)))

(defun g-month (julian)
  (+ (mod (+ (truncate (/ (+ (g-d-prime julian) 1/2) 30.6)) 2) 12) 1))

(defun g-day (julian)
  (+ (truncate (mod (+ (g-d-prime julian) 1/2) 30.6)) 1))

(defun julian->gregorian (julian)
  (list (g-year julian) (g-month julian) (g-day julian)))

(defun day-of-year (year month day)
    (+ 1 (- (gregorian->julian year month day) (gregorian->julian year 1 1))))

(defun days-in-year (year)
  (- (gregorian->julian (+ 1 year) 1 1) (gregorian->julian year 1 1)))
    
(defun days-in-month (year month)
  (let ((julian (gregorian->julian year month 1)))
    (if (= 12 month)
        (- (gregorian->julian (1+ year) 1 1) julian)
        (- (gregorian->julian year (1+ month) 1) julian))))
        
(defun leap-year-p (year)
  (= 366 (days-in-year year)))

(defun days-between (year1 month1 day1 year2 month2 day2)
  (abs (- (gregorian->julian year2 month2 day2) (gregorian->julian year1 month1 day1))))
