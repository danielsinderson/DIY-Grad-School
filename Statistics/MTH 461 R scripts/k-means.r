# K-Means Clustering -- last class!

library(ggplot2)
library(MASS)


# set parameters for simulated data
mu1 <- c(25, 25)
sigma1 <- matrix(c(29, -24, -24, 53), nrow = 2, ncol = 2)
inv_sigma1 <- solve(sigma1)

mu2 <- c(40, 40)
sigma2 <- matrix(c(19, -14, -14, 33), nrow = 2, ncol = 2)
inv_sigma2 <- solve(sigma2)


# simulate random normal data in two batches
n1 <- 1000
set.seed(123)
g1 <- mvrnorm(n1, mu1, sigma1)

n2 <- 1000
set.seed(1234)
g2 <- mvrnorm(n2, mu2, sigma2)


# combine simulated data into single dataframe
col_names <- c("x1", "x2")
df <- as.data.frame(rbind(g1, g2))
colnames(df) <- col_names


# plot data
ggplot(df, aes(x1, x2)) +
    geom_point()


# K-Means!
x1_mean <- mean(df$x1)
x2_mean <- mean(df$x2)
TSS <- sum((df$x1 - x1_mean)^2 + (df$x2 - x2_mean)^2)

model <- kmeans(df, 2, iter.max = 10, nstart = 20, algorithm = c("Hartigan-Wong", "Lloyd", "Forgy","MacQueen"), trace = FALSE)
summary(model)
model$cluster
model$centers
model$totss
model$withinss
model$tot.withinss
model$betweenss

## But how do you choose the value of K? 
## How do you choose how many categories to cluster into?
## ## Try to minimize SSWithin and maximize SSBetween
## ## but also try to keep K fairly small relative to sample size to avoid overfitting
## ## ## the idea is to graph SSBetween w.r.t varying k values and choose an elbow point on the resulting L-curve!