#lang racket

(require "commons.rkt")
(require "chapter4.rkt")
(require "chapter6.rkt")

(define rember-f
  (lambda(test? a l)
    (cond
      ((null? l)(quote()))
      ((test? a (car l))
       (rember-f test? a (cdr l)))
      (else(cons(car l)
                (rember-f test? a (cdr l)))))))

(display "rember-f eq? tuna (shrimp salad and tuna salad):")(rember-f eq? "tuna" (list "shrimp" "salad" "and" "tuna" "salad"))

(define eq?-c
  (lambda(c)
    (lambda(x)
      (eq? c x))))

(define eq?-salad(eq?-c "salad"))
(display "eq?-salad salad:")(eq?-salad "salad")
(display "eq?-salad tuna:")(eq?-salad "tuna")

(define rember-f1
  (lambda(test?)
    (lambda(a l)
      (cond
        ((null? l)(quote()))
        ((test? a (car l))
         ((rember-f1 test?) a (cdr l)))
        (else(cons(car l)
                  ((rember-f1 test?) a (cdr l))))))))

(define rember-eq?(rember-f1 eq?))
(display "rember-eq? tuna (shrimp salad and tuna salad):")(rember-eq? "tuna" (list "shrimp" "salad" "and" "tuna" "salad"))
(display "(rember-f1 eq?) tuna (shrimp salad and tuna salad):")((rember-f1 eq?) "tuna" (list "shrimp" "salad" "and" "tuna" "salad"))
(display "(rember-f1 eq?) eq? (equal? eq? eqen? eqlist? eqpair?):")((rember-f1 eq?) "eq?" (list "equal?" "eq?" "eqen?" "eqlist?" "eqpair?"))

(define insert-g
  (lambda(seq)
    (lambda(new old l)
      (cond
        ((null? l)(quote()))
        ((eq? old (car l))
         (seq new old (cdr l)))
        (else(cons(car l)
                  ((insert-g seq)new old (cdr l))))))))

(define insertL (insert-g(lambda(new old l)(cons new (cons old l)))))
(display "insertL topping fudge (ice cream with fudge for dessert):")(insertL "topping" "fudge" (list "ice" "cream" "with" "fudge" "for" "dessert"))
(define insertR (insert-g(lambda(new old l)(cons old (cons new l)))))
(display "insertR topping fudge (ice cream with fudge for dessert):")(insertR "topping" "fudge" (list "ice" "cream" "with" "fudge" "for" "dessert"))

(define seqrem
  (lambda (new old l)
    l))

(define yyy
  (lambda (a l)
    ((insert-g seqrem) #f a l)))

(display "seqrem a b (c d):")(seqrem "a" "b" (list "c" "d"))
(display "yyy sausage (pizza with sausage and bacon):")(yyy "sausage" (list "pizza" "with" "sausage" "and" "bacon"))

(define atom-to-function
  (lambda(x)
    (cond
      ((eq? x "+") add?)
      ((eq? x "*") multiply?)
      (else ^))))

(define value4?
  (lambda(nexp)
    (cond
      ((atom? nexp)nexp)
      (else
       ((atom-to-function(operator nexp))
            (value4? (1st-sub-exp nexp))
            (value4? (2nd-sub-exp nexp)))))))

(define nexp4 (list "+" (list "*" 3 6) (list "^" 8 2)))
(display "value4? (+(* 3 6)(^ 8 2)):")(value4? nexp4)

(define multirember&co
  (lambda(a lat col)
    (cond
      ((null? lat)
       (col(quote())(quote())))
      ((eq?(car lat)a)
       (multirember&co a
                       (cdr lat)
                       (lambda(newlat seen)
                         (col newlat
                              (cons(car lat)seen)))))
      (else
       (multirember&co a
                       (cdr lat)
                       (lambda(newlat seen)
                         (col(cons(car lat)newlat)seen)))))))

(define a-friend
  (lambda(x y)
    (null? y)))

(display "multirember&co tuna (strawberries tune and swordfish) a-friend:")(multirember&co "tuna" (list "strawberries" "tune" "and" "swordfish") a-friend)
(display "multirember&co tuna () a-friend:")(multirember&co "tuna" (list ) a-friend)
(display "multirember&co tuna (tune) a-friend:")(multirember&co "tuna" (list "tune") a-friend)

(define new-friend
  (lambda(newlat seen)
    (a-friend newlat (cons "tune" seen))))

(display "multirember&co tuna (abd tune) new-friend:")(multirember&co "tune" (list "and" "tune") new-friend)

(define last-friend
  (lambda(x y)
    (length x)))

(display "multirember&co tuna (strawberries tune and swordfish) last-friend:")(multirember&co "tune" (list "strawberries" "tune" "and" "swordfish") last-friend)

(define multiinsertLR&co
  (lambda (new oldL oldR lat col)
    (cond
      ((null? lat)(col(quote()) 0 0))
      ((eq? oldL (car lat))
       (multiinsertLR&co new oldL oldR (cdr lat)
                         (lambda(newlat L R)
                           (col (cons new (cons oldL newlat)) (add1 L) R))))
      ((eq? oldR (car lat))
       (multiinsertLR&co new oldL oldR (cdr lat)
                         (lambda(newlat L R)
                           (col (cons oldR (cons new newlat)) L (add1 R)))))
      (else(multiinsertLR&co new oldL oldR (cdr lat)
                             (lambda(newlat L R)
                               (col (cons (car lat) newlat) L R)))))))

(define print
  (lambda(newlat L R)
    (display "(newlat:")
    (display newlat)
    (display ",L:")
    (display L)
    (display ",R:")
    (display R)
    (display ")")
    (newline)))

(display "multiinsertLR&co salty fish chips (chips and fish or fish and chips) print:")(multiinsertLR&co "salty" "fish" "chips" (list "chips" "and" "fish" "or" "fish" "and" "chips") print)

(define even?
  (lambda(n)
    (=(multiply?(divide? n 2)2)n)))

(define evens-only?
  (lambda(l)
    (cond
      ((null? l)(quote()))
      ((atom? (car l))
       (cond
         ((even? (car l))
          (cons (car l)
                (evens-only? (cdr l))))
         (else(evens-only? (cdr l)))))
      (else(cons(evens-only? (car l))
                (evens-only? (cdr l)))))))

(define l (list (list 9 1 2 8) 3 10 (list (list 9 9)7 6)2))
(display "evens-only? ((9 1 2 8) 3 10 ((9 9) 7 6) 2):")(evens-only? l)

(define evens-only*co
  (lambda(l col)
    (cond
      ((null? l)(col(quote()) 1 0))
      ((atom? (car l))
       (cond
         ((even? (car l))
          (evens-only*co (cdr l)
                         (lambda(newl p s)
                           (col (cons (car l) newl)
                                (multiply? (car l) p)
                                s))))
         (else(evens-only*co (cdr l)
                         (lambda(newl p s)
                           (col newl
                                p
                                (add? (car l) s)))))))
      (else(evens-only*co (car l)
                               (lambda(al ap as)
                                 (evens-only*co (cdr l)
                                                (lambda(dl dp ds)
                                                  (col (cons al dl)
                                                       (multiply? ap dp)
                                                       (add? as ds))))))))))

(define the-last-friend
  (lambda(newl product sum)
    (cons sum
          (cons product newl))))

(display "evens-only*co ((9 1 2 8) 3 10 ((9 9) 7 6) 2) the-last-friend:")(evens-only*co l the-last-friend)