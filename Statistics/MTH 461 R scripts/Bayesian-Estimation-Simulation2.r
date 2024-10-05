#Bayesian-Estimation-Simulation2

p <- 0.07
a <- 2
b <- 4
curve(dbeta(x, a, b), 0, 1)
Mu0 <- a / (a + b)
Mode0 <- (a - 1) / (a + b - 2)
Var0 <- (a * b) / ((a + b)^2 * (a + b + 1))
cat("The mean is", Mu0, "\nThe mode is", Mode0, "\nThe variance is", Var0)

y <- 200
Var <- Mode <- Mu <- rep(0, y)
for (i in 1:y) {
    set.seed(i)
    n <- sample(1:50, 1)
    set.seed(i)
    x <- rbinom(n, 1, p)
    if (i == 7) {
        print(x)
        print(a + sum(x))
        print(b + n - sum(x))
    }

    a <- a + sum(x)
    b <- b + n - sum(x)

    Mu[i] <- a / (a + b)
    Mode[i] <- (a - 1) / (a + b - 2)
    Var[i] <- (a * b) / ((a + b)^2 * (a + b + 1))
}

c(Mu0, Mode0, Var0)
curve(dbeta(x, a, b), 0, 1, add = TRUE)
cat("The mean is", Mu[200], "\nThe mode is", Mode[200], "\nThe variance is", Var[200])

plot(Mu, type = "l", lwd = 2, main = "Posterior Mean")
par(mfrow = c(1, 2))
plot(Mode, type = "l", lwd = 2, main = "Posterior Mode")
plot(Var, type = "l", lwd = 2, main = "Posterior Variance")





p <- 0.07
a <- 2
b <- 4
set.seed(1)
n <- sample(1:50, 1)
set.seed(1)
x <- rbinom(n, 1, p)
x
curve(dbeta(x, a, b), 0, 1)
a <- a + sum(x)
a
b <- b + n - sum(x)
b
curve(dbeta(x, a, b), 0, 1, add = TRUE)
Mu0 <- a / (a + b)
Mode0 <- (a - 1) / (a + b - 2)
Var0 <- (a * b) / ((a + b)^2 * (a + b + 1))
cat("The mean is", Mu0, "\nThe mode is", Mode0, "\nThe variance is", Var0)


par(mfrow = c(1, 1))
curve(dbeta(x, 379, 4797, 0, 1))
Mu0 <- 5 / (5 + 24)
Mode0 <- (5 - 1) / (5 + 24 - 2)
Var0 <- (5 * 24) / ((5 + 24)^2 * (5 + 24 + 1))
cat("The mean is", Mu[7], "\nThe mode is", Mode[7], "\nThe variance is", Var[7])
a
b


Mu[7]
Mode[7]
Var[7]
