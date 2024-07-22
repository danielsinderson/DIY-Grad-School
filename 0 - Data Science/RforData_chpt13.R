library(tidyverse)
library(nycflights13)


x <- c("5.2", "1.3", "5e3")
parse_double(x)

# parse_number() strips non-numeric characters from the string to convert
x <- c("$1,234", "USD 3,513", "59%")
parse_number(x)

flights |>
  count(dest)

flights |>
  count(dest, sort = TRUE)

# count flights per destination (sort descending) and mean delay
flights |>
  group_by(dest) |>
  summarise(
    n = n(),
    delay = mean(arr_delay, na.rm = TRUE)
  ) |>
  arrange(desc(n))

# count distinct carriers that go to each destination (sort descending)
flights |>
  group_by(dest) |>
  summarise(
    carriers = n_distinct(carrier)
  ) |>
  arrange(desc(carriers))

# equivalent ways to count the distance traveled by each plane
# first uses summarize
flights |>
  group_by(tailnum) |>
  summarize(miles = sum(distance))

# second uses a weighted sum
flights |> count(tailnum, wt = distance)

# find the proportion of cancelled flights across the day
flights |>
  group_by(hour = sched_dep_time %/% 100) |>
  summarize(prop_cancelled = mean(is.na(dep_time)), n = n()) |>
  filter(hour > 1) |>
  ggplot(aes(x = hour, y = prop_cancelled)) +
  geom_line(color = "grey50") +
  geom_point(aes(size = n))


# using cut to split an array into bins
x <- c(1, 2, 5, 10, 15, 20)

cut(x, breaks = c(0, 5, 10, 15, 20))

cut(x,
  breaks = c(0, 5, 10, 15, 20),
  labels = c("sm", "md", "lg", "xl")
)


# Exercises

# count the number of flights with an unknown tail number
flights |> count(is.na(tailnum))


# remake the following transformations using group_by, summarize, and arrange
flights |> count(dest, sort = TRUE)
flights |> count(tailnum, wt = distance)

flights |>
  group_by(dest) |>
  summarize(n = n()) |>
  arrange(desc(n))

flights |>
  group_by(tailnum) |>
  summarize(
    miles = sum(distance)
  )

# find the 10 most delayed flights
flights |>
  mutate(delay_rank = min_rank(arr_delay)) |>
  relocate(delay_rank, .before = year) |>
  arrange(desc(delay_rank))


flights |>
  group_by(dest) |>
  filter(row_number() < 4)
flights |>
  group_by(dest) |>
  filter(row_number(dep_delay) < 4)
flights |> count(dest)

# find the mean departure delay of each hour in the day
# create a column for hour, group by datetime (to the hour), find the mean delay
flights |>
  mutate(hour = dep_time %/% 100) |>
  group_by(year, month, day, hour) |>
  summarize(
    dep_delay = mean(dep_delay, na.rm = TRUE),
    n = n(),
    .groups = "drop"
  ) |>
  filter(n > 5)


# find the destinations with the greatest variation in air speed
glimpse(flights)
flights |>
  mutate(air_speed = distance / air_time) |>
  group_by(dest) |>
  summarize(
    speed_var = sd(air_speed, na.rm = TRUE),
    .groups = "drop"
  ) |>
  arrange(desc(speed_var))
