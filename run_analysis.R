# Getting and Cleaning Data Assignment

f <- read.table("features.txt")

# Read "raw" data, using second column of feaures.txt as descriptive column names
X_test  <- read.table("test/X_test.txt"  , col.names = f[,2])
X_train <- read.table("train/X_train.txt", col.names = f[,2])

#head(X_test, 1)
#colnames(X_test)

Y_test <- scan("test/y_test.txt")
Y_train <- scan("train/y_train.txt")

subject_test <- scan("test/subject_test.txt")
subject_train <- scan("train/subject_train.txt")

activity_labels <- read.table("activity_labels.txt")

# Assume means contain "mean", and standard deviations contain "std" in column name
# keep only columns whose name has either "mean" or "std" embedded in it
testData <- X_test[ ,  grep( c("mean|std"), names(X_test)) ]
trainData <- X_train[ ,  grep( c("mean|std"), names(X_train)) ]

# add column with subject codes to test and training data
testData <- cbind(testData, subject_test)
trainData <- cbind(trainData, subject_train)

# add column with activity code to test and train data
testData <- cbind(testData, Y_test)
trainData <- cbind(trainData, Y_train)

# Re-name added columns 
names(testData)[80] <- "subject" 
names(testData)[81] <- "activity"
names(trainData)[80] <- "subject" 
names(trainData)[81] <- "activity"

# Combine test and training data
allData <- rbind(testData, trainData)
# Rename columns to be meaningfull and enable use of join function
names(activity_labels) <- c("activity", "activity_description")

# Library containing join function
library(plyr)

# Join by "activity" to add column with activity descritions
allData <- join(allData, activity_labels)

#m <- aggregate( allData[,1:79],  list(allData$subject, allData$activity), mean)

