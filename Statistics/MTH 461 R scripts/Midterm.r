# Midterm

# Our prior distribution is gamma(r = 5, v = 2)
# Our posterior distribution is gamma(r = r + sum(data), v = v + 1)
r_0 <- 5
v_0 <- 2

n <- 7
b <- 1000

means <- rep(0, b)
modes <- rep(0, b)
variances <- rep(0, b)

r_values <- rep(r_0, b + 1)
v_values <- rep(v_0, b + 1)

for (i in 1:b) {
    set.seed(i)

    data <- rpois(n, 3.14)
    r <- r_values[i] + sum(data)
    v <- v_values[i] + n

    r_values[i + 1] <- r
    v_values[i + 1] <- v

    means[i] <- r / v
    modes[i] <- (r - 1) / v
    variances[i] <- r / (v^2)
}

cat("The final r value is", r_values[b + 1])
cat("The final v value is", v_values[b + 1])
c(means[b], modes[b], variances[b])

par(mfrow = c(1, 2))
plot(modes, type = "l", lwd = 2, main = "Posterior Mode")
plot(variances, type = "l", lwd = 2, main = "Posterior Variance")