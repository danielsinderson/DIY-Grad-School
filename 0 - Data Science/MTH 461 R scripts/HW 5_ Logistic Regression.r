# HW 5: Logistic Regression

library(tidyverse)
data <- read.csv("/home/daniels/Documents/school/2023 MTH_461/CHDdata.csv")
summary(data)
head(data)
n <- nrow(data)


# seperate data into training and testing data
set.seed(123)
train_index <- sample(row.names(data), 0.65 * n)
train_data <- data[train_index, ]
test_index <- setdiff(row.names(data), train_index)
test_data <- data[test_index, ]


# create a logistic regression model of the data; pull out coefficients
model <- glm(formula = train_data$chd ~ ., family = binomial, data = train_data)
summary(model)


model2 <- glm(formula = chd ~ tobacco +
    ldl +
    famhist +
    typea +
    age,
    family = binomial, data = train_data)
summary(model2)

beta <- as.matrix(model2$coefficients)
beta
exp(beta[2])
exp(beta[4])
exp(beta[6])

head(test_data)
phat <- predict(model, test_data, type = "response")
head(phat)

alpha <- 0.8
TP <- sum((test_data$chd == 1) & (phat >= alpha))
FN <- sum((test_data$chd == 0) & (phat < alpha))
FP <- sum((test_data$chd == 0) & (phat >= alpha)) # type 2 error
TN <- sum((test_data$chd == 1) & (phat < alpha)) # type 1 error

confusion_matrix <- matrix(c(FN, TN, FP, TP), nrow = 2, ncol = 2)
confusion_matrix




# Creation of ROC curve (Receiver Operating Characteristics)
# curve of TP against FP as function of alpha value f(alpha) = [FP, TP]
num_intervals <- 1000
delta <- 1 / num_intervals
alpha_range <- seq(0, 1, delta)
alpha_range

tp <- tn <- fn <- fp <- rep(0, length(alpha_range))

for (alpha in alpha_range) {
    tp[alpha * 1000] <- sum((test_data$chd == 1) & (phat >= alpha))
    fn[alpha * 1000] <- sum((test_data$chd == 0) & (phat < alpha))
    fp[alpha * 1000] <- sum((test_data$chd == 0) & (phat >= alpha)) # type 2 error
    tn[alpha * 1000] <- sum((test_data$chd == 1) & (phat < alpha)) # type 1 error
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







newdata <- tribble(
    ~tobacco, ~ldl, ~famhist, ~typea, ~age,
    4.3, 5, "Present", 70, 45,
    0, 3, "Absent", 30, 45
)
newdata
as.data.frame(newdata)

new_obs <- predict(model2, as.data.frame(newdata), type = "response")
new_obs
phat


