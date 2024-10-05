library(ISLR)
colnames(Credit)

married <- Credit$Married
y <- length(married)
x <- length(married[married == "Yes"])
x
y


income <- Credit$Income
cat(mean(income), var(income), sd(income))

quantile(income, c(0.1, 0.5, 0.9))

rating <- Credit$Rating
sum(rating^2)

x <- rating[rating < 400 | rating > 700]
length(x) / length(rating)

rating <- Credit$Rating
y <- rating[rating > 500 & rating < 800]
length(y) / length(rating)

ethnicity <- Credit$Ethnicity
x <- ethnicity[ethnicity == "African American"]
length(x)

library(tidyverse)
x <- filter(Credit, Ethnicity == "African American", Rating > 550)
length(rownames(x))


ggplot(data = Credit) +
    geom_point(mapping = aes(x = Income, y = Rating)) +
    facet_wrap(~ Married, nrow = 1)


set.seed(2)
train_index <- sample(rownames(Credit), length(rownames(Credit)) * 0.3)
train_data <- Credit[train_index, ]
test_index <- setdiff(rownames(Credit), train_index)
test_data <- Credit[test_index, ]

train_index[1:3]
test_index[1:3]


(0.01 * 0.95) / ((0.01 * 0.95) + (0.99 * 0.05))


x <- c(2, 3, 5, 7)
p <- c(0.25, 0.30, 0.27, 0.18)
m1 <- sum(x*p)
m2 <- sum(x^2 * p)
a <- m2 - m1^2
sqrt(9 * a)

x <- c(2, 3, 5, 7)
p <- c(0.25, 0.30, 0.27, 0.18)
set.seed(1)
samples <- sample(x, 1000, replace = TRUE, prob = p)
samples[1:6]

mean(samples)
mean(samples^2)

length(samples[samples == 2])
length(samples[samples != 7])

sqrt(44)


1 - pbinom(24, 26, 0.992)

dpois(5, 5)
ppois(5, 5)

x <- c(2, 2, 1)
p <- c(0.3, 0.4, 0.3)
dmultinom(x = x, prob = p)
