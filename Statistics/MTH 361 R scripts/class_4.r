library(tidyverse)
library(ISLR)

ages <- data.frame(name = c("Mike", "Tom", "Lexi"), age = c(25, 26, 19))
favorite_color <- sample(c("blue", "purple"), nrow(ages), replace = TRUE)
favorite_color
ages_colors <- cbind(ages, favorite_color)
ages_colors




#------------------------------------
# The five verbs of dplyr, yay!
#------------------------------------

# arrange(df, column) arranges df by ordering on column
ages %>% arrange(age)

# select(df, c(columns)) creates a subtable from columns
ages %>% select(c(name, age)) %>% filter(age > 25)

# filter(df, logical expression) filters df rows by boolean expression
ages %>% filter(age < 20)

# mutate(df, f(columns)) creates a new column as a function of other columns
ages %>% mutate(age_in_10_years = age + 10)

# summarise(df, new_value = f(col)) creates summary statistic from f(column)
ages %>% summarise(age_mean = mean(age))


#----------------------------------------
# ggplot stuff!
#------------------------------------------
ggplot(Auto, aes(x = weight, y = mpg)) +
    geom_point(mapping = aes(color = cylinders)) +
    facet_wrap(~origin, nrow = 3)

ggplot(Auto, aes(x = acceleration)) +
    geom_histogram() +
    facet_grid(cylinders ~ origin)


Auto[1, ]
