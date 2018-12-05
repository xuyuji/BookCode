#lang racket

;定义函数atom?
(provide atom?)
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))