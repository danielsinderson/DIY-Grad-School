# DAY ONE
x <- 11
y <- x^2
print("hello world")

x <- 1:10
print(x)
typeof(x)
seq(1, 1000, 3) # creates the range, inclusive, with a certain step
c(1, 2, 3, 4, 5) # creates the specified array
5:7 # creates the range, inclusive
rep(1, 7) # rep(x, y) repeats x, y times

x1 <- c(1, 2, 3, 4, 5, 6)[3]
print(x1) #index starts at 1!

z1 <- seq(10, 1, -1)
z1[4]

x <- rnorm(10000, 266, 16)
boxplot(x)
hist(x, probability = TRUE)
f <- function(x) dnorm(x, 266, 16)
curve(f, 266 - 96, 266 + 96, add = TRUE)
