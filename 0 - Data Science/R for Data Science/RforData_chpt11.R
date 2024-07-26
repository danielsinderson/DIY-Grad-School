library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    color = "Car type",
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception
                because of their light weight",
    caption = "Data from fueleconomy.gov"
  )


df <- tibble(
  x = 1:10,
  y = cumsum(x^2)
)
# possible to use mathematical notation in labels as well
ggplot(df, aes(x, y)) +
  geom_point() +
  labs(
    x = quote(x[i]),
    y = quote(sum(x[i]^2, i == 1, n))
  )


#### ANNOTATIONS
# created a new dataframe containing the largest engine
# from each drive train, and labeled the drive train
# with a more informative name (eg. "4-wheel drive" vs "4")
label_info <- mpg |>
  group_by(drv) |>
  arrange(desc(displ)) |>
  slice_head(n = 1) |>
  mutate(
    drive_type = case_when(
      drv == "f" ~ "front-wheel drive",
      drv == "r" ~ "rear-wheel drive",
      drv == "4" ~ "4-wheel drive"
    )
  ) |>
  select(displ, hwy, drv, drive_type)

label_info

# Then plotted the highway MPG vs the engine size
# categorized by drive train, and then using the
# new dataframe to add labels for each at the end (largest engine spot)
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point(alpha = 0.3) +
  geom_smooth(se = FALSE) +
  geom_text(
    data = label_info,
    aes(x = displ, y = hwy, label = drive_type),
    fontface = "bold", size = 5, hjust = "right", vjust = "bottom"
  ) +
  theme(legend.position = "none")

# fixing the overlapping with ggrepel
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point(alpha = 0.3) +
  geom_smooth(se = FALSE) +
  geom_label_repel(
    data = label_info,
    aes(x = displ, y = hwy, label = drive_type),
    fontface = "bold", size = 5, nudge_y = 2
  ) +
  theme(legend.position = "none")


# highlighting possible outliers
potential_outliers <- mpg |>
  filter(hwy > 40 | (hwy > 20 & displ > 5))

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_text_repel(data = potential_outliers, aes(label = model)) +
  geom_point(data = potential_outliers, color = "red") +
  geom_point(
    data = potential_outliers,
    color = "red", size = 3, shape = "circle open"
  )



# pointing out a trend with a line and short text
trend_text <- "Larger engine sizes tend to have lower fuel economy." |>
  str_wrap(width = 30)
trend_text

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  annotate(
    geom = "label", x = 3.5, y = 38,
    label = trend_text,
    hjust = "left", color = "red"
  ) +
  annotate(
    geom = "segment",
    x = 3, y = 35, xend = 5, yend = 25, color = "red",
    arrow = arrow(type = "closed")
  )

# Exercises
glimpse(mpg)
mpg |>
  ggplot(aes(x = cty, y = hwy, color = drv, shape = drv)) +
  geom_point() +
  labs(
    x = "City MPG",
    y = "Highway MPG",
    color = "Drive train",
    shape = "Drive train"
  )

diamonds |>
  ggplot(aes(x = cut, y = carat)) +
  geom_boxplot() +
  labs(
    title = "High Carat Diamonds More Common with Poor Cut",
    subtitle = "Explaining higher average price for fair diamonds over ideal",
    x = "Quality of the Diamond's Cut",
    y = "Distribution of Diamond's Carat"
  )


mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() +
  annotate(
    geom = "point",
    x = (7 / 2) + 1, y = (45 / 2) + 5, color = "red",
    arrow = arrow(type = "closed")
  ) +
  annotate(
    geom = "label", x = (7 / 2) + 0.625, y = (45 / 2) + 5.5,
    label = "This is a middle dot",
    hjust = "left", color = "red"
  )
