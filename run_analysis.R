#
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. #Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
rm(list=ls())
# Set of global variables
result <- 'tidydata.txt'

# Download dataset and uncompress if absent
datafolder <- './UCI HAR Dataset'
fetch_data <- function() {
   zipData <- './UCI%20HAR%20Dataset.zip'
   if(!(file.exists('UCI HAR Dataset') | file.exists(zipData))) {
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

# Merge test/train data into one dataset. SubjectId and Activity prepend as columns
# to help identify what data relate to which subjects
combine_data <- function() {
    known_observations = 10299
    known_features = 561

    # merge test and train subject ids
    subject_set <- mergedata('subject')
    # merge test and train y (activity index)
    activity_index <- mergedata('y')
    # merge test and train X (time series measurement)
    timeseries_data <- mergedata('X')
    col  <- read.csv(file='./features.txt', sep='', header=FALSE, stringsAsFactors=F, strip.white=TRUE)

    # Check for number of rows match
    if(known_observations-nrow(subject_set) !=0)
        { stop('Number of observatons not equal to doc')}
    if(nrow(subject_set) - nrow(activity_index) != 0)
        { stop('subject index not equals activity index') }
    if(nrow(timeseries_data) - nrow(activity_index) != 0)
        { stop('activity index not equal time series data') }
    if(known_features-nrow(col) !=0)
        { stop('Number of feature columns not equal to doc')}
    master_dataset <- cbind(subject_set, activity_index, timeseries_data)
    # name the columns
    colnames(master_dataset) <- c('subjectId', 'activityId', as.character(col$V2))
    # expand activityIds to corresponding descriptions
    master_dataset <- transform_activityId(master_dataset)
    rm(list=c('subject_set', 'activity_index', 'timeseries_data','col'))
    master_dataset
}

# clease column names.
cleanse_colname <- function(dataset) {
     print('clenasecolumne')
     print(is.data.frame(dataset))
     print(class(dataset))
     requirethat(is.data.frame(dataset), 'Columns names cannot be absent')
     columns <- colnames(dataset)
     # remove ()
     # expand leading t, f as time,frequency
     # expand various shorthands
     columns <- lapply(columns, FUN=function(x) {
                   x <- gsub(pattern='*\\(\\)*', '', x) 
                   x <- sub(pattern='*Acc', "Accelerometer", x) 
                   x <- sub(pattern="*Gyro", "Gyroscope", x) 
                   x <- sub(pattern='*Mag', "Magnitude", x)
                   x <- sub(pattern='*std', "standarddeviation", x)
                   x <- sub(pattern='^f', 'frequency-', x)
                   x <- sub(pattern='^t', 'time-', x) 
               })
     return(unlist(columns))
}

# map acitivityId to activity name
transform_activityId <- function(dataset) {
     requirethat(is.data.frame(dataset), 'Dataset cannot be absent or NULL')
     activityLabels <- read.table(file='activity_labels.txt', skipNul=TRUE, stringsAsFactors=FALSE)
     # update activityId with activity descriptions
     dataset[2] <- lapply(dataset[2], function(x) activityLabels$V2[x] )
     return(dataset)
}

# filter data for mean and standard deviation per assignment
# We only care about columns that have either mean or stardard deviations
filter_data <- function(dataset) {
     requirethat(is.data.frame(dataset), 'Dataset cannot be absent or NULL')
     colsextracted <- colnames(dataset)
     cols_mean <- grep(pattern="*-mean\\(\\)*", colsextracted, ignore.case=T)
     cols_std <- grep(pattern="*-std\\(\\)*", colsextracted, ignore.case=T)
     col_index <- union(c(1,2,cols_mean),cols_std)
     colsextracted <- dataset[col_index]
     col <- cleanse_colname(colsextracted)
     # assign new labelled columns
     colnames(colsextracted) <- col
     rm(list=c('col','cols_mean','cols_std', 'col_index'))
     return(colsextracted)
}


# extract relevant columns and calculate average of each
# group by subjectId and activity
independent_data <- function(dataset) {
     library(plyr)
     requirethat(is.data.frame(dataset), 'Dataset cannot be absent or NULL')
     n = length(colnames(dataset))
     ddply(dataset, .(subjectId, activityId), .fun=function(x){ colMeans(x[, 3:n], na.rm = TRUE)}) 
}

# save tidydata result
savetidydata <- function(data, filename='tidydata.csv') {
     requirethat(is.data.frame(data), 'Dataset cannot be absent or NULL')
     requirethat(!is.na(filename), 'Filename is absent') 
     write.table(data, file=filename, sep="\t", row.names=FALSE)
     TRUE
}

# Util functions
# merge test and train datasets. based on folder and file naming conventions observed 
mergedata <- function(filename) {
     requirethat(!is.na(filename), 'Filename is absent')
     data_train <-read.table(file=paste('train//', filename, '_train.txt', sep=''), skipNul=T, stringsAsFactors=F)
     data_test <-read.table(file=paste('test//', filename, '_test.txt', sep=''), skipNul=T, stringsAsFactors=F)
     merged <- rbind2(x=data_train, y=data_test)
     rm(list=c('data_train','data_test'))
     return(merged)
}

# check predicates and stopexecution with error message
requirethat <- function(predicate, message) {
     if(!(predicate)) stop(message) 
}

# Main
fetch_data()
print('Done fetch data')
master_data <- combine_data()
print('Done reading and combing data')
master_data <- filter_data(master_data)
print('Done filter data')
average_data <- independent_data(master_data)
print('Done calculating averages')
savetidydata(average_data, filename='../tidaydata.csv')
print('Done writing tidydata')
setwd("..")
rm(list=ls())


