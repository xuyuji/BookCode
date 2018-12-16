#lang racket

;定义函数atom?
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(display "atom test:")(atom? (quote ()))

;定义函数lat?
(define lat?
  (lambda (l)
    (cond
      ((null? l)#t)
      ((atom? (car l))(lat? (cdr l)))
      (else #f))))

;execute lat?
(define l (list "Jack" "Sprat" "could" "eat" "no" "chicken" "fat"))
(display "lat? (Jack Sprat could eat no chicken fat):")(lat? l)

(define l2 (list "Jack" (list "Sprat" "could") "eat" "no" "chicken" "fat"))
(display "lat? (Jack (Sprat could) eat no chicken fat):")(lat? l2)

;定义函数member
(provide member?)
(define member?
        (lambda (a lat)
          (cond
            ((null? lat) #f)
            (else
             (or
              (eq? a (car lat))(member? a (cdr lat)))))))

;execute member?
(define lat (list "fried" "eggs" "and" "scrambled" "eggs"))
(display "member? poached (fried eggs and scrambled eggs):")(member? "poached" lat)

(define lat2 (list "mashed" "potatoes" "and" "meat" "gravy"))
(display "member? meat (mashed potatoes and meat gravy):")(member? "meat" lat2)
