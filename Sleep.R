library(tidyverse)
library(corrplot)
library(ggplot2)
library(dplyr)
library(randomForest)
library(caret)

# Set working directory and load the dataset
setwd("your_working_directory")
data <- read.csv("your_dataset.csv", stringsAsFactors = TRUE)

any_missing <- any(is.na(data))
# no missing value 

# Overview of the data
summary(data)
str(data) 
head(data)

# Correlation Analysis
# Select relevant numerical columns for correlation analysis
cor_vars <- data[, c("Age", "Sleep.duration", "Sleep.efficiency", "REM.sleep.percentage", 
                     "Deep.sleep.percentage", "Light.sleep.percentage", "Awakenings", 
                     "Caffeine.consumption", "Alcohol.consumption", "Exercise.frequency", 
                     "Daily.Steps")]
correlations <- cor(cor_vars)
print(correlations)

corrplot(correlations)
# 


# Categorise age into groups for analysis
data$Age_Group <- cut(data$Age, breaks = c(0, 20, 40, 60, 80, 100), labels = c("0-20", "21-40", "41-60", "61-80", "81-100"))

# Group by Age Group and Gender and calculate mean sleep efficiency
sleep_efficiency_by_group <- data %>%
  group_by(Age_Group, Gender) %>%
  summarize(mean_sleep_efficiency = mean(Sleep.efficiency, na.rm = TRUE))

# Print the result
print(sleep_efficiency_by_group)

ggplot(sleep_efficiency_by_group, aes(x = Age_Group, y = mean_sleep_efficiency, fill = Gender)) +
  geom_col(position = "dodge") +
  labs(title = "Sleep Efficiency by Age Group and Gender",
       x = "Age Group",
       y = "Average Sleep Efficiency",
       fill = "Gender")+
  ylim(0, 1)
#Sleep efficiency is generally higher in the 41-60 age group for both genders.
#Males in the youngest age group (0-20) exhibit notably higher sleep efficiency compared to females in the same age group.
#Sleep efficiency appears to decrease slightly in the 61-80 age group.

ggplot(data, aes(x = Age, y = `Sleep.duration`)) +
  geom_point(color = "blue", alpha = 0.5) +
  labs(title = "Relationship Between Age and Sleep Duration",
       x = "Age",
       y = "Sleep Duration (hours)")

correlation_age_sleep <- cor(data$Age, data$Sleep.duration)
correlation_age_sleep
# −0.0625
# This value suggests a very weak negative correlation between age and sleep duration. Essentially, as age increases, sleep duration decreases slightly, but this relationship is not strong.



# Define lifestyle factors
lifestyle_factors <- c('Caffeine.consumption', 'Alcohol.consumption', 'Exercise.frequency')

# Calculate correlations with sleep efficiency
lifestyle_correlations <- cor(data[lifestyle_factors], data$Sleep.efficiency)
lifestyle_correlations
# Plot the correlations
barplot(lifestyle_correlations, 
        main = "Correlation of Lifestyle Factors with Sleep Efficiency",
        ylab = "Correlation Coefficient",
        ylim = c(-0.5, 0.5),
        col = "skyblue",
        names.arg = c("Caffeine consumption", "Alcohol consumption", "Exercise frequency"),
        beside = TRUE, space=0.5)

abline(h = 0, col = "gray", lty = 2)
#Negative impacts of alcohol and smoking on sleep efficiency.
#A beneficial effect of exercise on sleep efficiency.
#Minimal impact of caffeine on sleep efficiency in this dataset.




# Prepare data for RQ1
data_RQ1 <- data %>%
  select(Sleep.efficiency, Age_Group, Gender, Caffeine.consumption, Alcohol.consumption, Exercise.frequency, Daily.Steps)

# Prepare data for RQ2
# Assuming "early-life" is defined as ages 21-40 and "later-life" is ages 61-80
data_RQ2_early <- data %>%
  filter(Age_Group %in% c("21-40")) %>%
  select(Sleep.efficiency, Caffeine.consumption, Alcohol.consumption, Exercise.frequency)

data_RQ2_late <- data %>%
  filter(Age_Group %in% c("61-80")) %>%
  select(Sleep.efficiency, Caffeine.consumption, Alcohol.consumption, Exercise.frequency)

set.seed(123)  # Ensure reproducibility
trainIndex1 <- createDataPartition(data_RQ1$Sleep.efficiency, p = 0.8, list = FALSE)
train_RQ1 <- data_RQ1[trainIndex1, ]
test_RQ1 <- data_RQ1[-trainIndex1, ]

set.seed(123)
trainIndex2 <- createDataPartition(data_RQ2_late$Sleep.efficiency, p = 0.8, list = FALSE)
train_RQ2 <- data_RQ2_early[trainIndex2, ]  # Early-life data for training
test_RQ2 <- data_RQ2_late[-trainIndex2, ]  # Late-life data for testing


# Define a function to fit models, calculate RMSE, and return variable importance for Random Forest
fit_and_evaluate <- function(model_func, formula, train_data, test_data, return_importance = FALSE) {
  model <- model_func(formula, data = train_data)
  predictions <- predict(model, newdata = test_data)
  rmse <- sqrt(mean((predictions - test_data$Sleep.efficiency)^2))
  
  if (return_importance && "randomForest" %in% deparse(substitute(model_func))) {
    importance <- as.data.frame(importance(model))
    colnames(importance) <- c("Importance")
    importance$Variable <- rownames(importance)
    return(list(rmse = rmse, importance = importance))
  } else {
    return(list(rmse = rmse))
  }
}

# Evaluate models for RQ1
results_RQ1_rf <- fit_and_evaluate(randomForest, Sleep.efficiency ~ ., train_RQ1, test_RQ1, TRUE)
results_RQ1_lm <- fit_and_evaluate(lm, Sleep.efficiency ~ ., train_RQ1, test_RQ1)

# Evaluate models for RQ2
results_RQ2_rf <- fit_and_evaluate(randomForest, Sleep.efficiency ~ ., train_RQ2, test_RQ2, TRUE)
results_RQ2_lm <- fit_and_evaluate(lm, Sleep.efficiency ~ ., train_RQ2, test_RQ2)

# Printing RMSE results and variable importance for Random Forest
print("Results for Research Question 1 - linear regression:")
print(results_RQ1_lm$rmse)
print("Results for Research Question 1 - Random Forest:")
print(results_RQ1_rf$rmse)
print("Variable Importance for RQ1 - Random Forest:")
print(results_RQ1_rf$importance)


print("Results for Research Question 2 - linear regression:")
print(results_RQ2_lm$rmse)
print("Results for Research Question 2 - Random Forest:")
print(results_RQ2_rf$rmse)
print("Variable Importance for RQ2 - Random Forest:")
print(results_RQ2_rf$importance)

