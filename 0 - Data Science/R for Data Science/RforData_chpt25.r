library(tidyverse)
library(nycflights13)



df <- tibble(
  a = rnorm(5),
  b = rnorm(5),
  c = rnorm(5),
  d = rnorm(5),
)
df

df |> mutate(
  a = (a - min(a, na.rm = TRUE)) /
    (max(a, na.rm = TRUE) - min(a, na.rm = TRUE)),
  b = (b - min(b, na.rm = TRUE)) /
    (max(b, na.rm = TRUE) - min(b, na.rm = TRUE)),
  c = (c - min(c, na.rm = TRUE)) /
    (max(c, na.rm = TRUE) - min(c, na.rm = TRUE)),
  d = (d - min(d, na.rm = TRUE)) /
    (max(d, na.rm = TRUE) - min(d, na.rm = TRUE)),
)
df


rescale01 <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

df |> mutate(
  a = rescale01(a),
  b = rescale01(b),
  c = rescale01(c),
  d = rescale01(d),
)



# exercises

# turn the following into functions
x <- c(NA, 1, 2, 3, 4, NA, NA)
mean(is.na(x))

prop_na <- function(vec) {
  mean(is.na(vec))
}
prop_na(x)


x / sum(x, na.rm = TRUE)
prop_of_total <- function(vec) {
  vec / sum(vec, na.rm = TRUE)
}
prop_of_total(x)


round(x / sum(x, na.rm = TRUE) * 100, 1)
percent_of_total <- function(vec) {
  round(prop_of_total(vec) * 100, 1)
}
percent_of_total(x)
