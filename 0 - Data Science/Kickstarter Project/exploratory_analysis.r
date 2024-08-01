library(tidyverse)

ks <- read_tsv("0 - Data Science/Kickstarter Project/38050-0001-Data.tsv")
glimpse(ks)

ks |>
  filter(CASEID == 506200) |>
  select(LAUNCHED_DATE)



# select variables of interest
# filter for tabletop games
# convert the USD variables to numeric values
# filter for games whose goal was <= $50,000 USD to cut most extreme outliers
games <- ks |>
  select(CASEID, SUBCATEGORY, GOAL_IN_USD:LAUNCHED_DATE, STATE) |>
  filter(SUBCATEGORY == 34) |>
  mutate(
    GOAL_IN_USD = as.numeric(str_remove_all(str_sub(GOAL_IN_USD, 2, -1), ",")),
    PLEDGED_IN_USD = as.numeric(str_remove_all(str_sub(PLEDGED_IN_USD, 2, -1), ",")),
    GOAL_SCALE = floor(log10(GOAL_IN_USD)),
    LAUNCHED_DATE = mdy(LAUNCHED_DATE),
    LAUNCH_YEAR = year(LAUNCHED_DATE),
    LAUNCH_MONTH = month(LAUNCHED_DATE),
    STATE = case_when(
      STATE == "canceled" ~ "not successful",
      STATE == "failed" ~ "not successful",
      STATE == "suspended" ~ "not successful",
      STATE == "successful" ~ "successful"
    ),
    SUCCEEDED = if_else(STATE == "successful", TRUE, FALSE)
  ) |>
  filter(GOAL_IN_USD >= 100 & GOAL_IN_USD <= 250000) |>
  filter(!is.na(LAUNCHED_DATE))



glimpse(games)


# there are some extreme outliers in goal
games |>
  ggplot(aes(x = STATE, y = GOAL_IN_USD)) +
  geom_boxplot()

# games |>
#   ggplot(aes(x = GOAL_IN_USD)) +
#   geom_density() +
#   scale_x_log10()



# total number of campaigns per year is increasing
games |>
  ggplot(aes(x = LAUNCH_YEAR, fill = STATE)) +
  geom_bar()


# success rate for tabletop games seeking <= $50,000 USD is increasing
games |>
  group_by(LAUNCH_YEAR) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED)) |>
  ggplot(aes(x = LAUNCH_YEAR, y = SUCCESS_RATE)) +
  geom_point() +
  geom_line()


# success rate for tabletop games seeking <= $50,000 USD
# is highest when launched in Jan, Feb, Mar, or Sep
games |>
  group_by(LAUNCH_MONTH) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED)) |>
  ggplot(aes(x = LAUNCH_MONTH, y = SUCCESS_RATE)) +
  geom_point() +
  geom_line() +
  scale_x_discrete(
    name = "Month",
    limits = c(
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    )
  )



# Success rate goes down as goal goes up
games |>
  group_by(GOAL_IN_USD) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED)) |>
  ggplot(aes(x = GOAL_IN_USD, y = SUCCESS_RATE)) +
  geom_point() +
  geom_smooth()

games |>
  ggplot(aes(x = GOAL_SCALE, fill = STATE)) +
  geom_histogram()

games |>
  group_by(GOAL_SCALE) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED))

games |>
  group_by(GOAL_SCALE) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED)) |>
  ggplot(aes(x = GOAL_SCALE, y = SUCCESS_RATE)) +
  geom_point() +
  geom_line() +
  scale_x_discrete(
    name = "Amount Asked For",
    limits = c(
      "",
      "$100s",
      "$1,000s",
      "$10,000s",
      "$100,000s"
    )
  )
