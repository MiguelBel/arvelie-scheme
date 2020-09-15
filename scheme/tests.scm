(load "arvelie.scm")

(define (runner method argument expectation)
  (define result
    (method argument))

  (define pass?
    (string=? result expectation))

  (if (not (false? pass?))
    (p pass?)
    (p (string-append result " IS NOT " expectation)))
  pass?)

(runner arvelie-to-gregorian "04A02" "2004-01-02")
(runner arvelie-to-gregorian "20P02" "2020-07-30")
(runner arvelie-to-gregorian "19P02" "2019-07-31")
(runner arvelie-to-gregorian "55Z02" "2055-12-18")
(runner arvelie-to-gregorian "20E04" "2020-02-29") ; leap year
(runner arvelie-to-gregorian "20E05" "2020-03-01") ; leap year
(runner arvelie-to-gregorian "19Z14" "2019-12-30") ; last day
(runner arvelie-to-gregorian "19+01" "2019-12-31") ; last day
(runner arvelie-to-gregorian "20+01" "2020-12-30") ; last day + leap year
(runner arvelie-to-gregorian "20+02" "2020-12-31") ; last day + leap year

(runner gregorian-to-arvelie "2019-07-30" "19P01")
(runner gregorian-to-arvelie "2019-07-31" "19P02")
(runner gregorian-to-arvelie "2020-02-29" "20E04") ; leap year
(runner gregorian-to-arvelie "2020-03-01" "20E05") ; leap year
(runner gregorian-to-arvelie "2019-12-29" "19Z13") ; last day
(runner gregorian-to-arvelie "2019-12-31" "19+01") ; last day
(runner gregorian-to-arvelie "2020-12-30" "20+01") ; last day + leap year
(runner gregorian-to-arvelie "2020-12-31" "20+02") ; last day + leap year

;(runner valid-gregorian "2020-12-31" #t)
