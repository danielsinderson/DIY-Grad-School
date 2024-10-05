library(readxl)
library(tidyverse)
library(writexl)


students <- read_excel("0 - Data Science/students.xlsx")
students

# import, then fix column names and assign column types
# then skip the old header, then catch NA variations
# then clean the age column
students <- read_excel(
  path = "0 - Data Science/students.xlsx",
  col_names = c("id", "name", "favorite_food", "meal_plan", "age"),
  col_types = c("numeric", "text", "text", "text", "text"),
  skip = 1,
  na = c("", "N/A")
) |>
  mutate(
    age = if_else(age == "five", "5", age),
    age = parse_number(age)
  )
students


# it's also possible to specify what sheet to load in if the Excel file has many
excel_sheets("0 - Data Science/penguins.xlsx")
torgersen_penguins <- read_excel(
  path = "0 - Data Science/penguins.xlsx",
  sheet = "Torgersen Island",
  na = "NA"
)
biscoe_penguins <- read_excel(
  path = "0 - Data Science/penguins.xlsx",
  sheet = "Biscoe Island",
  na = "NA"
)
dream_penguins <- read_excel(
  path = "0 - Data Science/penguins.xlsx",
  sheet = "Dream Island"
)
torgersen_penguins
biscoe_penguins
dream_penguins

# if all the worksheets have the same columns, you can combine them
penguins <- bind_rows(
  torgersen_penguins,
  biscoe_penguins,
  dream_penguins
)

penguins





bake_sale <- tibble(
  item     = factor(c("brownie", "cupcake", "cookie")),
  quantity = c(10, 5, 8)
)

write_xlsx(bake_sale, path = "0 - Data Science/bake_sale.xlsx")



library(googlesheets4)
students_sheet_id <- "1V1nPp1tzOuutXFLb3G9Eyxi3qxeEhnOXUzL5_BcCQ0w"
students <- read_sheet(students_sheet_id)
