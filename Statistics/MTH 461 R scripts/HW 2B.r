# HW 2B

sigma_true <- 3

mu_0 <- 30
sigma_0 <- 10

x <- c(38.7, 40.4, 37.2, 36.6, 35.9)
n <- 5

mu_1 <- ((mu_0 / sigma_0^2) + ((n * mean(x)) / sigma_true^2)) / ((1 / sigma_0^2) + (n / sigma_true^2))
sigma_1 <- 1 / sqrt((1 / sigma_0^2) + (n / sigma_true^2))

c(mu_1, sigma_1)

x2 <- c(39.5, 41.1, 39.2, 37.9, 40.3)

mu_2 <- ((mu_1 / sigma_1^2) + ((n * mean(x2)) / sigma_true^2)) / ((1 / sigma_1^2) + (n / sigma_true^2))
sigma_2 <- 1 / sqrt((1 / sigma_1^2) + (n / sigma_true^2))
c(mu_2, sigma_2)
