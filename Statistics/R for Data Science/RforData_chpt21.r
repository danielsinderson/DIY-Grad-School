library(DBI)
library(dbplyr)
library(tidyverse)

# create the duckdb database at the "duckdb" directory
con <- DBI::dbConnect(
  duckdb::duckdb(),
  dbdir = "duckdb"
)

# add data to the database
dbWriteTable(con, "mpg", ggplot2::mpg) # db connection, table name, dataframe
dbWriteTable(con, "diamonds", ggplot2::diamonds)

# duckdb_read_csv()
# duckdb_register_arrow()

dbListTables(con)

con |>
  dbReadTable("diamonds") |>
  as_tibble()


sql <- "
  SELECT carat, cut, clarity, color, price
  FROM diamonds
  WHERE price > 15000
"
as_tibble(dbGetQuery(con, sql))



diamonds_db <- tbl(con, "diamonds")
diamonds_db

big_diamonds_db <- diamonds_db |>
  filter(price > 15000) |>
  select(carat:clarity, price)
big_diamonds_db

big_diamonds_db |>
  show_query()

big_diamonds <- big_diamonds_db |>
  collect()
big_diamonds
