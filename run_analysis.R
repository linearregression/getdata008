#
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. #Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set of global variables
result <- 'tidydata.txt'

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

# The goal is to create a single table of all data on each subject. One observation is on a subject per timestamp.
# From READMEwe know we have 10299 number of observations
setwd("./UCI HAR Dataset")
known_observations = 10299

activityLabels <- read.table(file='activity_labels.txt', skipNul=TRUE, stringsAsFactors=FALSE)
# merge test and train subject ids
subject_set <- mergedata('subject')
# merge test and train y (activity index)
activity_index <- mergedata('y')

# merge test and train X (time series measurement)
timeseries_data <- mergedata('X')

# Check for number of rows match
if(known_observations-nrow(subject_set) ==0) { stop('Number of observatons not equal to doc')}
if((nrow(subject_set) - nrow(activity_index) == 0) { stop('subject index not equals activity index') }
if((nrow(timeseries_data) - nrow(activity_index) == 0) { stop('activity index not equal time series data') }






# save tidydata result
savetidydata <- function() {


}

# Util function
mergedata <- function(filename) {
   requirethat(!is.na(filename), 'Filename is absent')
   data_train <-read.table(file=paste('train//', filename, '_train.txt', sep=''), skipNul=T, stringsAsFactors=F)
   data_test <-read.table(file=paste('test//', filename, '_test.txt', sep=''), skipNul=T, stringsAsFactors=F)
   merged <- rbind2(x=data_train, y=data_test)
   rm(list=c('data_train','data_test'))
   merged
}

requirethat <- function(predicate, message) {
        if(!(predicate)) stop(message) 
}

# Main

fetch_data()
mergedata <- merge_testtrain()

setwd("..")
savetidydata()
