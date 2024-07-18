library(tidyverse)


mpg
glimpse(mpg)
?mpg


mpg |>
  ggplot(aes(x = displ, y = hwy, color = class)) +
  geom_point()


ggplot(mpg, aes(x = displ, y = hwy, linetype = drv)) +
  geom_smooth()


mpg |>
  ggplot(aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(aes(linetype = drv))


ggplot(diamonds, aes(x = cut)) +
  geom_bar()



# Exercises
mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(color = "pink", fill = "pink", shape = 2)

mpg |>
  ggplot(aes(x = displ, y = hwy, color = displ < 5)) +
  geom_point()


mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(lineweight = drv), se = FALSE)

mpg |>
  ggplot(aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE)

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(size = 5, color = "white") +
  geom_point(aes(color = drv), size = 3)

mpg |>
  ggplot(aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  facet_wrap(~cty)

ggplot(mpg) +
  geom_point(aes(x = drv, y = cyl))

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~cyl, nrow = 2)

ggplot(mpg, aes(x = displ)) +
  geom_histogram() +
  facet_grid(drv ~ .)

ggplot(mpg, aes(x = displ)) +
  geom_histogram() +
  facet_grid(. ~ drv)

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(drv ~ .)

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
