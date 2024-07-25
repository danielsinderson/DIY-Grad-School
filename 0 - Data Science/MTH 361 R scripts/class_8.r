# Discrete Probatility Distributions

# the distribution
x <- c(11, 13, 17, 19)
px <- c(0.4, 0.3, 0.2, 0.1)

# the statistics of the distribution
mu <- sum(x * px)
variance <- sum(x^2 * px) - mu^2
sd <- sqrt(variance)
cat("mu is", mu, ", variance is", variance, ", and sigma is", sd)

# simulating a population sample from the distribution
n <- 10000
set.seed(1923)
pop_sample <- sample(x, n, replace = TRUE, prob = px)
head(pop_sample)
summary(pop_sample)
quantile(pop_sample, c(0.1, 0.47, 0.5, 0.63, 0.9))
cat("mu is", mean(pop_sample), ", variance is", var(pop_sample), ", and sigma is", sd(pop_sample))


# the probability that after 10 Bernoulli trials with P=0.55, the num of successes is 7
b <- dbinom(7, 10, 0.55)
# the probability that after 10 Bernoulli trials with P=0.55, the num of successes is <= 7
p <- pbinom(7, 10, 0.55)

