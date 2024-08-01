library(tidyverse)

ks <- read_tsv("0 - Data Science/Kickstarter Project/38050-0001-Data.tsv")
# glimpse(ks)


# select variables of interest
# filter for tabletop games
# convert the USD strings variables to numeric values
# convert date strings in US format (m-d-y) to date values
# add columns for month and year for easy analysis
# simplify state to binary successful | not successful
# add column for success binary
# filter for games whose goal was <= $250,000 USD to cut most extreme outliers
# filter out the observations with NA launch data from previous conversion
games <- ks |>
  select(CASEID, SUBCATEGORY, GOAL_IN_USD:LAUNCHED_DATE, STATE) |>
  filter(SUBCATEGORY == 34) |>
  mutate(
    GOAL_IN_USD = as.numeric(str_remove_all(str_sub(GOAL_IN_USD, 2, -1), ",")),
    PLEDGED_IN_USD = as.numeric(str_remove_all(str_sub(PLEDGED_IN_USD, 2, -1), ",")),
    GOAL_SCALE = floor(log10(GOAL_IN_USD)),
    AVG_DONATION = case_when(
      BACKERS_COUNT != 0 ~ PLEDGED_IN_USD / BACKERS_COUNT,
      .default = 0
    ),
    LAUNCHED_DATE = mdy(LAUNCHED_DATE),
    LAUNCH_YEAR = year(LAUNCHED_DATE),
    LAUNCH_MONTH = month(LAUNCHED_DATE),
    STATE = case_when(
      STATE == "canceled" ~ "not successful",
      STATE == "failed" ~ "not successful",
      STATE == "suspended" ~ "not successful",
      STATE == "successful" ~ "successful"
    ),
    SUCCEEDED = if_else(STATE == "successful", TRUE, FALSE)
  ) |>
  filter(GOAL_IN_USD >= 100 & GOAL_IN_USD <= 250000) |>
  filter(!is.na(LAUNCHED_DATE))


glimpse(games)


# there are some extreme outliers in goal
# games |>
#  ggplot(aes(x = STATE, y = GOAL_IN_USD)) +
#  geom_boxplot()
#
# games |>
#   ggplot(aes(x = GOAL_IN_USD)) +
#   geom_density() +
#   scale_x_log10()



# total number of campaigns per year is increasing
games |>
  ggplot(aes(x = LAUNCH_YEAR, fill = STATE)) +
  geom_bar()


# success rate for tabletop games seeking <= $250,000 USD is increasing
games |>
  group_by(LAUNCH_YEAR) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED)) |>
  ggplot(aes(x = LAUNCH_YEAR, y = SUCCESS_RATE)) +
  geom_point() +
  geom_line()


# success rate for tabletop games seeking <= $50,000 USD
# is highest when launched in Jan, Feb, Mar, or Sep
games |>
  group_by(LAUNCH_MONTH) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED)) |>
  ggplot(aes(x = LAUNCH_MONTH, y = SUCCESS_RATE)) +
  geom_point() +
  geom_line() +
  scale_x_discrete(
    name = "Month",
    limits = c(
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    )
  )



# Success rate goes down as goal goes up
games |>
  group_by(GOAL_IN_USD) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED)) |>
  ggplot(aes(x = GOAL_IN_USD, y = SUCCESS_RATE)) +
  geom_point() +
  geom_smooth()

games |>
  ggplot(aes(x = GOAL_SCALE, fill = STATE)) +
  geom_histogram()

games |>
  group_by(GOAL_SCALE) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED))

games |>
  group_by(GOAL_SCALE) |>
  summarize(SUCCESS_RATE = mean(SUCCEEDED)) |>
  ggplot(aes(x = GOAL_SCALE, y = SUCCESS_RATE)) +
  geom_point() +
  geom_line() +
  scale_x_discrete(
    name = "Amount Asked For",
    limits = c(
      "",
      "$100s",
      "$1,000s",
      "$10,000s",
      "$100,000s"
    )
  )


# Correlation between the amount pledged and the amount asked for:
# linear for successful campaigns and sigmoidal for failed campaigns
games |>
  ggplot(aes(x = log10(GOAL_IN_USD), y = log10(PLEDGED_IN_USD))) +
  geom_point(aes(color = STATE)) +
  geom_smooth(aes(color = STATE))



# What is the average donation for successful/failed campaigns
games |>
  group_by(SUCCEEDED) |>
  summarize(
    donation_mean = mean(AVG_DONATION),
    donation_median = median(AVG_DONATION)
  )


games |>
  ggplot(aes(x = STATE, y = AVG_DONATION)) +
  geom_boxplot()

games |>
  ggplot(aes(x = AVG_DONATION)) +
  geom_density()

games |>
  ggplot(aes(x = PLEDGED_IN_USD, y = AVG_DONATION)) +
  geom_point(aes(color = STATE)) +
  geom_smooth(aes(color = STATE))



# How many backers for successful/failed campaigns
games |>
  group_by(SUCCEEDED) |>
  summarize(
    num_backers_mean = mean(BACKERS_COUNT),
    num_backers_median = median(BACKERS_COUNT)
  )

games |>
  ggplot(aes(GOAL_IN_USD, y = BACKERS_COUNT)) +
  geom_point() +
  geom_smooth()





# MODEL
# Logistic regression of SUCCEEDED
game_modeling_data <- games |>
  select(GOAL_IN_USD, LAUNCH_MONTH, AVG_DONATION, BACKERS_COUNT, SUCCEEDED)

set.seed(123)
train_index <- sample(row.names(game_modeling_data), 0.7 * nrow(games))
train_data <- game_modeling_data[train_index, ]
test_index <- setdiff(row.names(game_modeling_data), train_index)
test_data <- game_modeling_data[test_index, ]

model <- glm(SUCCEEDED ~ ., data = train_data, family = "binomial")
summary(model)
beta <- as.matrix(model$coefficients)
beta

# Predict and classify test data with cutoff = 0.5
alpha <- 0.8
phat <- predict(model, test_data, type = "response")
head(phat)

TP <- sum((test_data$SUCCEEDED == 1) & (phat >= alpha))
FN <- sum((test_data$SUCCEEDED == 0) & (phat < alpha))
FP <- sum((test_data$SUCCEEDED == 0) & (phat >= alpha)) # type 2 error
TN <- sum((test_data$SUCCEEDED == 1) & (phat < alpha)) # type 1 error

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
  tp[alpha * 1000] <- sum((test_data$SUCCEEDED == 1) & (phat >= alpha))
  fn[alpha * 1000] <- sum((test_data$SUCCEEDED == 0) & (phat < alpha))
  fp[alpha * 1000] <- sum((test_data$SUCCEEDED == 0) & (phat >= alpha)) # type 2 error
  tn[alpha * 1000] <- sum((test_data$SUCCEEDED == 1) & (phat < alpha)) # type 1 error
}
tp
fn
correct_classification_rate <- (fn + tp) / (nrow(test_data))
correct_classification_rate
type_1_error_rate <- tn / (tn + tp)
type_1_error_rate
type_2_error_rate <- fp / (fp + fn)
type_2_error_rate

plot(fp, tp, type = "l")

# area under the ROC curve [0, 1] serves as a diagnostic measure of the model's effectiveness
AUC <- sum(tp) / sum(tp + fp)
AUC

# null deviance is another diagnostic measure [0, +infinity)
# larger value indicates better evidence for rejecting the null hypothesis
