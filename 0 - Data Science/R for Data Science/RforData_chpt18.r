library(tidyverse)

treatment <- tribble(
  ~person, ~treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, NA,
  "Katherine Burke", 1, 4
)

# fill(everything) fills in NA values from the surrounding (top/left) values
# it's used for when the NA values are being used as a data entry convenience
# when data is repeated across columns/rows
treatment |>
  fill(everything())


# coalesce(arr, x) replaces NA values with the value in x
x <- c(NA, 1, 2, 3, 4)
x |>
  coalesce(0)


# the opposite problem, na_if(arr, x) replaces x values with NA
x <- c(1, 4, 5, 7, -99)
na_if(x, -99)


stocks <- tibble(
  year  = c(2020, 2020, 2020, 2020, 2021, 2021, 2021),
  qtr   = c(1, 2, 3, 4, 2, 3, 4),
  price = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)

# complete will fill out the implicitly missing data from 2021 1st quarter
stocks |>
  complete(year, qtr)

# you can even increase the range of the values you want to "complete"
stocks |>
  complete(year = 2019:2021, qtr = 1:5)
