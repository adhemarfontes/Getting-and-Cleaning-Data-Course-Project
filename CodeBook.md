# Code Book - Getting-and-Cleaning-Data-Course-Project

## Data used

* UCI HAR Dataset/activity_labels.txt
Contains a pair of key and label for each activity monitored

* UCI HAR Dataset/test/y_test.txt
Each line has one number that represents the activity used to collect the data in X_test.txt. Number of lines must match in this two files.

* UCI HAR Dataset/test/subject_test.txt
Each line has one number that represents the subject id used to collect the data in X_test.txt. Number of lines must match in this two files.

* UCI HAR Dataset/test/X_test.txt
Data collected for test purpose. Each line is a measurement containing 561 variables.

* UCI HAR Dataset/train/y_train.txt
Each line has one number that represents the activity used to collect the data in X_train.txt. Number of lines must match in this two files.

* UCI HAR Dataset/train/X_train.txt
Data collected for train purpose. Each line is a measurement containing 561 variables.

* UCI HAR Dataset/train/subject_train.txt
Each line has one number that represents the subject is used to collect the data in X_train.txt. Number of lines must match in this two files.

* UCI HAR Dataset/features.txt
Label for each of the 561 variables collected and represented in X_test.txt and X_train.txt.

## Transformation

* Loaded "UCI HAR Dataset/test/X_test.txt" and added fixed 10 chars containg the correspondent subject and 20 chars containing the label for the related activity (match line position between X_test.txt, y_test.txt and subject_test.txt).
* Loaded "UCI HAR Dataset/test/X_train.txt" and added fixed 10 chars containg the correspondent subject and 20 chars containing the label for the related activity (match line position between X_train.txt, y_train.txt and subject_train.txt).
* Combined both files and save in merge.txt.
* Selected the position of the variables for the measurements on the mean and standard deviation for each measurement.
* Created a data frames copying 2 first columns: subject id and activity.
* Added to the data frame the values only for the variables on the mean and standard deviation for each measurement (based on the position).
* Setted the column titles for the data frame.
* Saved to merge.csv (preserving merge.txt).
* Loaded merge.txt into merge object
* Used "dcast(merge, Subject + Activity ~ .)" on data to create a summary based on the pair subject + activity and create "activities" data frame .
* For each combination in "activities" dataset, applied a filter to merge dataset > "mergeSubset <- filter(merge, Subject == activities[i, c('Subject')], Activity == activities[i, c('Activity')])" 
* For the subset, calculate the average for each variable and save the value in "activities" data frame.
* Save "activities" data frame into "average_vars.txt"


## Output file average_vars.txt

File containing the final tidy  dataset request by the project. Each row represents an unique combination of subject id and activity (LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS) and the variables 

Below the classification columns:

* Subject: ID present on files subject_test.txt / subject_train.txt
* Activity: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
* Count: number of record in the original file for each combination of subject and activity

Below the data columns with the mean for each variable mean or std for each combination of subject and activity:
* tBodyAcc.mean..X
* tBodyAcc.mean..Y
* tBodyAcc.mean..Z
* tBodyAcc.std..X
* tBodyAcc.std..Y
* tBodyAcc.std..Z
* tGravityAcc.mean..X
* tGravityAcc.mean..Y
* tGravityAcc.mean..Z
* tGravityAcc.std..X
* tGravityAcc.std..Y
* tGravityAcc.std..Z
* tBodyAccJerk.mean..X
* tBodyAccJerk.mean..Y
* tBodyAccJerk.mean..Z
* tBodyAccJerk.std..X
* tBodyAccJerk.std..Y
* tBodyAccJerk.std..Z
* tBodyGyro.mean..X
* tBodyGyro.mean..Y
* tBodyGyro.mean..Z
* tBodyGyro.std..X
* tBodyGyro.std..Y
* tBodyGyro.std..Z
* tBodyGyroJerk.mean..X
* tBodyGyroJerk.mean..Y
* tBodyGyroJerk.mean..Z
* tBodyGyroJerk.std..X
* tBodyGyroJerk.std..Y
* tBodyGyroJerk.std..Z
* tBodyAccMag.mean.
* tBodyAccMag.std.
* tGravityAccMag.mean.
* tGravityAccMag.std.
* tBodyAccJerkMag.mean.
* tBodyAccJerkMag.std.
* tBodyGyroMag.mean.
* tBodyGyroMag.std.
* tBodyGyroJerkMag.mean.
* tBodyGyroJerkMag.std.
* fBodyAcc.mean..X
* fBodyAcc.mean..Y
* fBodyAcc.mean..Z
* fBodyAcc.std..X
* fBodyAcc.std..Y
* fBodyAcc.std..Z
* fBodyAccJerk.mean..X
* fBodyAccJerk.mean..Y
* fBodyAccJerk.mean..Z
* fBodyAccJerk.std..X
* fBodyAccJerk.std..Y
* fBodyAccJerk.std..Z
* fBodyGyro.mean..X
* fBodyGyro.mean..Y
* fBodyGyro.mean..Z
* fBodyGyro.std..X
* fBodyGyro.std..Y
* fBodyGyro.std..Z
* fBodyAccMag.mean.
* fBodyAccMag.std.
* fBodyBodyAccJerkMag.mean.
* fBodyBodyAccJerkMag.std.
* fBodyBodyGyroMag.mean.
* fBodyBodyGyroMag.std.
* fBodyBodyGyroJerkMag.mean.
* fBodyBodyGyroJerkMag.std.
