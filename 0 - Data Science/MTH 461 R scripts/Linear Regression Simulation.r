# Chapt. 6: Multiple Linear Regression Simulation
### E(y) = 2 + 3x, so y = 2 + 3x + epsilon

n <- 1000
set.seed(123)
x <- runif(n, 0, 10)
set.seed(123)
y <- 2 + 3 * x + rnorm(n, 0, 3)

plot(x, y, lwd = 3)

data <- data.frame(x, y)
head(data)
model <- lm(y ~ x, data)
summary(model)
anova(model)

model$residuals
beta <- as.matrix(model$coefficients)
beta

############################################
############################################

n <- 1000
set.seed(123)
x1 <- runif(n, 0, 10)
set.seed(1234)
x2 <- runif(n, 0, 10)
set.seed(123)
y <- 2 + (7 * x1) + (4 * x2) + rnorm(n, 0, 3)

data <- data.frame(x1, x2, y)
head(data)
model <- lm(y ~ ., data)
summary(model)
anova(model)
y_hat <- predict(model)
residuals <- y_hat - y
head(residuals)
plot(residuals)
hist(residuals, probability = TRUE)
sd(residuals)


TSS <- sum((y - mean(y))^2)
TSS
SSR <- sum((y_hat - mean(y_hat))^2)
SSR
SSR / TSS
SSE <- sum(residuals^2)
SSE
SSE2 <- TSS - SSR

SSE - SSE2

k <- 2
df1 <- k
df2 <- n - k - 1
f_statistic <- (SSR / df1) / (SSE / df2)
f_statistic

p_value <- 1 - pf(f_statistic, df1, df2)
p_value

m1 <- mean(x1)
m2 <- mean(x2)
df2 <- data.frame(m1, m2)
predict(model, df2)

model$residuals
beta <- as.matrix(model$coefficients)
beta