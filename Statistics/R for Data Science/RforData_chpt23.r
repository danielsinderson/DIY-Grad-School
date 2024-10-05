library(tidyverse)
library(repurrrsive)
library(jsonlite)


x1 <- list(1:4, "a", TRUE)
x1

x2 <- list(a = 1:2, b = 1:3, c = 1:4)
x2
x2$a
x2$b

str(x1)

x3 <- list(list(1, 2), list(3, 4))
str(x3)
view(x3)
x5 <- list(1, list(2, list(3, list(4, list(5)))))
str(x5)
view(x5)


df <- tibble(
  x = 1:2,
  y = c("a", "b"),
  z = list(list(1, 2), list(3, 4, 5))
)
df
df |>
  filter(x == 1)


# Rectangularizing
df1 <- tribble(
  ~x, ~y,
  1, list(a = 11, b = 12),
  2, list(a = 21, b = 22),
  3, list(a = 31, b = 32),
)

# unnest wider unnests list values into columns
# this works really well when each list in a column has the same # of elements
df1 |>
  unnest_wider(y)
df1 |>
  unnest_wider(y, names_sep = "_")


df2 <- tribble(
  ~x, ~y,
  1, list(11, 12, 13),
  2, list(21),
  3, list(31, 32),
)

df2 |>
  unnest_longer(y)

df6 <- tribble(
  ~x, ~y,
  "a", list(1, 2),
  "b", list(3),
  "c", list()
)
df6 |> unnest_longer(y)
df6 |> unnest_longer(y, keep_empty = TRUE)


repos <- tibble(json = gh_repos)
repos

unnested_repos <- repos |>
  unnest_longer(json) |>
  unnest_wider(json) |>
  select(id, full_name, owner, description) |>
  unnest_wider(owner, names_sep = "_")
glimpse(unnested_repos)


chars <- tibble(json = got_chars)
chars

characters <- chars |>
  unnest_wider(json) |>
  select(id, name, gender, culture, born, died, alive)
characters

chars |>
  unnest_wider(json) |>
  select(id, where(is.list))

chars |>
  unnest_wider(json) |>
  select(id, name, titles) |>
  unnest_longer(titles)

# unnest chars into columns, select id and titles columns,
# unnest titles into rows, filter out the rows without a title,
# and then renames the "titles" column to "title"
# THIS IS TO CREATE A RELATIONAL STRUCTURE
# much of the complicated nesting in the dataset can be replaced
# by creating a relational set of data tables instead,
# which will be much easier to work with
titles <- chars |>
  unnest_wider(json) |>
  select(id, titles) |>
  unnest_longer(titles) |>
  filter(titles != "") |>
  rename(title = titles)
titles




locations <- gmaps_cities |>
  unnest_wider(json) |>
  select(!status) |>
  unnest_longer(results) |>
  unnest_wider(results)
locations

# extract lat and long of location point
locations |>
  select(city, formatted_address, geometry) |>
  unnest_wider(geometry) |>
  unnest_wider(location)

# extract lat and long of ne corner and sw corner of rectangular bound around location
locations |>
  select(city, formatted_address, geometry) |>
  hoist(
    geometry,
    ne_lat = c("bounds", "northeast", "lat"),
    sw_lat = c("bounds", "southwest", "lat"),
    ne_lng = c("bounds", "northeast", "lng"),
    sw_lng = c("bounds", "southwest", "lng"),
  )






# A path to a json file inside the package:
gh_users_json()

# Read it with read_json()
gh_users2 <- read_json(gh_users_json())

# Check it's the same as the data we were using previously
identical(gh_users, gh_users2)


str(parse_json("1"))
str(parse_json("[1, 2, 3]"))
str(parse_json("{\"x\": [1, 2, 3]}"))


json <- '[
  {"name": "John", "age": 34},
  {"name": "Susan", "age": 27}
]'
df <- tibble(json = parse_json(json))
df
df |>
  unnest_wider(json)





# exercises

dfe1 <- tribble(
  ~x, ~y,
  1, list("a", "z"),
  2, list("b", "y"),
  3, list("c", "x"),
  4, list(NA)
)

# when list elements aren't named, names_sep is a necessary argument
# when unnest_wider encounters a missing value it supplies an NA value
dfe1 |>
  unnest_wider(y, names_sep = "_")


# named elements get turned to rows, and their name gets turned to a new column
df1 |>
  unnest_longer(y)

# setting indices_include = FALSE will suppress the added column
df1 |>
  unnest_longer(y, indices_include = FALSE)
