# Exercise 1.3
function sum_largest_squares(a, b, c)
    if a < b && a < c
        return b^2 + c^2
    elseif b < a && b < c
        return a^2 + c^2
    else
        return a^2 + b^2
    end
end

println(sum_largest_squares(5, 6, 4))

function sqrt_iter(guess, x)
    good_enough(a, b) = abs(a^2 - b) < 0.001 ? true : false
    improve_guess(a, b) = (a + b) / 2

    if good_enough(guess, x)
        guess
    else
        sqrt_iter(improve_guess(guess, x / guess), x)
    end
end

println(sqrt_iter(1, 2))

# Exercise 1.8
function newtons_cube_root(n, guess=1, threshold=0.001)
    function good_enough(a)
        if abs(n - a^3) < threshold
            return true
        else
            return false
        end
    end

    function improve_guess(a)
        return ((n / a^2) + 2 * a) / 3
    end

    function newtons_method(a)
        if good_enough(a)
            return a
        else
            newtons_method(improve_guess(a))
        end
    end

    return newtons_method(guess)
end

println(newtons_cube_root(27))


# 