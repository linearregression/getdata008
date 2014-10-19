#
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. #Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Download dataset and uncompress if absent
datafolder <- './UCI HAR Dataset'
fetch_data <- function() {
   zipData <- './UCI%20HAR%20Dataset.zip'
   if(!file.exists('UCI HAR Dataset') & !file.exists('UCI%20HAR%20Dataset')) {
      print('Downloading activity.zip ....')   
      download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile=zipData, method='curl')
   }
   if(!file.exists('UCI HAR Dataset')) {
      print('Unzip UCI HAR Dataset.zip ....')  
      unzip(zipfile=zipData, overwrite=TRUE)
   }
}

# 
setwd("./UCI HAR Dataset")
featuresList <- read.table(file='activity_labels.txt', skipNul=TRUE, stringsAsFactors=FALSE)




# Main

fetch_data()
