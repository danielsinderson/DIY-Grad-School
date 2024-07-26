library(tidyverse)
library(babynames)


str_view(fruit, "berry")
str_view(fruit, "a...e")
str_view(words, "[aeiou]x[aeiou]")
str_view(fruit, "apple|melon|nut")

str_detect(words, ".*ant")

# find the top babynames containing "x"
babynames |>
  filter(str_detect(name, "x")) |>
  count(name, wt = n, sort = TRUE)

# track the proportion of baby names containing "x" through the years
babynames |>
  group_by(year) |>
  summarize(prop_x = mean(str_detect(name, "x"))) |>
  ggplot(aes(x = year, y = prop_x)) +
  geom_line()

str_count(words, "[aeiou]te")
str_count(words, "e")


# count the number of vowels / consonants in baby names
babynames |>
  mutate(
    vowels = str_count(str_to_lower(name), "[aeiou]"),
    consonants = str_count(str_to_lower(name), "[^aeiou]")
  )


df <- tribble(
  ~str,
  "<Sheryl>-F_34",
  "<Kisha>-F_45",
  "<Brandon>-N_33",
  "<Sharon>-F_38",
  "<Penny>-F_58",
  "<Justin>-M_41",
  "<Patricia>-F_84",
)

df |>
  separate_wider_regex(
    str,
    patterns = c(
      "<",
      name = "[A-Za-z]+",
      ">-",
      gender = ".",
      "_",
      age = "[0-9]+"
    )
  )

str_view(fruit, "^a")
str_view(fruit, "a$")
str_view(fruit, "apple")
str_view(fruit, "^apple$")





# Exercises

# what baby name has the most vowels? == Maria Guadalupe
# what baby name has the highest proportion of vowels? == Eua
babynames_with_counts <- babynames |>
  mutate(
    name = str_to_lower(name),
    n_letters = str_count(name, "."),
    n_vowels = str_count(name, "[aeiou]"),
    n_consonants = str_count(name, "[^aeiou]"),
    prop_vowels = n_vowels / n_letters
  )

babynames_with_counts |>
  arrange(desc(n_vowels)) |>
  glimpse()

babynames_with_counts |>
  arrange(desc(prop_vowels)) |>
  glimpse()


# create a regex for telephone numbers
phone_number_pattern <- "[(][0-9]{3}[)][0-9]{3}-[0-9]{4}"
str_detect("(123)456-7890", phone_number_pattern)
