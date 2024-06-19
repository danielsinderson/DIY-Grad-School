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
function f(n)
    if n < 3
        return n
    else
        return f(n - 1) + 2f(n - 2) + 3f(n - 3)
    end
end


println(f(14))


# prime test
function is_prime(n)
    for x in 2:sqrt(n)
        if n % x == 0
            return false
        end
    end
    return true
end

y = rand(2:123456789)
@time is_prime(y)
println("Is $y prime? $(is_prime(y))")