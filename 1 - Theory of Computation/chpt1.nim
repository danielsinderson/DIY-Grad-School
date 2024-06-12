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
proc f_recursive(n:int): int = 
    if n < 3:
        return n
    else:
        return f_recursive(n - 1) + 2*f_recursive(n - 2) + 3*f_recursive(n - 3)

echo f_recursive(14)
