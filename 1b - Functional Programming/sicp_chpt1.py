# EXERCISES

# Exercise 1.8: Newton's Method for cube root
def cube_root(x:float, guess:float = 1.0, tolerance:float = 0.001) -> float:
    def close_enough(a:float) -> bool: 
        return abs(x - (a * a * a)) < tolerance
    def improve_guess(a:float) -> float:
        return ((x / (a * a)) + 2 * a) / 3
    def newtons_method(a:float) -> float:
        if close_enough(a):
            return a
        else:
            return newtons_method(improve_guess(a))
    
    return newtons_method(guess)


print(cube_root(9))
print(cube_root(27))


# Exercise 1.11
def f(n:int) -> int: 
    if n < 3:
        return n
    else:
        return f(n - 1) + 2*f(n - 2) + 3*f(n - 3)

print(f(14))


# prime test
def is_prime(n:float) -> bool:
    for x in range(2, int(n.sqrt())):
        if n % x == 0:
            return False
    return True

import random
num = random.randint(1, 123456789)
print(is_prime(num))