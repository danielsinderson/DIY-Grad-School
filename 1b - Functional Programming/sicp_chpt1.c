

typedef enum { false, true } bool;

bool good_enough(float num, float guess, float tolerance) {
        return abs(num - (guess * guess * guess)) < tolerance;
}

float improve_guess(float num, float guess, float tolerance) {
        return ((num / (guess * guess)) + 2*guess) / 3;
}

float newtons_method(float num, float guess, float tolerance) {
    if (good_enough(num, guess, tolerance)) {
        return guess;
    }
    else {
        return improve_guess(num, guess, tolerance);
    }
}

float cube_root(float x, float guess, float tolerance) {
    return newtons_method(x, guess, tolerance);
}

