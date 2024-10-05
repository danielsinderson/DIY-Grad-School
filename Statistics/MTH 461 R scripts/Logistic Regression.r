# Logistic Regression

library(ggplot2)
library(MASS)


# set parameters for simulated data
mu1 <- c(15, 15)
mu2 <- c(22, 22)
sigma <- matrix(c(5, -2, -2, 7), nrow = 2, ncol = 2)
sigma <- sigma %*% t(sigma)


# simulate random normal data in two batches; x1 = 0, x2 = 1
n1 <- 1000
set.seed(123)
x1 <- mvrnorm(n1, mu1, sigma)
d1 <- cbind(x1, 0)

n2 <- 1500
set.seed(1234)
x2 <- mvrnorm(n2, mu2, sigma)
d2 <- cbind(x2, 1)

# combine simulated data into single dataframe
col_names <- c("x1", "x2", "y")
df <- as.data.frame(rbind(d1, d2))
colnames(df) <- col_names


# seperate data into training and testing data
set.seed(123)
train_index <- sample(row.names(df), 0.7 * nrow(df))
train_data <- df[train_index, ]
test_index <- setdiff(row.names(df), train_index)
test_data <- df[test_index, ]


# visualize the dataset for funsies
ggplot(df, aes(x1, x2)) +
    geom_point(aes(colour = factor(y), lwd = 3))


# create a logistic regression model of the data; pull out coefficients
model <- glm(formula = y ~ x1 + x2, family = binomial, data = train_data)
summary(model)
beta <- as.matrix(model$coefficients)


# Predict and classify test data with cutoff = 0.5
alpha <- 0.8
phat <- predict(model, test_data, type = "response")
head(phat)

TP <- sum((test_data$y == 1) & (phat >= alpha))
FN <- sum((test_data$y == 0) & (phat < alpha))
FP <- sum((test_data$y == 0) & (phat >= alpha)) # type 2 error
TN <- sum((test_data$y == 1) & (phat < alpha)) # type 1 error

confusion_matrix <- matrix(c(FN, TN, FP, TP), nrow = 2, ncol = 2)
confusion_matrix
correct_classification_rate <- (FN + TP) / (nrow(test_data))
correct_classification_rate
type_1_error_rate <- TN / (TN + TP)
type_1_error_rate
type_2_error_rate <- FP / (FP + FN)
type_2_error_rate


# Creation of ROC curve (Receiver Operating Characteristics)
# curve of TP against FP as function of alpha value f(alpha) = [FP, TP]
num_intervals <- 1000
delta <- 1 / num_intervals
alpha_range <- seq(0, 1, delta)
alpha_range

tp <- tn <- fn <- fp <- rep(0, length(alpha_range))

for (alpha in alpha_range) {
    tp[alpha * 1000] <- sum((test_data$y == 1) & (phat >= alpha))
    fn[alpha * 1000] <- sum((test_data$y == 0) & (phat < alpha))
    fp[alpha * 1000] <- sum((test_data$y == 0) & (phat >= alpha)) # type 2 error
    tn[alpha * 1000] <- sum((test_data$y == 1) & (phat < alpha)) # type 1 error
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

# area under the ROC curve [0, 1] serves as a diagnostic measure of the model's effectiveness
AUC <- sum(tp) / sum(tp + fp)
AUC

# null deviance is another diagnostic measure [0, +infinity)
# larger value indicates better evidence for rejecting the null hypothesis