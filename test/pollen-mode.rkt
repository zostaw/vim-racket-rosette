#lang pollen/mode racket

(define (bar)
  "BAR")

(define (foo)
  (displayln ◊~a{Foo is a ◊(bar)}))

(foo)
