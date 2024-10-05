p <- 0.835
a <- 2
b <- 20 #initializing prior
curve(dbeta(x, a, b), from = 0, to = 2)

n <- 100
data <- rbinom(n, 1, p)

a1 <- a + sum(data)
b1 <- b + n - sum(data)
curve(dbeta(x, a1, b1), from = 0, to = 2, add = TRUE)

mode <- (a1 - 1) / (a1 + b1 - 2)
c(a1, b1, mode)