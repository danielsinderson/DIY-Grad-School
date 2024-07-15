library(tidyverse)
library(nycflights13)


flights
glimpse(flights)
?flights


# find flights on January 1st with a departure delay of more than two hours
jan1_delayed <- flights |>
  filter(dep_delay > 120) |>
  filter(month == 1 & day == 1)

flights |>
  arrange(year, month, day, dep_time)


# create a new data frame that includes new columns
# one for speed and one for time gained in flight
# these new columns are placed at the front of the data frame
# and only the new columns and the columns used to generate them are kept
flights_with_gain_and_speed <- flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1,
    .keep = "used"
  )
glimpse(flights_with_gain_and_speed)


flights |>
  select(year, month, day)

flights |>
  select(contains("dep"))


flights |> select(contains("TIME")) # case insensitive


flights |>
  filter(dest == "IAH") |>
  mutate(speed = distance / air_time * 60) |>
  select(year:day, dep_time, carrier, flight, speed) |>
  arrange(desc(speed))


# find the average flight delay and number of flights in each month
flights |>
  group_by(month) |>
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    n()
  )


# find the worst arrival delay for each destination
# then more the destination column to the front for easy reference
flights |>
  group_by(dest) |>
  slice_max(arr_delay, n = 1) |>
  relocate(dest)






# Exercises
arrived_late <- flights |>
  filter(arr_delay >= 120)

flew_to_houston <- flights |>
  filter(dest %in% c("IAH", "HOU"))

carried_by_ua_aa_dl <- flights |>
  filter(carrier %in% c("UA", "AA", "DL"))

departed_in_summer <- flights |>
  filter(month %in% c(7, 8, 9))

arrived_late_dep_normal <- arrived_late |>
  filter(dep_delay <= 0)

delayed_but_fast <- flights |>
  filter(dep_delay >= 60 & dep_delay - arr_delay >= 30)
glimpse(delayed_but_fast)

flights |>
  arrange(desc(dep_delay))

flights |>
  arrange(hour, minute) |>
  glimpse()

flights |>
  arrange(air_time) |>
  glimpse()

# yes, there were flights every day
flights |>
  count(month, day) |>
  filter(n == 0)


# which carrier has the worst average delay
flights |>
  group_by(carrier) |>
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE)
  ) |>
  arrange(desc(avg_delay))

# most delayed flights from location
flights |>
  group_by(origin) |>
  slice_max(dep_delay, n = 1)

# plot how delays vary over the course of a day
flights |>
  group_by(hour) |>
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE)
  ) |>
  ggplot(mapping = aes(x = hour, y = avg_delay)) +
  geom_point() +
  geom_line()
