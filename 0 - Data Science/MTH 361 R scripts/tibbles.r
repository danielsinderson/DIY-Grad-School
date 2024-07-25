library(tibble)
library(tidyverse)

as_tibble(iris) # coerces a data.frame to a tibble

# tibble() makes a tibble from vectors (columns)
# tibble() reuses singular values to maintain a rectangular matrix
tibble(
    x = 1:5,
    y = 1,
    z = x^2 + y
)

# rewriting my last homework using the tibble() function
d <- c(1:12)
runs <- 1000000
results <- tibble(
    n = 1:runs,
    x1 = sample(d, runs, replace = TRUE),
    x2 = sample(d, runs, replace = TRUE),
    s = x1 + x2
)
head(results)
x <- filter(results, results[, 4] == 7) %>%
    count()
print(x / runs)


# tribble() makes a small tibble from its inputs
tribble(
    ~x, ~y, ~z,
    "a", 3, 4,
    "b", 1, 32
)


print(results)
print(results$s[1:10])
