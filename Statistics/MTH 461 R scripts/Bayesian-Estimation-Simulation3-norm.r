# Simulation of Bayesian Estimation of Normal Distribution
# let us assume that sigma is known and mu is unknown; X ~ Norm(266, 5^2)

mu_true <- 260
sigma_true <- 3

# prior of mu 
mu0 <- 100
sigma0 <- 10

n <- 5
#data from X ~ Norm(266, 5^2)
set.seed(1)
x <- rnorm(n, mu_true, sigma_true)
head(x)

mu1 <- ((mu0 / sigma0^2) + ((n * mean(x)) / sigma_true^2)) / ((1 / sigma0^2) + (n / sigma_true^2))
sigma1 <- 1 / sqrt((1 / sigma0^2) + (n / sigma_true^2))
c(mu1, sigma1)

####################################################################

####################################################################

mu_true <- 266
sigma_true <- 5

# prior of mu
mu0 <- 1
sigma0 <- 10

# n = number of trials; b = number of iterations
n <- 1
b <- 20

sigma_post <- mu_post <- rep(0, b + 1)
sigma_post[1] <- sigma0
mu_post[1] <- mu0
x <- matrix(data = rep(0, n * b), nrow = b, ncol = n)

for (i in 1:b) {
    set.seed(i)
    x[i, ] <- rnorm(n, mu_true, sigma_true)
    mu_post[i + 1] <- ((mu_post[i] / sigma_post[i]^2) + ((n * mean(x[i, ])) / sigma_true^2)) / ((1 / sigma_post[i]^2) + (n / sigma_true^2))
    sigma_post[i + 1] <- 1 / sqrt((1 / sigma_post[i]^2) + (n / sigma_true^2))
}

mu_post[b + 1]
sigma_post[b + 1]

plot(sigma_post)
plot(mu_post, type = "b")