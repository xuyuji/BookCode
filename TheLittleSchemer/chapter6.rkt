#lang racket

(require "commons.rkt")
(require "chapter4.rkt")

;definition function numbered?
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp)(number? aexp))
      (else(and(numbered? (car aexp))
               (numbered? (car(cdr(cdr aexp)))))))))

(define aexp1 (list 3 "+" (list 4 "*" 5)))
(display "numbered? 3:")(numbered? 3)
(display "numbered? (3+(4*5)):")(numbered? aexp1)
(display "numbered? (2*sausage):")(numbered? (list 2 "*" "sausage"))

;definition function value?
(define value?
  (lambda (nexp)
    (cond
      ((atom? nexp)nexp)
      ((eq? "+" (car(cdr nexp)))
       (add? (value? (car nexp))
             (value? (car(cdr(cdr nexp))))))
      ((eq? "*" (car(cdr nexp)))
       (multiply? (value? (car nexp))
             (value? (car(cdr(cdr nexp))))))
      ((eq? "^" (car(cdr nexp)))
       (^ (value? (car nexp))
             (value? (car(cdr(cdr nexp)))))))))

(define nexp1 (list 1 "+" (list 3 "^" 4)))
(display "value? (1 + (3 ^ 4)):")(value? nexp1)

;definition function value2?
(define value2?
  (lambda (nexp)
    (cond
      ((atom? nexp)nexp)
      ((eq? "+" (car nexp))
       (add? (value2? (car (cdr nexp)))
             (value2? (car(cdr(cdr nexp))))))
      ((eq? "*" (car nexp))
       (multiply? (value2? (car (cdr nexp)))
                  (value2? (car(cdr(cdr nexp))))))
      ((eq? "^" (car nexp))
       (^ (value2? (car (cdr nexp)))
          (value2? (car(cdr(cdr nexp)))))))))

(define nexp2 (list "+" (list "*" 3 6) (list "^" 8 2)))
(display "value2? (+(* 3 6)(^ 8 2)):")(value2? nexp2)

;definition function 1st-sub-exp
(provide 1st-sub-exp)
(define 1st-sub-exp
  (lambda (aexp)
    (car(cdr aexp))))

;definition function 2nd-sub-exp
(provide 2nd-sub-exp)
(define 2nd-sub-exp
  (lambda (aexp)
    (car(cdr (cdr aexp)))))

;definition function operator
(provide operator)
(define operator
  (lambda (aexp)
    (car aexp)))

;definition function value3?
(define value3?
  (lambda (nexp)
    (cond
      ((atom? nexp)nexp)
      ((eq? "+" (operator nexp))
       (add?(value3? (1st-sub-exp nexp))
            (value3? (2nd-sub-exp nexp))))
      ((eq? "*" (operator nexp))
       (multiply? (value3? (1st-sub-exp nexp))
                  (value3? (2nd-sub-exp nexp))))
      ((eq? "^" (operator nexp))
       (^ (value3? (1st-sub-exp nexp))
          (value3? (2nd-sub-exp nexp)))))))

(display "value3? (+(* 3 6)(^ 8 2)):")(value3? nexp2)

;definition function sero?
;definition function edd1
;definition function zub?
;definition function edd?
