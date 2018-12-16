#lang racket

(require "commons.rkt")
(require "chapter2.rkt")
(require "chapter3.rkt")

(define set?
  (lambda (lat)
    (cond
      ((null? lat)#t)
      ((member? (car lat)(cdr lat))#f)
      (else(set? (cdr lat))))))

(display "set? apple peaches apple plum:")(set? (list "apple" "peaches" "apple" "plum"))
(display "set? apple peaches pears plum:")(set? (list "apple" "peaches" "pears" "plum"))

(define makeset
  (lambda (lat)
    (cond
      ((null? lat)(quote()))
      ((member? (car lat)(cdr lat))
       (makeset (cdr lat)))
      (else(cons(car lat)
                (makeset (cdr lat)))))))

(display "makeset (apple peach pear peach plum apple lemon peach):")(makeset (list "apple" "peach" "pear" "peach" "plum" "apple" "lemon" "peach"))

(define makeset2
  (lambda (lat)
    (cond
      ((null? lat)(quote()))
      (else(cons(car lat)
            (makeset2
             (multirember? (car lat)(cdr lat))))))))

(display "makeset2 (apple peach pear peach plum apple lemon peach):")(makeset2 (list "apple" "peach" "pear" "peach" "plum" "apple" "lemon" "peach"))

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1)#t)
      ((member? (car set1) set2)
       (subset? (cdr set1) set2))
      (else #f))))

(display "subset? (5 chicken wings) (5 hmburgers 2 pieces fried chicken and light duckling wings):")(subset? (list 5 "chicken" "wings") (list 5 "hamburgers" 2 "pieces" "fried" "chicken" "and" "light" "duckling" "wings"))
(display "subset? (4 pounds of horseradish) (four pounds chicken and light duckling wings):")(subset? (list 4 "pounds" "of" "horseradish") (list "four" "pounds" "chicken" "and" "light" "duckling" "wings"))

(define subset2?
  (lambda (set1 set2)
    (cond
      ((null? set1)#t)
      (else(and(member? (car set1) set2)
               (subset? (cdr set1) set2))))))

(display "subset2? (5 chicken wings) (5 hmburgers 2 pieces fried chicken and light duckling wings):")(subset2? (list 5 "chicken" "wings") (list 5 "hamburgers" 2 "pieces" "fried" "chicken" "and" "light" "duckling" "wings"))
(display "subset2? (4 pounds of horseradish) (four pounds chicken and light duckling wings):")(subset2? (list 4 "pounds" "of" "horseradish") (list "four" "pounds" "chicken" "and" "light" "duckling" "wings"))

(define eqset?
  (lambda (set1 set2)
    (and
      (subset? set1 set2)
      (subset? set2 set1))))

(display "eqset? (6 large chickens with wings) (6 chickens with large wings):")(eqset? (list 6 "large" "chickens" "with" "wings") (list 6 "chickens" "with" "large" "wings"))

(define intersect?
  (lambda (set1 set2)
    (cond
      ((null? set1)#f)
      (else(or(member? (car set1) set2)
              (intersect? (cdr set1) set2))))))

(display "intersect? (stewed tomatoes and macaroni) (macaroni and cheese):")(intersect? (list "stewed" "tomatoes" "and" "macaroni") (list "macaroni" "and" "cheese"))

(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1)(quote()))
      ((member? (car set1) set2)(cons(car set1)(intersect (cdr set1) set2)))
      (else(intersect (cdr set1) set2)))))

(display "intersect (stewed tomatoes and macaroni) (macaroni and cheese):")(intersect (list "stewed" "tomatoes" "and" "macaroni") (list "macaroni" "and" "cheese"))

(define union
  (lambda (set1 set2)
    (cond
      ((null? set1)set2)
      ((member? (car set1) set2)
       (union (cdr set1) set2))
      (else(cons(car set1)
                (union (cdr set1) set2))))))

(display "union (stewed tomatoes and macaroni casserole) (macaroni and cheese):")(union (list "stewed" "tomatoes" "and" "macaroni" "casserole") (list "macaroni" "and" "cheese"))

(define intersectall
  (lambda (l-set)
    (cond
      ((null? (cdr l-set))(car l-set))
      (else(intersect (car l-set)
                      (intersectall (cdr l-set)))))))

(display "intersectall ((a b c)(c a d e)(e f g h a b)):")(intersectall (list (list "a" "b" "c")(list "c" "a" "d" "e")(list "e" "f" "g" "h" "a" "b")))
(display "intersectall ((6 pears and)(3 peaches and 6 peppers)(8 pears and 6 plums)(and 6 prunes with some apples)):")
(intersectall (list (list 6 "pears" "and")(list 3 "peaches" "and" 6 "peppers")(list 8 "pears" "and" 6 "plums")(list "and" 6 "prunes" "with" "some" "apples")))

(define a-pair?
  (lambda (x)
    (cond
      ((atom? x)#f)
      ((null? x)#f)
      ((null? (cdr x))#f)
      ((null? (cdr(cdr x)))#t)
      (else #f))))

(display "a-pair? (pear pear):")(a-pair? (list "pear" "pear"))

(define first
  (lambda (p)
    (car p)))

(define second
  (lambda (p)
    (car(cdr p))))

(define build
  (lambda (s1 s2)
    (cons s1 s2)))

(define third
  (lambda (p)
    (car(cdr(cdr p)))))

(define firsts
  (lambda (rel)
    (cond
      ((null? rel)(quote()))
      (else(cons(first(car rel))
                (firsts(cdr rel)))))))

(define fun?
  (lambda (rel)
    (set? (firsts rel))))

(display "fun? ((8 3)(4 2)(7 6)(6 2)(3 4)):")(fun? (list (list 8 3)(list 4 2)(list 7 6)(list 6 2)(list 3 4)))
(display "fun? ((d 4)(b 0)(b 9)(e 5)(g 4)):")(fun? (list (list "d" 4)(list "b" 0)(list "b" 9)(list "e" 5)(list "g" 4)))

(define revrel
  (lambda (rel)
    (cond
      ((null? rel)(quote()))
      (else(cons(build(second (car rel))
                      (first (car rel)))
                (revrel (cdr rel)))))))

(display "revrel ((8 a)(pumpkin pie)(got sick)):")(revrel (list (list 8 "a")(list "pumpkin" "pie")(list "got" "sick")))

(define revpair
  (lambda (rel)
    (build(second rel)(first rel))))

(display "revpair (1 2):")(revpair (list 1 2))

(define revrel2
  (lambda (rel)
    (cond
      ((null? rel)(quote()))
      (else(cons(revpair (car rel))
                (revrel2 (cdr rel)))))))

(display "revrel2 ((8 a)(pumpkin pie)(got sick)):")(revrel2 (list (list 8 "a")(list "pumpkin" "pie")(list "got" "sick")))

(define seconds
  (lambda (rel)
    (cond
      ((null? rel)(quote()))
      (else(cons(second(car rel))
                (seconds(cdr rel)))))))

(define fullfun?
  (lambda (rel)
    (set? (seconds rel))))

(display "fullfun? ((grape raisin)(plum prune)(stewed prune)):")(fullfun? (list (list "grape" "raisin")(list "plum" "prune")(list "stewed" "prune")))
(display "fullfun? ((grape raisin)(plum prune)(stewed grape)):")(fullfun? (list (list "grape" "raisin")(list "plum" "prune")(list "stewed" "grape")))

(define fullfun2?
  (lambda (rel)
    (fun? (revrel rel))))

(display "fullfun2? ((grape raisin)(plum prune)(stewed prune)):")(fullfun2? (list (list "grape" "raisin")(list "plum" "prune")(list "stewed" "prune")))
(display "fullfun2? ((grape raisin)(plum prune)(stewed grape)):")(fullfun2? (list (list "grape" "raisin")(list "plum" "prune")(list "stewed" "grape")))