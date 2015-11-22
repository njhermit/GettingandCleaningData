The script run_analysis.R performs the following tasks:

1. Merges the training and the test sets to create one data set.

   During this step, I read in the raw training data sets and the raw test data sets, listed as follows:
   

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

   
   Then I create a single training data set and a single test data set after renaming the column names, and finally I merge these two into one complete data set which I call "AllData".

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

   During this step, I create an Indicator that equals TRUE for measurements on the mean and std.dev and FALSE for other measurements and then I use this logic indicator to subset the AllData file.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

   During this step, I improve the activity names of AllData by using more interpretable variable labels
   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.The output data file is called:

- 'tidyData.txt': Final tidy data to be submitted.



