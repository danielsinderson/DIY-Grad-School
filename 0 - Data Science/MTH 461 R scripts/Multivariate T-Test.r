# Multivariate T-Test
## Hotelling's T-Test

p <- 2  # two dimensional case
mu0 <- c(0, 0)
# population covariance; pretend unknown
cov_matrix <- matrix(c(6, -15, -15, 9), nrow = 2, ncol = 2)
cov_matrix <- cov_matrix %*% t(cov_matrix) # make invertible

# simulate data from null hypothesis: N2(mu0, cov_matrix)
library(MASS)
n <- 300
set.seed(12345)

x <- mvrnorm(n, mu0, cov_matrix)
x_bar <- matrix(apply(x, MARGIN = 2, FUN = mean), nrow = 2, ncol = 1)
s <- cov(x) #sample covariance matrix
s
mu0 <- matrix(mu0, nrow = 2, ncol = 1)

head(x)
plot(x, lwd = 3)

# Hotelling's T-Test
## chance of rejecting null is going to be controlled by alpha
alpha <- 0.05

## calculate test statistic
t2 <- (n * t(x_bar - mu0)) %*% solve(s) %*% (x_bar - mu0)

## calculate f-score and critical point
f <- (n - p) / ((n - 1) * p) * t2
cp <- qf(1 - alpha, p, n - p)

if (f >= cp) {
    cat("The F-Score is in the critical region; reject null hypothesis.")
} else {
    cat("The F-Score is not in the critical region; accept null hypothesis.")
}
