### T Test Simulation
# X = Human Gestational Period under effect of alcohol
# X ~ N(mu = 266, sigma = 16) pretending that these are unknown
# Null Hypothesis, H_0: mu = 266
# Alternate Hypothesis, H_1: mu != 266

mu_0 <- 266
sigma <- 16

## Type 1 error simulation (H_0 is true, but rejected)
# Alcohol has no effect but we believe it does

alpha <- 0.05
n <- 5
set.seed(1)
x <- rnorm(n, mu_0, sigma)
x

t_0 <- (mean(x) - mu_0) / (sd(x) / sqrt(n))
pvalue <- 2 * (1 - pt(abs(t_0), n - 1))
pvalue
cat("pvalue =", pvalue)
if (pvalue <= alpha) {
    cat("Reject null hypothesis. Type I error!")
} else {
    cat("Do not reject null hypothesis. Correct!")
}


## Type 2 error simulation (H_1 is true, but H_0 not rejected)
# Alcohol has an effect but we believe it doesn't

mu_0 <- 266
mu_1 <- 261 # this is the true value
sigma <- 16

alpha <- 0.05
n <- 5
set.seed(1)
x <- rnorm(n, mu_1, sigma)
x

t_0 <- (mean(x) - mu_0) / (sd(x) / sqrt(n))
pvalue <- 2 * (1 - pt(abs(t_0), n - 1))
pvalue
cat("pvalue =", pvalue)
if (pvalue <= alpha) {
    cat("Reject null hypothesis. Correct!")
} else {
    cat("Do not reject null hypothesis. Type II error!")
}