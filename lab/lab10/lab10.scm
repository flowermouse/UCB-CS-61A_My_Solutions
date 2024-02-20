(define (over-or-under num1 num2) 
  (if (= num1 num2) 0
  (if (< num1 num2) -1 1)))

(define (make-adder num) 
  (define (add x) (+ num x))
  add)

(define (composed f g) 
  (define (helper x)
    (f (g x)))
  helper)

(define (repeat f n) 
  (define (helper x)
    (if (= n 1) (f x)
    (f ((repeat f (- n 1)) x))))
  helper)

(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (> a b)
      b
      a))

(define (gcd a b) 'YOUR-CODE-HERE)
