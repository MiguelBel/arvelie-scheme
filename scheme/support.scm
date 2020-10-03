(define index
  (lambda (cislo l)
    (if (equal? (car l) cislo) 0 (+ 1 (index cislo (cdr l))))))

(define (p text)
  (display text)
  (newline))

(define (firsts number lst)
  (if (equal? 0 number)
    '()
    (cons (car lst)
          (firsts (- number 1) (cdr lst)))))

(define (nth n l)
  (if (or (> n (length l)) (< n 0))
    (error "Index out of bounds.")
    (if (eq? n 0)
      (car l)
      (nth (- n 1) (cdr l)))))
