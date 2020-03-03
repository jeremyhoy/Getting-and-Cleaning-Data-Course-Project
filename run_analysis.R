#Download and unzip data files

dataFile <- 'HAR.zip'
dataFolder <- 'UCI HAR Dataset'

if (!file.exists("HAR.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        ,dataFile)
}

if(!file.exists(dataFolder)){
    unzip(dataFile)
}

#Read data into data.frames
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

#Create a logical vector identifying mean and std values from the features list
featureNames <- features[,2]

#1. Merges the training and the test sets to create one data set.

subject <- rbind(subjectTest, subjectTrain)
colnames(subject) <- c("subjectId")

activity <- rbind(yTest, yTrain)
colnames(activity) <- c("activity")

measures <- rbind(xTest, xTrain)
colnames(measures) <- featureNames

combinedData <- cbind(subject, activity, measures)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

extractFeatures <- grepl("subjectId|activity|mean\\(\\)|std\\(\\)", colnames(combinedData))

extractedData <- combinedData[,extractFeatures]

#3. Uses descriptive activity names to name the activities in the data set

extractedData$activity <- factor(extractedData$activity, 
                                 levels = activityLabels[, 1], labels = activityLabels[, 2])

#4. Appropriately labels the data set with descriptive variable names.

combinedVariableNames <- colnames(extractedData)

#create descriptive variable names - remove special characters and expand abbreviations
cleanFeatures <- gsub("[\\(\\)-]", "", combinedVariableNames)
cleanFeatures <- gsub("^f", "frequency", cleanFeatures)
cleanFeatures <- gsub("^t", "time", cleanFeatures)
cleanFeatures <- gsub("Acc", "Accelerometer", cleanFeatures)
cleanFeatures <- gsub("Gyro", "Gyroscope", cleanFeatures)
cleanFeatures <- gsub("Mag", "Magnitude", cleanFeatures)
cleanFeatures <- gsub("mean", "Mean", cleanFeatures)
cleanFeatures <- gsub("std", "StandardDeviation", cleanFeatures)

colnames(extractedData) <- cleanFeatures

#5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#   each variable for each activity and each subject.
library(reshape2)

melted <- melt(extractedData, id=c("subjectId","activity"))
tidied <- dcast(melted, subjectId+activity ~ variable, mean)

# create final file of tidied data
write.table(tidied, "tidiedData.txt",row.names = FALSE)

