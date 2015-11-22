##============================================================================================
## Subject: Getting and Cleaning Data Course Project
## Author: njhermit
## Date: 2015-11-21

# run_analysis.R does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.
##============================================================================================

#set working directory
setwd('G:/study/coursera/DataScience Specialization/Getting and cleaning data/UCI HAR Dataset')
library(plyr)
library(dplyr)

##-----------------------------------------------------------------
# 1. Merge the training and the test sets to create one data set.

# Read in the training data 
features <- read.table('./features.txt',header=FALSE) 
activity <- read.table('./activity_labels.txt',header=FALSE) 
subjTrain <- read.table('./train/subject_train.txt',header=FALSE) 
xTrain <- read.table('./train/x_train.txt',header=FALSE) 
yTrain <- read.table('./train/y_train.txt',header=FALSE) 

# look at the variables in each dataset
str(features)
str(activity)
str(xTrain)
str(yTrain)
str(subjTrain)

# xTrain, yTrain and subjTrain have the same number os obs which is 7352
# second column of features corresponds to row names of xTrain, which has a length of 561

colnames(subjTrain) <- "subjID"
colnames(xTrain) <- features[,2] 
colnames(yTrain) <- "actID"
# Create a complete training data set
trainData <- cbind(subjTrain,xTrain,yTrain)

# Read in test data
subjTest <- read.table('./test/subject_test.txt',header=FALSE)
xTest <- read.table('./test/x_test.txt',header=FALSE)
yTest <- read.table('./test/y_test.txt',header=FALSE)
colnames(subjTest) <- "subjID"
colnames(xTest) <- features[,2] 
colnames(yTest) <- "actID"
# Create a complete test data set
testData <- cbind(subjTest,xTest,yTest)

# Merge the training and the test data into a final data set
AllData <- rbind(trainData,testData)
dim(AllData)  # 10299 by 563 

##-------------------------------------------------------------------------------------------
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create an Indicator that equals TRUE for measurements on the mean and std.dev and FALSE for other measurements
Ind = (grepl("actID",colnames(AllData)) | 
            grepl("subjID",colnames(AllData)) | 
            grepl("-mean..",colnames(AllData)) & !grepl("-meanFreq..",colnames(AllData)) & !grepl("mean..-",colnames(AllData)) |
            grepl("-std..",colnames(AllData)) & !grepl("-std()..-",colnames(AllData)))

AllData <- AllData[Ind==TRUE]
dim(AllData) # 10299 by 20 

##------------------------------------------------------------------------------
# 3. Use descriptive activity names to name the activities in the data set
colnames(activity) <- c('actID','actType')
AllData <- merge(AllData,activity,by='actID',all.x=TRUE)

# look at column names of AllData to see how we can improve the activity names
colnames(AllData)
#[1] "actID"                       "subjID"                      "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
#[5] "tGravityAccMag-mean()"       "tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
#[9] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
#[13] "fBodyAccMag-mean()"          "fBodyAccMag-std()"           "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
#[17] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 
#[21] "actType" 


##-----------------------------------------------------------------------
# 4. Appropriately label the data set with descriptive activity names. 
ColNames <- colnames(AllData)
# Use clearer labels
for (i in 1:length(ColNames)) {
  
  ColNames[i] <- gsub("\\()","",ColNames[i])          # Remove parentheses
  ColNames[i] <- gsub("-std$","StdDev",ColNames[i])
  ColNames[i] <- gsub("-mean","Mean",ColNames[i])
  ColNames[i] <- gsub("^(t)","Time",ColNames[i])
  ColNames[i] <- gsub("^(f)","Frequency",ColNames[i])
  ColNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",ColNames[i])
  ColNames[i] <- gsub("AccMag","AccMagnitude",ColNames[i])
  ColNames[i] <- gsub("GyroMag","GyroMagnitude",ColNames[i])
  ColNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",ColNames[i])
  ColNames[i] <- gsub("JerkMag","JerkMagnitude",ColNames[i])

}

colnames(AllData) <- ColNames

##----------------------------------------------------------------------
# 5. Create a second, independent tidy data set with the average of 
#    each variable for each activity and each subject. 

tidyData <- ddply(AllData, c("subjID","actID"), numcolwise(mean))
str(tidyData)  # 180 by 20: there are 30 subjects with 6 activity types for each subject

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t')

