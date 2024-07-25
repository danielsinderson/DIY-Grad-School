# Final Exam

library(tidyverse)
library(ISLR)
summary(Credit)

mean(Credit$Rating)
var(Credit$Rating)

incomes <- Credit$Income
n <- nrow(Credit)
x <- incomes[incomes > 100]
(length(x) / n) * 100

head(Credit)
x <- Credit[Credit$Gender == "Female", ]
mean(x$Age)


model <- lm(Rating ~ Income + Limit + Cards + Married + Balance, Credit)
summary(model)
anova(model)


y <- Credit$Rating
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

new_data <- data.frame(
    Married = "No", Cards = 2, Income = 90.0, Limit = 40000, Balance = 3000
    )
predict(model, new_data)


#############################

data <- read.csv("/home/daniel/Documents/school/2023 MTH_461/diabetes.csv")

head(data)
quantile(data$Glucose, c(0.1, 0.9))

cov(data$Glucose, data$Insulin)
cor(data$Glucose, data$Insulin)

n <- nrow(data);n
x <- data[data$Outcome == 1, ]
(nrow(x) / n) * 100


set.seed(123)
train_index <- sample(row.names(data), 0.60 * n)
train_data <- data[train_index, ]
test_index <- setdiff(row.names(data), train_index)
test_data <- data[test_index, ]

diabetes_model <- glm(Outcome ~ Pregnancies + Glucose + BloodPressure + BMI + DiabetesPedigreeFunction, family = binomial, data = train_data)
summary(diabetes_model)
phat <- predict(diabetes_model, test_data, type = "response")
head(test)


alpha <- 0.3
TP <- sum((test_data$Outcome == 1) & (phat >= alpha))
FN <- sum((test_data$Outcome == 0) & (phat < alpha))
FP <- sum((test_data$Outcome == 0) & (phat >= alpha)) # type 2 error
TN <- sum((test_data$Outcome == 1) & (phat < alpha)) # type 1 error

confusion_matrix <- matrix(c(FN, FP, TN, TP), nrow = 2, ncol = 2)
confusion_matrix

(TP + FN) / nrow(test_data)
TN / (TN + TP)
FP / (FP + FN)

matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)



num_intervals <- 1000
delta <- 1 / num_intervals
alpha_range <- seq(0, 1, delta)
alpha_range

tp <- tn <- fn <- fp <- rep(0, length(alpha_range))

for (alpha in alpha_range) {
    tp[alpha * 1000] <- sum((test_data$Outcome == 1) & (phat >= alpha))
    fn[alpha * 1000] <- sum((test_data$Outcome == 0) & (phat < alpha))
    fp[alpha * 1000] <- sum((test_data$Outcome == 0) & (phat >= alpha)) # type 2 error
    tn[alpha * 1000] <- sum((test_data$Outcome == 1) & (phat < alpha)) # type 1 error
}
tp
fn
correct_classification_rate <- (fn + tp) / (nrow(test_data))
correct_classification_rate
type_1_error_rate <- tn / (tn + tp)
type_1_error_rate
type_2_error_rate <- fp / (fp + fn)
type_2_error_rate

plot(fp, tp, type = 'l')
(mean(tp) * 200) / (100 * 200)

sum(tp) / (100 * 100)

z <- fp / tp
mean(z[1:981])

sum(z[1:981]) / 1000
