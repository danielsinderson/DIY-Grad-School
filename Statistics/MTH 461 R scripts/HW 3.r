# HW 3: Hotelling's T Test

## 3 dimensional case
# x1 is sweat rate
# x2 is sodium content
# x3 is potassium content

p <- 3
mu0 <- matrix(c(4, 50, 10), nrow = 3, ncol = 1)
data <- read.csv("/home/daniels/Documents/school/2023 MTH_461/Sweat.csv")
data
x1 <- data[, 1]
x2 <- data[, 2]
x3 <- data[, 3]
df <- data.frame(x1, x2, x3)
pairs(df)

x_bar <- apply(df, 2, mean)
x_bar <- matrix(x_bar, nrow = 3, ncol = 1)

sigma <- apply(df, 2, sd)
sigma

variance <- apply(df, 2, var)
variance

s <- cov(df)
s



# Hotelling's T-Test
## chance of rejecting null is going to be controlled by alpha
alpha <- 0.1
n <- 20



## calculate test statistic
t2 <- (n * t(x_bar - mu0)) %*% solve(s) %*% (x_bar - mu0)
t2

## calculate f-score and critical point
f <- (n - p) / ((n - 1) * p) * t2
f
cp <- qf(1 - alpha, p, n - p)
cp

if (f >= cp) {
    cat("The F-Score is in the critical region; reject null hypothesis.")
} else {
    cat("The F-Score is not in the critical region; accept null hypothesis.")
}

