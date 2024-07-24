library(tidyverse)

billboard
glimpse(billboard)
?billboard


# pivoting a table: one column into two
billboard_longer <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  ) |>
  mutate(week = parse_number(week))

billboard_longer |>
  ggplot(mapping = aes(x = week, y = rank, group = track)) +
  geom_line(alpha = 0.25) +
  scale_y_reverse()


# pivot longer: column contains multiple variables
who2
glimpse(who2)

who2 |>
  pivot_longer(
    cols = !(country:year),
    names_to = c("diagnosis", "gender", "age"),
    names_sep = "_",
    values_to = "count"
  )


# pivot longer: column contains variables and values
household
glimpse(household)

household |>
  pivot_longer(
    cols = !family,
    names_to = c(".value", "child"),
    names_sep = "_",
    values_drop_na = TRUE
  )


# pivot wider
cms_patient_experience
glimpse(cms_patient_experience)

cms_patient_experience |>
  pivot_wider(
    id_cols = starts_with("org"),
    names_from = measure_cd,
    values_from = prf_rate
  )
