library(tidyverse)
library(nycflights13)



x <- c(1, 2, 3, 5, 7, 11, 13)
df <- tibble(x)
df |>
  mutate(y = x * 2)

flights |>
  filter(dep_time > 600 & dep_time < 2000 & abs(arr_delay) < 20)

flights |>
  mutate(
    daytime = dep_time > 600 & dep_time < 2000,
    approx_on_time = abs(arr_delay) < 20,
  ) |>
  filter(daytime & approx_on_time)

# to check if a value is NA, use the is.na() function, not the equality operator
# the equality operator (==) will always return NA
### since it doesn't know if x == NA, the result is NA
is.na(c(TRUE, NA, FALSE))
is.na(c(1, NA, 3))
is.na(c("a", NA, "b"))


flights |>
  filter(is.na(dep_time))


# using the subset operator []
flights |>
  group_by(year, month, day) |>
  summarise(
    behind = mean(arr_delay[arr_delay > 0], na.rm = TRUE),
    ahead = mean(arr_delay[arr_delay < 0], na.rm = TRUE),
    n = n(),
    .groups = "drop"
  )

# using a case statement
flights |>
  mutate(
    status = case_when(
      is.na(arr_delay) ~ "cancelled",
      arr_delay < -30 ~ "very early",
      arr_delay < -15 ~ "early",
      abs(arr_delay) <= 15 ~ "on time",
      arr_delay < 60 ~ "late",
      arr_delay < Inf ~ "very late",
    ),
    .keep = "used"
  )



# Exercices
near
test <- sqrt(2)^2
near(2, test)

missing_dep <- flights |>
  mutate(
    missing_dep = is.na(dep_time),
    missing_sched = is.na(sched_dep_time),
    missing_dep_delay = is.na(dep_delay),
    .keep = "used"
  )

missing_dep |>
  filter(missing_dep == TRUE |
    missing_sched == TRUE | # nolint: indentation_linter.
    missing_dep_delay == TRUE) |>
  count()

missing_dep |>
  count(missing_dep == TRUE)

missing_dep |>
  count(missing_sched == TRUE)

missing_dep |>
  count(missing_dep_delay == TRUE)

x <- c(1, 2, 3, NA, 5, NA, 7, NA, NA, NA, 11, NA, 13)
min(is.na(x)) # tells you if there are any that aren't NA
sum(is.na(x)) # tells you how many NA values there are
mean(is.na(x)) # tells you the proportion of values that are NA
prod(is.na(x)) # tells you if there are any that aren't NA, like min


y <- c(1:20)
if_else(y %% 2 == 0, "even", "odd")

days <- c(
  "Sunday", "Monday", "Tuesday", "Wednesday",
  "Thursday", "Friday", "Saturday"
)
if_else(days %in% c("Sunday", "Saturday"), "Weekend", "Weekday")

flights |>
  mutate(
    holiday = case_when(
      month == 1 & day == 1 ~ "New Year's Day",
      month == 7 & day == 4 ~ "Independence Day",
      month == 10 & day == 31 ~ "Halloween",
      month == 12 & day == 24 ~ "Christmas Eve",
      month == 12 & day == 25 ~ "Christmas Day",
      month == 12 & day == 31 ~ "New Year's Eve",
      .default = "No Holiday"
    ),
    .keep = "used"
  ) |>
  count(holiday)
