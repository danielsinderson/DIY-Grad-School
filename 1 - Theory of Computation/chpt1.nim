

proc sum_of_squares(a:float, b:float): float = 
    return a*a + b*b

proc absolute_value(a: float): float = 
    if a < 0:
        return a * -1
    else:
        return a 

echo sum_of_squares(3, 4)
echo absolute_value(-35)

