library(tidyverse)



#pivot_longer()
messy_data1 <- tribble(
    ~Country, ~`1999`, ~`2000`,
    "Afghanistan", 745, 2666,
    "Brazil", 37737, 80488,
    "China", 212258, 213766
)

tidy_data1 <- pivot_longer(messy_data1, c(`1999`, `2000`), names_to = "year", values_to = "cases")
tidy_data1


#pivot_wider()
messy_data2 <- tribble(
    ~country, ~year, ~type, ~count,
    "Afghanistan", 1999,  "cases", 745,
    "Afghanistan", 1999,  "population", 19987071,
    "Afghanistan", 2000,  "cases", 2666,
    "Afghanistan", 2000,  "population", 20595360
)
tidy_data2 <- pivot_wider(messy_data2, names_from = type, values_from = count)
tidy_data2


#seperate()
messy_data3 <- tribble(
    ~country, ~year, ~rate,
    "Afghanistan", 1999, "745/19987071",
    "Afghanistan", 2000, "266/20595360",
)
tidy_data3 <- separate(messy_data3, rate, into = c("cases", "population"))
tidy_data3


#left_join()