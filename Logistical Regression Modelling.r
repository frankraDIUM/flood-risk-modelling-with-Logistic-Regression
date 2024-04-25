# Load necessary libraries
library(caret)  # For data splitting and model evaluation
library(corrplot)  # For visualizing correlation matrix
library(pROC)  # For ROC curve and AUC calculation

# Load data
flood_data <- read.csv("flood_areas_clean.csv")

# Perform correlation analysis
correlation_matrix <- cor(flood_data)

# Visualize correlation matrix
corrplot(correlation_matrix, method = "color")

# Split the Data into Training and Testing Sets
set.seed(123)  # Set seed for reproducibility
trainIndex <- createDataPartition(flood_data$Flood, p = 0.8, list = FALSE)  # Split data into 80% training and 20% testing
data_train <- flood_data[trainIndex, ]  # Training data
data_test <- flood_data[-trainIndex, ]  # Testing data

# Train the Logistic Regression Model
model <- glm(Flood ~ ., data = data_train, family = binomial)  # Fit logistic regression model

# Evaluate Model Accuracy
# Predict probabilities
probabilities <- predict(model, newdata = data_test, type = "response")
# Convert probabilities to binary predictions
predictions <- ifelse(probabilities > 0.5, 1, 0)
# Calculate accuracy
accuracy <- mean(predictions == data_test$Flood)

# Model Performance Evaluation (AUC, ROC, MSE, RMSE)
# AUC-ROC
roc_obj <- roc(data_test$Flood, probabilities)
auc <- auc(roc_obj)
# Mean Squared Error (MSE) and Root Mean Squared Error (RMSE)
mse <- mean((data_test$Flood - probabilities)^2)
rmse <- sqrt(mse)

# Model Validation
# Confusion Matrix
conf_matrix <- table(data_test$Flood, predictions)  # Create confusion matrix
print(conf_matrix)  # Print confusion matrix
# ROC Curve
