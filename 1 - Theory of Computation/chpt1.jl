# EXERCISES
# Exercise 1.8

function cube_root(x, guess=1, tolerance=0.001)
    close_enough(a) = abs(x - a^3) < tolerance
    improve_guess(a) = ((x / a^2) + 2a) / 3

    function newtons_method(y)
        if (close_enough(y))
            return y
        else
            newtons_method(improve_guess(y))
        end
    end

    return newtons_method(guess)
end

println(cube_root(27))


# Exercise 1.11
function f_recursive(n)
    if n < 3
        return n
    else
        return f_recursive(n - 1) + 2f_recursive(n - 2) + 3f_recursive(n - 3)
    end
end

function f_iterative(n)

end

println(f_recursive(14))
println(f_iterative(14))