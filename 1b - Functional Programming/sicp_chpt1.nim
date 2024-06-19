# EXERCISES

# Exercise 1.8: Newton's Method for cube root
proc cube_root(x:float, guess:float = 1.0, tolerance:float = 0.001): float = 
    proc close_enough(a:float): bool = abs(x - (a * a * a)) < tolerance
    proc improve_guess(a:float): float = ((x / (a * a)) + 2 * a) / 3

    proc newtons_method(a:float): float = 
        if close_enough(a):
            return a
        else:
            newtons_method(improve_guess(a))
    
    return newtons_method(guess)

echo cube_root(9)
echo cube_root(27)


# Exercise 1.11
proc f(n:int): int = 
    if n < 3:
        return n
    else:
        return f(n - 1) + 2*f(n - 2) + 3*f(n - 3)

echo f(14)


# prime test
import std/math
from std/random import rand
import std/times

proc is_prime(n:float): bool = 
    for x in 2 .. int(n.sqrt()):
        if n.floorMod(x.toFloat()) == 0:
            return false
    return true

let y = rand(123456789)
let time = cpuTime()
let p = is_prime(y.toFloat())
echo "Time taken: ", cpuTime() - time
echo p
