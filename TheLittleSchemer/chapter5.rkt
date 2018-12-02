#lang racket

(require "chapter4.rkt")

;定义函数atom?
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

;definition function rember*
(define rember*
  (lambda (a l)
    (cond
      ((null? l)(quote()))
      ((atom? (car l))
       (cond
         ((eq? a (car l))
          (rember* a (cdr l)))
         (else(cons(car l)
               (rember* a (cdr l))))))
      (else(cons(rember* a (car l))
        (rember* a (cdr l)))))))

;execute rember*
(define lat (list (list "coffee") "cup" (list (list "tea") "cup")(list "and" (list "hick")) "cup"))
(display "rember* cup ((coffee) cup ((tea) cup) (and (hick)) cup):")(rember* "cup" lat)

(define lat2 (list (list (list "tomato" "sauce"))(list (list "bean") "sauce")(list "and" (list (list "flying")))))
(display "rember* sauce (((tomato sauce)) ((bean) sauce) (and ((flying)))):")(rember* "sauce" lat2)

;definition function insertR*
(define insertR*
  (lambda (new old l)
    (cond
      ((null? l)(quote()))
      ((atom? (car l))
       (cond
         ((eq? old (car l))
          (cons old (cons new (insertR* new old (cdr l)))))
         (else(cons (car l)(insertR* new old (cdr l))))))
      (else(cons(insertR* new old (car l))
                (insertR* new old (cdr l)))))))

;execute insertR*
(define l (list (list "how" "much"(list "wood"))"could"(list (list "a"(list "wood")"chuck"))(list (list (list "chuck")))(list "if"(list "a")(list (list "wood" "chuck")))"could" "chuck" "wood"))
(display "insertR* roast chuck ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood):")(insertR* "roast" "chuck" l)

;definition function occur*
(define occur*
  (lambda (a l)
    (cond
      ((null? l)0)
      ((atom? (car l))
       (cond
         ((eq? a (car l))
          (add1 (occur* a (cdr l))))
         (else(occur* a (cdr l)))))
      (else(add?(occur* a (car l))
                (occur* a (cdr l)))))))

;execute occur*
(define l2 (list (list "banana")(list "split"(list (list (list (list "banana" "ice")))(list "cream"(list "banana"))"sherbet"))(list "banana")(list "bread")(list "banana" "brandy")))
(display "occur* banana ((banana) (split ((((banana ice))) (cream (banana)) sherbet)) (banana) (bread) (banana brandy)):")(occur* "banana" l2)

;definition function subst*
(define subst*
  (lambda (new old l)
    (cond
      ((null? l)(quote()))
      ((atom? (car l))
       (cond
         ((eq? old (car l))
          (cons new (subst* new old (cdr l))))
         (else(cons(car l)(subst* new old (cdr l))))))
      (else(cons(subst* new old (car l))
                (subst* new old (cdr l)))))))

;execute subst*
(display "subst* orange banana ((banana) (split ((((banana ice))) (cream (banana)) sherbet)) (banana) (bread) (banana brandy)):")(subst* "orange" "banana" l2)

;definition function insertL*
(define insertL*
  (lambda (new old l)
    (cond
      ((null? l)(quote()))
      ((atom? (car l))
       (cond
         ((eq? old (car l))
          (cons new (cons old (insertL* new old (cdr l)))))
         (else(cons (car l)(insertL* new old (cdr l))))))
      (else(cons(insertL* new old (car l))
                (insertL* new old (cdr l)))))))

;execute insertL*
(display "insertL* pecker chuck ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood):")(insertL* "pecker" "chuck" l)

;definition function member*
(define member*
  (lambda (a l)
    (cond
      ((null? l)#f)
      ((atom? (car l))
       (or(eq? a (car l))(member* a (cdr l))))
      (else(or (member* a (car l))(member* a (cdr l)))))))

;execute member*
(define l3 (list (list "potato")(list "chips"(list (list "with")"fish")(list "chips"))))
(display "member* chips ((potato) (chips ((with) fish) (chips))):")(member* "chips" l3)

;definition function leftmost
(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l))(car l))
      (else(leftmost (car l))))))

;execute leftmost
(display "leftmost ((potato) (chips ((with) fish) (chips))):")(leftmost l3)
(define l4 (list (list (list "host")(list "tuna"(list "and")))"cheese"))
(display "leftmost (((host) (tuna (and))) cheese):")(leftmost l4)

;definition function eqlist?
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and(null? l1)(null? l2))#t)
      ((or(null? l1)(null? l2))#f)
      ((and(atom? (car l1))
           (atom? (car l2)))
       (and(eq? (car l1)(car l2))
           (eqlist? (cdr l1)(cdr l2))))
      ((or(atom? (car l1))
          (atom? (car l2)))#f)
      (else(eqlist? (car l1)(car l2))
           (eqlist? (cdr l1)(cdr l2))))))

;execute eqlist?
(define l_a1 (list "strawberry" "ice" "cream"))
(define l_b1 (list "strawberry" "ice" "cream"))
(display "eqlist? l_a1 l_b1:")(eqlist? l_a1 l_b1)
(define l_a2 (list "strawberry" "ice" "cream"))
(define l_b2 (list "strawberry" "cream" "ice"))
(display "eqlist? l_a2 l_b2:")(eqlist? l_a2 l_b2)
(define l_a3 (list "banana"(list (list "split"))))
(define l_b3 (list (list "banana")(list "split")))
(display "eqlist? l_a3 l_b3:")(eqlist? l_a3 l_b3)
(define l_a4 (list "beef"(list (list "sausage"))(list "and"(list "soda"))))
(define l_b4 (list "beef"(list (list "sausage"))(list "and"(list "soda"))))
(display "eqlist? l_a4 l_b4:")(eqlist? l_a4 l_b4)

;definition function equal?
(define equal?
  (lambda(s1 s2)
    (cond
      ((and(atom? s1)(atom? s2))(eq? s1 s2))
      ((or(atom? s1)(atom? s2))#f)
      (else(eqlist? s1 s2)))))

(display "equal? a a:")(equal? "a" "a")
(display "equal? (a) (a):")(equal? (list "a") (list "a"))

;definition function eqlist2?
(define eqlist2?
  (lambda (l1 l2)
    (cond
      ((and(null? l1)(null? l2))#t)
      ((or(null? l1)(null? l2))#f)
      (else(and(equal? (car l1)(car l2))
               (eqlist2? (cdr l1)(cdr l2)))))))

;execute eqlist2?
(display "eqlist2? l_a1 l_b1:")(eqlist2? l_a1 l_b1)
