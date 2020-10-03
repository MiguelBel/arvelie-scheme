(load "support.scm")

(define gregorian-months-lengths
  (list 31 28 31 30 31 30 31 31 30 31 30 31))

(define leap-year-gregorian-months-lengths
  (list 31 29 31 30 31 30 31 31 30 31 30 31))

(define (leap-year? year)
  (define num-year
    (string->number year))

  (and
    (eq? (modulo num-year 4) 0)
    (or (not (eq? (modulo num-year 100) 0))
      (eq? (modulo num-year 400) 0))))

(define alphabet
  (list "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "+"))

(define (gregorian-months year)
  (if (leap-year? year)
    leap-year-gregorian-months-lengths
    gregorian-months-lengths))

(define (arvelie-to-gregorian arvelie-date)
  (define (arvelie-year date)
    (list (first date) (second date)))

  (define (arvelie-week date)
    (third date))

  (define (arvelie-day date)
    (list (fourth date) (fifth date)))

  (define (day-of-year date)
    (define week
      (index (string (arvelie-week date)) alphabet))
    (define days-in-week 14)
    (define weekday
      (string->number (apply string-append (map string (arvelie-day date)))))

    (+ weekday
      (* week days-in-week)))

  (define (gregorian-month day-of-year month-lengths)
    (define (find-month day lengths accum)
      (if (>= accum day)
        (- 12 (length lengths))
        (find-month day (cdr lengths) (+ accum (car lengths)))))
    (find-month day-of-year month-lengths 0))

  (define (gregorian-day day-of-year month-lengths)
    (define (find-day day lengths accum)
      (if (>= (+ accum (car lengths)) day)
        (- (car lengths) (- (+ accum (car lengths)) day))
      (find-day day (cdr lengths) (+ accum (car lengths)))))
    (find-day day-of-year month-lengths 0))

  (define year
    (apply string-append "20" (map string (arvelie-year (string->list arvelie-date)))))

  (define month
    (gregorian-month (day-of-year (string->list arvelie-date)) (gregorian-months year)))

  (define day
    (gregorian-day (day-of-year (string->list arvelie-date)) (gregorian-months year)))

  (string-append year "-" (string-pad-left (number->string month) 2 #\0) "-" (string-pad-left (number->string day) 2 #\0)))

(define (gregorian-to-arvelie gregorian-date)
  (define year
    (apply string-append
      (map string
       (list (third (string->list gregorian-date)) (fourth (string->list gregorian-date))))))

  (define gregorian-month
    (string->number
      (apply string-append
        (map string
          (list (sixth (string->list gregorian-date)) (seventh (string->list gregorian-date)))))))

  (define gregorian-day
    (string->number
      (apply string-append
        (map string
          (list (ninth (string->list gregorian-date)) (tenth (string->list gregorian-date)))))))

  (define gregorian-year
    (apply string-append
      (map string
       (list (first (string->list gregorian-date)) (second (string->list gregorian-date)) (third (string->list gregorian-date)) (fourth (string->list gregorian-date))))))

  (define day-of-year
    (+ gregorian-day (apply + (firsts (- gregorian-month 1) (gregorian-months gregorian-year)))))

  (define month
    (list-ref alphabet (floor (/ day-of-year 14))))

  (define day
    (* (- (/ day-of-year 14) (floor (/ day-of-year 14))) 14))

  (string-append year month (string-pad-left (number->string day) 2 #\0)))

(define (valid-gregorian gregorian-date)
  (define is-valid
    (and (> (string-length gregorian-date) 5)
         (<= (string-length gregorian-date) 10)
         (char-numeric? (nth 0 (string->list gregorian-date)))
         (char-numeric? (nth 1 (string->list gregorian-date)))
         (char-numeric? (nth 2 (string->list gregorian-date)))
         (char-numeric? (nth 3 (string->list gregorian-date)))
         (string=? (string (nth 4 (string->list gregorian-date))) "-")
         (char-numeric? (nth 5 (string->list gregorian-date)))
         (char-numeric? (nth 6 (string->list gregorian-date)))
         (string=? (string (nth 7 (string->list gregorian-date))) "-")
         (char-numeric? (nth 8 (string->list gregorian-date)))
         (char-numeric? (nth 9 (string->list gregorian-date)))
         (<= (string->number (list->string (list (nth 5 (string->list gregorian-date)) (nth 6 (string->list gregorian-date))))) 12)
         (> (string->number (list->string (list (nth 5 (string->list gregorian-date)) (nth 6 (string->list gregorian-date))))) 0)
         (<= (string->number (list->string (list (nth 8 (string->list gregorian-date)) (nth 9 (string->list gregorian-date))))) 31)
         (> (string->number (list->string (list (nth 8 (string->list gregorian-date)) (nth 9 (string->list gregorian-date))))) 0)
      )
    )

  (if is-valid
    gregorian-date
    #f))

(define (valid-arvelie arvelie-date)
  (define is-valid
    (and (= (string-length arvelie-date) 5)
         (char-numeric? (nth 0 (string->list arvelie-date)))
         (char-numeric? (nth 1 (string->list arvelie-date)))
         (char-numeric? (nth 3 (string->list arvelie-date)))
         (char-numeric? (nth 4 (string->list arvelie-date)))
         (<= (string->number (list->string (list (nth 3 (string->list arvelie-date)) (nth 4 (string->list arvelie-date))))) 14)
         (> (string->number (list->string (list (nth 3 (string->list arvelie-date)) (nth 4 (string->list arvelie-date))))) 0)
      )
    )

  (if is-valid
    arvelie-date
    #f))

(define (valid-date date)
  (if (or (valid-gregorian date) (valid-arvelie date))
    date
    (error "invalid input"))

)

(define (convert-arvelie date)
  (if (valid-date date)
    (if (valid-gregorian date)
      (gregorian-to-arvelie date)
      (arvelie-to-gregorian date))))