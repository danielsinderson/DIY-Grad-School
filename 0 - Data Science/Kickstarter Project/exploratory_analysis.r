library(tidyverse)

ks <- read_tsv("0 - Data Science/Kickstarter Project/38050-0001-Data.tsv")
glimpse(ks)


# find games and convert the USD variables to numeric values
games <- ks |>
  filter(CATEGORY == 12) |>
  mutate(
    GOAL_IN_USD = as.numeric(str_remove_all(str_sub(GOAL_IN_USD, 2, -1), ",")),
    PLEDGED_IN_USD = as.numeric(str_remove_all(str_sub(PLEDGED_IN_USD, 2, -1), ",")),
  )
glimpse(games)



# there are some extreme outliers in goal
games |>
  ggplot(aes(x = STATE, y = GOAL_IN_USD)) +
  geom_boxplot()

games |>
  ggplot(aes(x = GOAL_IN_USD)) +
  geom_density() +
  scale_x_log10()
