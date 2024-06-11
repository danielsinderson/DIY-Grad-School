; functions and conditionals

(defn sum-of-squares
  [a b]
  (+ (* a a) (* b b)))

(defn absolute-value-if
  [a]
  (if (< a 0)
    (* -1 a)
    a))

(defn absolute-value-cond
  [a]
  (cond 
    (< a 0) (* a -1)
    (>= a 0) a))

; ----- NEWTON'S METHOND EXERCISE -----
(defn average
  [x y]
  (/ (+ x y) 2))

(defn improve
  [guess x]
  (average guess x))

(defn good-enough?
  [guess x]
  (< (absolute-value-cond (- guess x)) 0.001))

(defn sqrt-iter
  [guess x]
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(defn sqrt 
  [x]
  (sqrt-iter 1.0 x))

(println (sqrt 9))

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

;---------------
