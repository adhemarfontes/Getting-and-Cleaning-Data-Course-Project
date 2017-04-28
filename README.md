# README - Getting-and-Cleaning-Data-Course-Project

This project contains:
* UCI HAR Dataset.zip - Original Samsung data used for the project
* run_analysis.R - Script to transform the data
* merge.csv - Tidy data set containing subject id, activity and 561 variables os data
* average_vars.csv - Tidy data set with the average of each variable for each activity and each subject
* CodeBook.md - a code book that describes the variables, the data, and any transformations or work that you performed to clean up

## run_analysis.R

Script to transform the data with 4 functions

* runScript
Main function that calls three operation functions

* mergeFiles
Load train and test data, place 2 new columns subject id (matching lines from files subject_test.txt / subject_train.txt) and activity label, fill those columns for each row, merge data into merge.csv

* cleanDataset
Load merge.csv, copy to a new data frame, extracting only the measurements on the mean and standard deviation for each measurement. Appropriately labels the data set with descriptive variable names. Save again as merge.txt.

* calculateMean
Load merge.txt, creates tidy data set with the average of each variable for each activity and each subject. Save as average_vars.txt using write.table().

To run this script:

* Open RStudio
* Copy script "run_analysis.R" to working directory
* Extract "UCI HAR Dataset.zip" into the working directory (it will create a folder "UCI HAR Dataset")
* Run command > source("run_analysis.R")
* Run command > runScript()