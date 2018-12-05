#lang racket

;definition function add?
(provide add?)
(define add?
  (lambda (x y)
    (cond
      ((zero? y) x)
      (else(add1 (add? x (sub1 y)))))))

;execute add?
(display "add? 46 12:")(add? 46 12)

;definition function sub?
(provide sub?)
(define sub?
  (lambda(x y)
    (cond
      ((zero? y) x)
      (else(sub1 (sub? x (sub1 y)))))))

;execute sub?
(display "sub? 14 3:")(sub? 14 3)
(display "sub? 17 9:")(sub? 17 9)
(display "sub? 18 25:")(sub? 18 25)

;definition function addtup
(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else
       (add? (car tup)(addtup (cdr tup)))))))

;execute addtup
(display "addtup (2 11 3 79 47 6):")(addtup (list 2 11 3 79 47 6))
(display "addtup (8 55 5 555):")(addtup (list 8 55 5 555))

;definition function multiply?
(provide multiply?)
(define multiply?
  (lambda (x y)
    (cond
      ((zero? y) 0)
      (else(add? x (multiply? x (sub1 y)))))))

;execute multiply?
(display "multiply? 5 3:")(multiply? 5 3)
(display "multiply? 13 4:")(multiply? 13 4)

;definition function tup+
(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1)tup2)
      ((null? tup2)tup1)
      (else(cons
       (add? (car tup1)(car tup2))
       (tup+ (cdr tup1)(cdr tup2)))))))

;execute tup+
(display "tup+ (3 6 9 11 4) (8 5 2 0 7):")(tup+ (list 3 6 9 11 4)(list 8 5 2 0 7))
(display "tup+ (3 7) (4 6 8 1):")(tup+ (list 3 7)(list 4 6 8 1))

;definition function >
(define >
  (lambda (x y)
  (cond
    ((zero? x)#f)
    ((zero? y)#t)
    (else
     (> (sub1 x)(sub1 y))))))

;execute >
(display "> 12 133:")(> 12 133)
(display "> 120 11:")(> 120 11)

;definition function <
(define <
  (lambda (x y)
    (cond
      ((zero? y)#f)
      ((zero? x)#t)
      (else(< (sub1 x)(sub1 y))))))

;exectue <
(display "< 4 6:")(< 4 6)
(display "< 8 3:")(< 8 3)
(display "< 6 6:")(< 6 6)

;definition function =
(define =
  (lambda (x y)
    (cond
      ((< x y)#f)
      ((> x y)#f)
      (else #t))))

;execute =
(display "2=3:")(= 2 3)
(display "2=2:")(= 2 2)

;definition function ^
(provide ^)
(define ^
  (lambda (x y)
    (cond
      ((zero? y) 1)
      (else(multiply? x (^ x (sub1 y)))))))

;execute ^
(display "1^1:")(^ 1 1)
(display "2^3:")(^ 2 3)
(display "5^3:")(^ 5 3)

;definition function divide?
(provide divide?)
(define divide?
  (lambda (x y)
    (cond
      ((< x y)0)
      (else(add1(divide? (sub? x y) y))))))

;execute divide
(display "divide 15 4:")(divide? 15 4)

;definition function length
(define length
  (lambda (lat)
    (cond
      ((null? lat)0)
      (else(add1(length(cdr lat)))))))

;execute length
(define lat (list "hotdogs" "with" "mustard" "sauerkraut" "and" "pickles"))
(display "length (hotdogs with mustard sauerkraut and pickles):")(length lat)

;definition function pick
(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n))(car lat))
      (else(pick(sub1 n)(cdr lat))))))

;execute pick
(define lat2 (list "lasagna" "spaghetti" "ravioli" "macaroni" "meatball"))
(display "pick 4 (lasagna spaghetti ravioli macaroni meatball):")(pick 4 lat2)

;definition function rempick
(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n))(cdr lat))
      (else(cons(car lat)
                (rempick (sub1 n)(cdr lat)))))))

;execute rempick
(define lat3 (list "hotdogs" "with" "hot" "mustard"))
(display "rempick 3 (hotdogs with hot mustard):")(rempick 3 lat3)

;definition function no-nums
(define no-nums
  (lambda (lat)
    (cond
      ((null? lat)(quote()))
      ((number? (car lat))(no-nums(cdr lat)))
      (else(cons(car lat)(no-nums(cdr lat)))))))

;execute no-nums
(define lat4 (list 5 "pears" 6 "prunes" 9 "dates"))
(display "no-nums (5 pears 6 prunes 9 dates):")(no-nums lat4)

;definition function all-nums
(define all-nums
  (lambda (lat)
    (cond
      ((null? lat)(quote()))
      ((number? (car lat))(cons(car lat)(all-nums(cdr lat))))
      (else(all-nums(cdr lat))))))

;execute all-nums
(display "all-nums (5 pears 6 prunes 9 dates):")(all-nums lat4)

;definition function eqan?
(define eqan?
  (lambda (a1 a2)
    (cond
      ((and(number? a1)(number? a2))
       (= a1 a2))
      ((or(number? a1)(number? a2))#f)
      (else(eq? a1 a2)))))

;execute eqan?
(display "eqan? 1 1:")(eqan? 1 1)
(display "eqan? 1 2:")(eqan? 1 2)
(display "eqan? a a:")(eqan? "a" "a")
(display "eqan? a b:")(eqan? "a" "b")
(display "eqan? 1 a:")(eqan? 1 "a")

;definition function occur
(define occur
  (lambda (a lat)
    (cond
      ((null? lat)0)
      ((eqan? a (car lat))
       (add1(occur a (cdr lat))))
      (else(occur a (cdr lat))))))

;execute occur
(display "occur a (a b a c a d):")(occur "a" (list "a" "b" "a" "c" "a" "d"))

;definition function one?
(define one?
  (lambda (x)
    (= x 1)))

;execute one?
(display "one? 1")(one? 1)
(display "one? 2")(one? 2)

;definition function rempick2
(define rempick2
  (lambda (n lat)
    (cond
      ((one? n)(cdr lat))
      (else
       (cons(car lat)
                (rempick2(sub1 n)(cdr lat)))))))

(define lat5 (list "lemon" "meringue" "salty" "pie"))
(display "rempick2 3 (lemon meringue salty pie):")(rempick2 3 lat5)