runScript <- function(){
  mergeFiles()
  cleanDataset()
  calculateMean()
}  

mergeFiles <- function(){
  library(stringr)
  
  #load activity labels
  labels <- read.csv("./UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE)  

  #load test data and set linetest attribute
  fileName="./UCI HAR Dataset/test/X_test.txt"
  con=file(fileName,open="r")
  linetest=readLines(con) 
  close(con)
  
  #load test activities per line and set linetest_y attribute
  fileName="./UCI HAR Dataset/test/y_test.txt"
  con=file(fileName,open="r")
  linetest_y=readLines(con) 
  close(con)
  
  #load test subjects per line and set linetest_sub attribute
  fileName="./UCI HAR Dataset/test/subject_test.txt"
  con=file(fileName,open="r")
  linetest_sub=readLines(con) 
  close(con)
  
  count_lines = length(linetest);
  print(count_lines)
  #go through test data and add correspondent activity label on beging of each line (fixed width of 20 chars)
  for (i in 1:count_lines){
    #add activity
    linetest[i] = paste( str_pad(labels[ labels$V1 == linetest_y[i],]$V2, 20, side="right", " ") , linetest[i], sep = "")
    #add subject
    linetest[i] = paste( str_pad(linetest_sub[i], 10, side="right", " ") , linetest[i], sep = "")
  }

  #load train data and set linetrain attribute
  fileName="./UCI HAR Dataset/train/X_train.txt"
  con=file(fileName,open="r")
  linetrain=readLines(con) 
  close(con)
  
  #load train activities per line and set linetrain_y attribute
  fileName="./UCI HAR Dataset/train/y_train.txt"
  con=file(fileName,open="r")
  linetrain_y=readLines(con) 
  close(con)
  
  #load train subjects per line and set linetrain_sub attribute
  fileName="./UCI HAR Dataset/train/subject_train.txt"
  con=file(fileName,open="r")
  linetrain_sub=readLines(con) 
  close(con)

  count_lines = length(linetrain);
  print(count_lines)
  #go through train data and add correspondent subject (test ou train) and activity label on beging of each line (fixed width of 20 chars)
  for (i in 1:count_lines){
    #add activity
    linetrain[i] = paste( str_pad(labels[ labels$V1 == linetrain_y[i],]$V2, 20, side="right", " ") , linetrain[i], sep = "")
    #add subject
    linetrain[i] = paste( str_pad(linetrain_sub[i], 10, side="right", " ") , linetrain[i], sep = "")
  }

  #open file to save combined data
  fileConn<-file("./merge.txt")
  #combine test and train data with activities labels
  z<-c(linetrain, linetest)
  writeLines(z, fileConn)
  close(fileConn)
}


cleanDataset <- function(){
  library(stringr)

  #load merged data and set merge attribute
  fileName="./merge.txt"
  con=file(fileName,open="r")
  merge=readLines(con) 
  close(con)
  
  #load features (file containing attribute collected - column titles)
  features <- read.csv("./UCI HAR Dataset/features.txt", sep = " ", header = FALSE)  
  count_features = nrow(features);

  #create two vectors with index and label for each attribute collected
  meansandstd = {}
  meansandstd.label = {}
  meansandstd.idx = 1;
  for (i in 1:count_features){
    #only save attributes with mean and std on name
    if ( ((length(grep("mean()", features[i,2], value = TRUE)) != 0 ) && (length(grep("meanFreq()", features[i,2], value = TRUE)) == 0 )) || 
         (length(grep("std()", features[i,2], value = TRUE))  != 0)){
      meansandstd[meansandstd.idx] = i
      meansandstd.label[meansandstd.idx] = as.character(features[i,2])
      meansandstd.idx = meansandstd.idx + 1
    }
  }  

  #create data frame containg data from merge file (fixed width) to save to a csv
  df <- data.frame()
  count_lines = length(merge);
  count_vars = length(meansandstd);
  for (i in 1:count_lines){
    df[i, 1] <- list( substr(merge[i], 1, 10) )
    df[i, 2] <- list( substr(merge[i], 11, 30) )
    for (j in 1:count_vars){
      df[i, 2 + j] <- list( substr(merge[i], 31 + ((meansandstd[j] - 1)* 16), 31 + ((meansandstd[j])* 16)) )
    }  
  }
  
  #set variable names usinf feature titles
  colnames(df)[1] <- "Subject"
  colnames(df)[2] <- "Activity"
  for (j in 1:count_vars){
    colnames(df)[j+2] <- meansandstd.label[j]
  }
  
  #save data frame as csv
  fileName="./merge.csv"
  write.csv(df, fileName)
}  

calculateMean <- function(){
  library(reshape2)
  library(dplyr)
  
  merge <- read.csv("./merge.csv")  
  
  activities <- dcast(merge, Subject + Activity ~ .)

  columns = names(merge);
  count_columns = length(columns)
  
  colnames(activities)[3] <- "Count"
  count_activities = nrow(activities);
  
  
  for (j in 4:count_columns){ 
    for (i in 1:count_activities){ 
      mergeSubset <- filter(merge, Subject == activities[i, c('Subject')], Activity == activities[i, c('Activity')])
      activities[i, j] <- mean(mergeSubset[,c( columns[j] )])
    } 
    colnames(activities)[j] <- gsub("...", ".", columns[j], fixed = TRUE)
    colnames(activities)[j] <- gsub("..", ".", columns[j], fixed = TRUE)
  }

  #save data frame as csv
  fileName="./average_vars.txt"
  write.table(activities, fileName, row.name=FALSE)
  
  
}
