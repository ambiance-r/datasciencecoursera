# Practical Machine Learning - Week 4 assignment:

setwd("C:/Users/user/datasciencecoursera/PracticalMachineLearning-AssignmentWeek4")
library(caret)
library(randomForest)
library(dplyr)
library(rpart)
library(rattle)
set.seed(12345)


# Data:
training <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", header = TRUE, na.strings=c("","NA"))
testing <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", header = TRUE, na.strings=c("","NA"))

# Before modelling, the original dataset is cleaned to make the model analysis easier. First, many variables 
# have missing values (NAs). These are removed from the training and testing datasets:

trcol <- dim(training)[2]
nacell <- data.frame(matrix(ncol = trcol, nrow = 1))
for (i in 1:trcol){
  nacell[,i] <- sum(is.na(training[,i]))
  i <- i+1
}
training2 <- training[, which(nacell==0)]

testcol <- dim(testing)[2]
nacell2 <- data.frame(matrix(ncol = testcol, nrow = 1))
for (i in 1:testcol){
  nacell2[,i] <- sum(is.na(testing[,i]))
  i <- i+1
}
testing2 <- testing[, which(nacell2==0)]

# The time related variables "raw_timestamp_part_1, raw_timestamp_part_2 and cvtd_timestamp" are removed
# as the focus is rather on the variables that have an effect on the classe variable. The index variable, X, 
# is also not needed and therefore removed:

training3 <- select(training2,-c("X", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp"))
testing3 <- select(testing2,-c("X", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp"))

# Also, variables with very little variability are removed:
novar <- nearZeroVar(training3)
trainining3 <- training3[-novar]
testing3 <- testing3[-novar]

# Estimation and Prediction:

# To predict the classe variable, two popular approaches have been used: decision tree and random forest 
# First, the training data is split into sub-training and sub-testing data, named train_cv and test_cv,
# to check for model accuracy, after which, the chosen model will be used for estimation and prediction 
# using the testing data.

inTrain <- createDataPartition(y = training3$classe, p=.75, list = FALSE)
train_cv <- training3[ inTrain, ]
test_cv  <- training3[-inTrain, ]

# Random forest:
model_rf <- randomForest(classe ~ ., data=train_cv)
pred_rf <- predict(model_rf, test_cv)
accuracy_rf <- confusionMatrix(table(pred_rf, test_cv$classe))$overall[1]
print(accuracy_rf)

# Decision tree:
model_tree <- rpart(classe ~ ., data=train_cv, method="class")
pred_tree <- predict(model_tree, test_cv, type = "class")
accuracy_tree <- confusionMatrix(table(pred_tree, test_cv$classe))$overall[1]
print(accuracy_tree)

fancyRpartPlot(model_tree)

# The accuracy of the random forest is 99.7 % while that of decision tree is 72.8%. Therefore, the
# former can now be used to predict classe using the test sample. 

model_rf2 <- randomForest(classe ~ ., data=training3)
