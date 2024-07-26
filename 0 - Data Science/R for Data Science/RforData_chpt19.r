library(tidyverse)
library(nycflights13)


airlines # primary key = carrier
airports # primary key = faa
planes # primary key = tailnum
weather # primary key = time_hour x origin  <- compound key

# check that tailnum is the primary key by ensuring it's unique across rows
planes |>
  count(tailnum) |>
  filter(n > 1)

# then check that there are no missing values of the primary key
# a missing value can't identify an observation!
planes |>
  filter(is.na(tailnum))


# do the same checks for the compound primary key in weather
weather |>
  count(time_hour, origin) |>
  filter(n > 1)

weather |>
  filter(is.na(time_hour) | is.na(origin))



# let's try to find a key (or compound key) that can uniquely identify flights
glimpse(flights)
flights |>
  count(time_hour, carrier, flight) |>
  filter(n > 1)

# looking good so far: all existing identifiers uniquely map to an observation
# however! a simpler option might be to use a surrogate key based on row number

flights2 <- flights |>
  mutate(id_number = row_number(), .before = 1)
flights2




# Exercises
weather |>
  count(year, month, day, hour, origin) |>
  filter(n > 1)

weather |>
  filter(year == 2013 & month == 11 & day == 3 & hour == 1)

flights |>
  filter(year == 2013 & month == 11 & day == 3)

# Mutating Joins
left_join(df1, df2, join_by(P(c1, c2))) # joins right to left, NA where no match
right_join(df1, df2, join_by(P(c1, c2))) # joins left to right, NA where no match
inner_join(df1, df2, join_by(P(c1, c2))) # joins the intersection of the rows
full_join(df1, df2, join_by(P(c1, c2))) # joins the union of the rows

# Filtering Joins
semi_join(df1, df2, join_by(P(c1, c2))) # filter df1 rows based on link to df2
anti_join(df1, df2, join_by(P(c1, c2))) # opposite of semi_join


flights2 |>
  left_join(planes, join_by(tailnum))


flights2 |>
  left_join(airports, join_by(dest == faa))


airports |>
  semi_join(flights2, join_by(faa == origin))
