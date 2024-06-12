
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

print(cube_root(27))