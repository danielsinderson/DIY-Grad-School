# functions and conditionals

function sum_of_squares(a::Number, b::Number)::Number
    return a^2 + b^2
end


function absolute_value(a::Number)::Number
    if a < 0
        return -a
    else
        return a
    end
end

function sqrt_iter(guess, x)
    if (good_enough(guess, x))
        return guess
    else
        return sqrt_iter(improve(guess, x), x)
    end
end

function improve(guess, x)::Number
    return (guess + x) / 2
end

function good_enough(guess, x)::Number
    return abs(guess - x) < 0.001
end

sqrt_iter(1, 9)


