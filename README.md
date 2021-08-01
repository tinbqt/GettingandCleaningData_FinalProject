# GettingandCleaningData_FinalProject

#File: run_analysis
#Course: getting and ceanng data
#Section:  final project
#Author: tinbqt 
#Date: 2021-07-28

Initial step
#checking file if it is existing or not -->  downloading file --> unzip the file
#reading dataframe; reading the test/train dataset

#1. Merges the training and the test sets to create one data set
    # combine X <- x_train and x_test
    # combine Y <- y_train and y_test
    # combine subject_train, subject_test
    # Final combine 3 above item into MergeData

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    #using the library dplyr to extract the mean and deviation for each measurement by using select command.
    
#3. Uses descriptive activity names to name the activities in the data set

#4. Appropriately labels the data set with descriptive variable names

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    #using the command group_by(); summarise_all() to output the tidy data sheet by using write.table()
