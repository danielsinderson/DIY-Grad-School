# HW 4: Linear Regression
library(tidyverse)
data <- read.csv("/home/daniels/Documents/school/2023 MTH_461/CHDdata.csv")

n <- nrow(data)
n

quantile(data$sbp, c(0.1, 0.9))
quantile(data$ldl, c(0.1, 0.9))

famhistory <- filter(data, data$famhist == "Present")
(nrow(famhistory) / nrow(data)) * 100


mean(data$age)
sd(data$age)

(sum(data$chd) / nrow(data)) * 100

model <- lm(sbp ~ ., data)
summary(model)
anova(model)

mean(data$tobacco)
mean(data$ldl)
mean(data$adiposity)
mean(data$alcohol)
mean(data$age)


model2 <- lm(sbp ~ tobacco + ldl + adiposity + alcohol + age, data)
summary(model2)
anova(model2)

y <- data$sbp
y_hat <- predict(model)
residuals <- y_hat - y

TSS <- sum((y - mean(y))^2)
TSS
SSR <- sum((y_hat - mean(y_hat))^2)
SSR
SSR / TSS
SSE <- sum(residuals^2)
SSE

SSE / TSS
SSR / TSS


hist(residuals, probability = TRUE)
sd(residuals)

x1 <- mean(data$tobacco)
x2 <- mean(data$ldl)
x3 <- mean(data$adiposity)
x4 <- mean(data$alcohol)
x5 <- mean(data$age)
new_data <- tibble(
    tobacco = x1, ldl = x2, adiposity = x3, alcohol = x4, age = x5
    )
predict(model2, newdata = new_data)
