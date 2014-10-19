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

# Script flow :

-Data from test and train files are loaded and combined (Subject,Labels)

-The features labels are input from features.txt. The indices containing the mean() or the std() measures are stored in a vector (indices), and the the features corresponding tto those indices are stored in a vector(features).

-The test and train features are concatenated and all columns are removed that do not have an index in the indices vector; only the columns with a mean() or std() remain.

-A new data set,tidydata, is created by aggregating the merged dataset based on the mean of all numeric columns by the subject and activity.

-tidydata is output to a file named tidydata.txt

# Output:
Resultant files is a single file tidydata.txt 

