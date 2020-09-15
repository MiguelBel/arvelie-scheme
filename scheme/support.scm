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
