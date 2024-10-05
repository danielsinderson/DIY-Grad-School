# install libraries for chapter
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# basic first glance at dataset
penguins # print first 10 rows of the data set
glimpse(penguins) # print column names and first several values of each
?penguins # helpful breakdown of the dataset


# comparing two numerical variables and a categorical variable
penguins |>
  ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Flipper Length and Body Mass",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species",
    caption = "Data comes from the palmerpenguins package."
  ) +
  scale_color_colorblind()



# plotting counts of a categorical variable
penguins |>
  ggplot(mapping = aes(x = fct_infreq(species))) +
  geom_bar()


# plotting distributions of a numerical variable
penguins |>
  ggplot(mapping = aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

penguins |>
  ggplot(mapping = aes(x = body_mass_g)) +
  geom_density()


# comparing a categorical and a numeric variable
penguins |>
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot()

penguins |>
  ggplot(mapping = aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(linewidth = 1.25, alpha = 0.3)


# comparing two categorical variables
penguins |>
  ggplot(mapping = aes(x = island, fill = species)) +
  geom_bar()

penguins |>
  ggplot(mapping = aes(x = island, fill = species)) +
  geom_bar(position = "fill")


# comparing two numerical and two categorical variables
# using facet_wrap for readability
penguins |>
  ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

# saves the most recently created plot to disk
ggsave(filename = "penguin-plot.png")









# Exercises
penguins |>
  ggplot(mapping = aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point()

penguins |>
  ggplot(mapping = aes(x = species, y = bill_depth_mm)) +
  geom_point()

penguins |>
  ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = bill_depth_mm, shape = species)) +
  geom_smooth(method = "glm") +
  labs(
    title = "Flipper Length and Body Mass",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Bill Depth", shape = "Species",
    caption = "Data comes from the palmerpenguins package."
  )

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

diamonds |>
  ggplot(mapping = aes(x = carat)) +
  geom_density()

diamonds |>
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.25, fill = "darkblue")
