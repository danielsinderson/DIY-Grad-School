# Simulation study of x~unif(0, theta)

theta <- 1000
n <- 10
b <- 10000
data <- matrix(, b, n)
x_max <- rep(0, b)
x_mean <- rep(0, b)

for (i in 1:b) {
    set.seed(i)
    data[i, ] <- runif(n, 0, theta)
    x_max[i] <- max(data[i, ])
    x_mean[i] <- mean(data[i, ])
}

f <- function(x) n * (x^(n - 1) / theta^n)

expected_value <- n / (n + 1) * theta
cat("Expectation of x_(n) is ", expected_value)
cat("Sample mean of x_(n) is ", mean(x_max))

expected_variance <- (n / (n + 2) * theta^2) - expected_value^2
cat("Variance of x_(n) is ", expected_variance)
cat("Sample variance of x_(n) is ", var(x_max))

theta1 <- x_max * (n + 1) / n
mean(theta1) - theta
median(theta1)
var(theta1)

theta2 <- 2 * x_mean
mean(theta2)
var(theta2)
head(theta2)

par(mfrow = c(1, 2)) # partition plot panel into two columns
hist(theta1, probability = TRUE)
hist(theta2, probability = TRUE)
