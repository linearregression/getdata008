getdata008 - Assignment 1
==========
## Introduction
run_analysis.R automates the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Usage
Go to the directory containing the run_analysis.R. The type.

```{r download, echo=TRUE}

source('run_analysis.R')

```
# Data codebook

Data Codebook provides more information such as data labelling, of information etc tidydata.txt

Data Codebook located below:
[https://github.com/linearregression/getdata008/blob/master/codebook.md](https://github.com/linearregression/getdata008/blob/master/codebook.md)

# Script flow :
Each activity is associated with an integer number (1-6), from activity_labels.txt. y_train and y_test files contains the list of columns 
numbered index associated with actvity labels for data files X_train and X_test.

-Data from test and train files are loaded and combined (Subject,Labels)

-The features labels are input from features.txt. The indices containing the mean() or the std() measures are stored in a vector (indices), and the the features corresponding tto those indices are stored in a vector(features).

-The test and train features are concatenated and all columns are removed that do not have an index in the indices vector; only the columns with a mean() or std() remain.

-A new data set,tidydata, is created by aggregating the merged dataset based on the mean of all numeric columns by the subject and activity.

-tidydata is output to a file named tidydata.txt

# Output:
Resultant files is a single file tidydata.txt 

