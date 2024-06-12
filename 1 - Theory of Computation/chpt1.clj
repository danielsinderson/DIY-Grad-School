;----------------
;EXERCISES
;----------------

; 2
(println (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7))))

; 3: Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
(defn sum-two-largest-squares
  [a b c]
  (cond
    (and (< a b) (< a c)) (+ (* b b) (c c))
    (and (< b a) (< b c)) (+ (* a a) (c c))
    (and (< c a) (< c b)) (+ (* a a) (b b))))

; 8: Newton's Method for cube roots
(defn cube-root [x guess tolerance]
  (defn close-enough? [a]
    (< (abs (- (* a a a) x)) tolerance))
  
  (defn improve-guess [a]
    (/ (+ (/ x (* a a)) (* 2 a)) 3))
  
  (defn newtons-method [a]
    (if (close-enough? a) a (newtons-method (improve-guess a))))
  
  (float (newtons-method guess))
  )

(println (cube-root 27 1 0.001))

;---------------
; 1.11

(defn f-recursive [n]
  (if (< n 3) 
    n 
    (+ (f-recursive (- n 1)) (* 2 (f-recursive (- n 2))) (* 3 (f-recursive (- n 3))))))

(println (f-recursive 14))