library(tidyverse)

diamonds
glimpse(diamonds)
?diamonds

diamonds |>
  ggplot(aes(x = carat)) +
  geom_histogram(binwidth = 0.25)

diamonds |>
  ggplot(aes(x = y)) +
  geom_histogram(binwidth = 0.25) +
  coord_cartesian(ylim = c(0, 50))

# convert y values of less than 3 or greater than 20 with NA
diamonds2 <- diamonds |>
  mutate(y = if_else(y < 3 | y > 20, NA, y))

diamonds2 |>
  ggplot(aes(x = x, y = y)) +
  geom_point(na.rm = TRUE)


diamonds |>
  ggplot(aes(x = price)) +
  geom_freqpoly(aes(color = cut), binwidth = 500, linewidth = 0.75)

diamonds |>
  ggplot(aes(x = price, y = after_stat(density))) +
  geom_freqpoly(aes(color = cut), binwidth = 500, linewidth = 0.75)

diamonds |>
  ggplot(aes(x = cut, y = price)) +
  geom_boxplot()


# reorder the boxplots based on the median hwy mpg of the class
mpg |>
  ggplot(aes(x = fct_reorder(class, hwy, median), y = hwy)) +
  geom_boxplot()


diamonds |>
  ggplot(aes(x = cut, y = color)) +
  geom_count()

diamonds |>
  count(color, cut) |>
  ggplot(aes(x = color, y = cut)) +
  geom_tile(aes(fill = n))

diamonds |>
  ggplot(aes(x = carat, y = price)) +
  geom_bin2d()

diamonds |>
  ggplot(aes(x = carat, y = price)) +
  geom_hex()

diamonds |>
  ggplot(aes(x = carat, y = price)) +
  geom_boxplot(aes(group = cut_width(carat, 0.1)))




# Exercises

diamonds |>
  ggplot(aes(x = x)) +
  geom_histogram(binwidth = 0.1)

diamonds |>
  ggplot(aes(x = y)) +
  geom_histogram(binwidth = 0.1)

diamonds |>
  ggplot(aes(x = z)) +
  geom_histogram(binwidth = 0.1)

diamonds |>
  ggplot(aes(x = price)) +
  geom_histogram(binwidth = 100)

diamonds |>
  filter(carat == 0.99) |>
  count()

diamonds |>
  filter(carat == 1.0) |>
  count()


diamonds |>
  ggplot(aes(x = price, y = carat)) +
  geom_smooth()

# carat appears to be the variable best correlated to price
# I'd do regression to test that hypothesis first though usually
diamonds |>
  ggplot(aes(x = price, y = carat)) +
  geom_smooth() +
  facet_grid(cut ~ clarity)

diamonds |>
  ggplot(aes(x = carat)) +
  geom_histogram(aes(fill = cut))

# this is the one that spells it out
# cut is inversely correlated to carat
# (it's harder to find diamonds that are both large and clear)
# and since carat is the main driver of price
# the lower quality diamonds have the highest average price
diamonds |>
  ggplot(aes(x = cut, y = carat)) +
  geom_boxplot()

library(lvplot)
diamonds |>
  ggplot(aes(x = cut, y = price)) +
  geom_lv()


diamonds |>
  ggplot(aes(x = price, y = cut)) +
  geom_violin()

diamonds |>
  ggplot(aes(x = price)) +
  geom_histogram() +
  facet_wrap(~cut)

diamonds |>
  ggplot(aes(x = price, color = cut)) +
  geom_freqpoly()

diamonds |>
  ggplot(aes(x = price, color = cut)) +
  geom_density()
