#File: run_analysis
#Course: getting and ceanng data
#Section:  final project
#Author: tinbqt 
#Date: 2021-07-28

#checking file if it is existing.
filename <- "UCI_HAR_Dataset.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,filename)
}

#Checking if zip file is available or not
if (!file.exists("UCR HAR Dataset")){
  unzip(filename)
}
# name the dataframe
feature <- read.table("UCI HAR Dataset/features.txt",col.names = c("n1","features"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("n2","activity"))

#name the test dataset
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",col.names=feature$features)
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt",col.names="n2")
rm(subject)

#name the train dataset
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names ="subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feature$features)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "n2")

#1. Merges the training and the test sets to create one data set
X <- rbind(x_train,x_test)
Y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)
Merged_Data <- cbind(subject,Y,X)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)
TidyData <- select(Merged_Data,subject, n2, contains("mean"), contains("std"))


#3. Uses descriptive activity names to name the activities in the data set
TidyData$n2 <- activities[TidyData$n2, 2]

#4. Appropriately labels the data set with descriptive variable names. 
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

#step 6 checkin the result in uing read.table()
df <- read.table("FinalData.txt")
