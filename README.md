# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. Clone the repo
2. Set your working directory to the root of the project.
3. Data is available [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  Download and extract this to your working directory.  The code commented at the top of the ```run_analysis.R``` will do this for you.
3. Run the script using ```source("run_analysis.R")```, this will create a cleaned data file called ```ttidiedData.txt``` in your working directory.

## Dependencies

The ```run_analysis.R``` script require the ```reshape2``` package to be installed. 
