This is the codebook that describes the data, the variables, and any transformations or work that I performed to clean up the data to obtain the final tidy data file.

-----Data

Input data files:
- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

Output data files:

- 'tidyData.txt': final tidy data submitted.

The tidyData.txt that I submitted contains 180 rows/observations (corresponding to the 30 subjects with 6 activity types for each subject) and 20 cloumns/variables (corresponding to only mean and standard deviation the measurements for each feature).

-----Variables

The 20 variables are listed as follows -- among these variables, only two are interger and the rest 18 are all numeric. 

 $ subjID                              : int  
 $ actID                               : int  
 $ TimeBodyAccMagnitudeMean            : num  
 $ TimeBodyAccMagnitudeStdDev          : num  
 $ TimeGravityAccMagnitudeMean         : num  
 $ TimeGravityAccMagnitudeStdDev       : num  
 $ TimeBodyAccJerkMagnitudeMean        : num  
 $ TimeBodyAccJerkMagnitudeStdDev      : num  
 $ TimeBodyGyroMagnitudeMean           : num 
 $ TimeBodyGyroMagnitudeStdDev         : num  
 $ TimeBodyGyroJerkMagnitudeMean       : num 
 $ TimeBodyGyroJerkMagnitudeStdDev     : num 
 $ FrequencyBodyAccMagnitudeMean       : num  
 $ FrequencyBodyAccMagnitudeStdDev     : num  
 $ FrequencyBodyAccJerkMagnitudeMean   : num  
 $ FrequencyBodyAccJerkMagnitudeStdDev : num  
 $ FrequencyBodyGyroMagnitudeMean      : num  
 $ FrequencyBodyGyroMagnitudeStdDev    : num  
 $ FrequencyBodyGyroJerkMagnitudeMean  : num  
 $ FrequencyBodyGyroJerkMagnitudeStdDev: num  

-----Transformation 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
