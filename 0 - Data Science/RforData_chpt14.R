library(tidyverse)
library(babynames)


str_c("Hello ", c("John", "Susan"))
str_c(c("Hello ", "Goodbye "), c("John ", "Susan "), "Smith")


df <- tibble(name = c("Flora", "David", "Terra", NA))
df |> mutate(greeting = str_c("Hi ", name, "!"))


df |>
  mutate(
    greeting1 = str_c("Hi ", coalesce(name, "you"), "!"),
    greeting2 = coalesce(str_c("Hi ", name, "!"), "Hi!")
  )


df |> mutate(greeting = str_glue("Hi {name}!"))


df <- tribble(
  ~name, ~fruit,
  "Carmen", "banana",
  "Carmen", "apple",
  "Marvin", "nectarine",
  "Terence", "cantaloupe",
  "Terence", "papaya",
  "Terence", "mandarin"
)
df |>
  group_by(name) |>
  summarize(fruits = str_flatten(fruit, ", "))


# split a column name into new rows (pivot longer)
df1 <- tibble(x = c("a,b,c", "d,e", "f"))
df1 |>
  separate_longer_delim(x, delim = ",")

df2 <- tibble(x = c("1211", "131", "21"))
df2 |>
  separate_longer_position(x, width = 1)


# split column name into new columns (pivot wider)
df3 <- tibble(x = c("a10.1.2022", "b10.2.2011", "e15.1.2015"))
df3 |>
  separate_wider_delim(
    x,
    delim = ".",
    names = c("code", "edition", "year")
  )
# use NA for a column name to omit it
df3 |>
  separate_wider_delim(
    x,
    delim = ".",
    names = c("code", NA, "year")
  )


df4 <- tibble(x = c("202215TX", "202122LA", "202325CA"))
df4 |>
  separate_wider_position(
    x,
    widths = c(year = 4, age = 2, state = 2)
  )



babynames |>
  count(length = str_length(name), wt = n)

babynames |>
  filter(str_length(name) == 15) |>
  count(name, wt = n, sort = TRUE)


x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)



# count names of different lengths
babynames |>
  count(length = str_length(name), wt = n)

# find the first and last letter of baby names
babynames |>
  mutate(
    first = str_sub(name, 1, 1),
    last = str_sub(name, -1, -1)
  )




# Exercises
e1 <- r"(He said "That's amazing!" before fainting.)"
print(e1)
e2 <- "He said \"That's amazing!\""
print(e2)
e3 <- "\\a\\b\\c"
print(e3)
e4 <- r"(\\\\\\)"
print(e4)
str_view(e4)



str_c("hi ", NA) # returns NA
paste0("hi ", NA) # paste0 replaces NA with "NA" then concatenates

str_c(letters[1:2], letters[1:3]) # str_c requires common multiple for cycling
paste0(letters[1:2], letters[1:3]) # paste0 doesn't

food <- "bananas"
price <- "$2.00"
str_c("The price of ", food, " is ", price)
str_glue("The price of {food} is {price}")

age <- "35"
country <- "the USA"
str_glue("I'm {age} years old and live in {country}")
str_c("I'm ", age, " years old and live in ", country)

title <- "Invisible Cities"
str_c("\\section{", title, "}")
str_glue("\\\\section{{{title}}}")


babynames |>
  mutate(middle = str_sub(
    name,
    ceiling(str_length(name) / 2),
    ceiling(str_length(name) / 2)
  ))

# look at trends in baby name first letters over time
glimpse(babynames)
babynames |>
  mutate(first = str_sub(name, 1, 1)) |>
  ggplot(aes(x = year, fill = first)) +
  geom_bar(position = "fill")
