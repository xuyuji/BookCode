#lang racket

;定义函数rember?
(define rember?
  (lambda(a lat)
    (cond
      ((null? lat)(quote ()))
      ((eq? a (car lat))(cdr lat))
      (else(cons (car lat)(rember? a (cdr lat)))))))

;execute rember?
(define lat (list "lamb" "chops" "and" "mint" "jelly"))
(display "rember? mint (lamb chops and mint jelly):")(rember? "mint" lat)

;定义函数first?
(define firsts?
  (lambda(l)
    (cond
      ((null? l)(quote ()))
      (else(cons
            (car(car l))
            (firsts? (cdr l)))))))

;execute firsts?
(define l (list (list "a" "b")(list "c" "d")(list "e" "f")))
(display "first? ((a b)(c d)(e f)):")(firsts? l)

;定义函数insertR
(define insertR?
  (lambda(new old lat)
    (cond
      ((null? lat)(quote ()))
      ((eq? old (car lat))(cons old (cons new (cdr lat))))
      (else(cons(car lat)(insertR? new old (cdr lat)))))))

;execute insertR
(define lat2 (list "ice" "cream" "with" "fudge" "for" "dessert"))
(display "insertR? topping fudge (ice cream with fudge for dessert):")(insertR? "topping" "fudge" lat2)

;定义函数insertL
(define insertL?
  (lambda(new old lat)
    (cond
      ((null? lat)(quote ()))
      ((eq? old (car lat))(cons new (cons old (cdr lat))))
      (else(cons(car lat)(insertL? new old (cdr lat)))))))

;execute insertL
(display "insertL? topping fudge (ice cream with fudge for dessert):")(insertL? "topping" "fudge" lat2)

;定义函数subst?
(define subst?
  (lambda(new old lat)
    (cond
      ((null? lat)(quote ()))
      ((eq? old (car lat))(cons new (cdr lat)))
      (else(cons(car lat)(subst? new old (cdr lat)))))))

;execute subst?
(display "subst? topping fudge (ice cream with fudge for dessert):")(subst? "topping" "fudge" lat2)

;定义函数subst2?
(define subst2?
  (lambda(new o1 o2 lat)
    (cond
      ((null? lat)(quote ()))
      ((or(eq? o1 (car lat))(eq? o2 (car lat)))
        (cons new (cdr lat)))
      (else (cons (car lat)(subst2? new o1 o2 (cdr lat)))))))

;execute subst2?
(define lat3 (list "banana" "ice" "cream" "with" "chocolate" "topping"))
(display "subst2? vanilla chocolate banana (banana ice cream with chocolate topping):")(subst2? "vanilla" "chocolate" "banana" lat3)

;定义函数multirember?
(define multirember?
  (lambda(a lat)
    (cond
      ((null? lat)(quote ()))
      ((eq? a (car lat))(multirember? a (cdr lat)))
      (else(cons (car lat)(multirember? a (cdr lat)))))))

;execute multirember?
(define lat4 (list "coffee" "cup" "tea" "cup" "and" "hick" "cup"))
(display "multirember? cup (coffee cup tea cup and hick cup):")(multirember? "cup" lat4)

;定义函数multiinsertR?
(define multiinsertR?
  (lambda(new old lat)
    (cond
      ((null? lat)(quote ()))
      ((eq? old (car lat))(cons old (cons new (multiinsertR? new old (cdr lat)))))
      (else(cons(car lat)(multiinsertR? new old (cdr lat)))))))

;execute multiinsertR?
(define lat5 (list "chips" "and" "fish" "or" "fish" "and" "fried"))
(display "multiinsertR? fried fish (chips and fish or fish and fried):")(multiinsertR? "fried" "fish" lat5)

;定义函数multiinsertL?
(define multiinsertL?
  (lambda(new old lat)
    (cond
      ((null? lat)(quote ()))
      ((eq? old (car lat))(cons new (cons old (multiinsertL? new old (cdr lat)))))
      (else(cons(car lat)(multiinsertL? new old (cdr lat)))))))

;execute multiinsertL?
(display "multiinsertL? fried fish (chips and fish or fish and fried):")(multiinsertL? "fried" "fish" lat5)

;定义函数multisubst?
(define multisubst?
  (lambda(new old lat)
    (cond
      ((null? lat)(quote ()))
      ((eq? old (car lat))(cons new (multisubst? new old (cdr lat))))
      (else(cons(car lat)(multisubst? new old (cdr lat)))))))

;execute multisubst?
(display "multisubst? fried fish (chips and fish or fish and fried):")(multisubst? "fried" "fish" lat5)