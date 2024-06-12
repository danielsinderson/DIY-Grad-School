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
(defn absolute-value [a]
  (if (< a 0)
    (* -1 a)
    a))

(defn cube-root [x guess tolerance]
  (defn close-enough? [a]
    (< (absolute-value (- (* a a a) x)) tolerance))
  
  (defn improve-guess [a]
    (/ (+ (/ x (* a a)) (* 2 a)) 3))
  
  (defn newtons-method [a]
    (if (close-enough? a) a (newtons-method (improve-guess a))))
  
  (float (newtons-method guess))
  )

(println (cube-root 27 1 0.001))

;---------------
; 1.11

(defn f [n]
  (if (< n 3) 
    n 
    (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(println (f 14))

; Prime test
(defn is-prime [n i]
  (if (> (* i i) n) 
    true
    (if (= 0 (mod n i))
      false
      (is-prime n (+ i 1)))))

(println (is-prime 111 2))
(println (is-prime 31 2))