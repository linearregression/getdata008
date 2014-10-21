==========
## Introduction


run_analysis.R automates the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Background
Dataset is about wearable computing.  
Companies like Fitbit, Nike, and Jawbone Up are developing the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. The following dataset provided by UCI, is for experiment for predicting human activity using smartphone data.

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

There are 10299 Instances of Multivariate, Time-Series; each with 561 attribtues.


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

-Data from test and train files are combined, with subjectId and actitivtyId prepended as columns.
 AcitivytId are expanded to acitivity descriptions

-The features labels are input from features.txt. The indices containing the mean() or the std() measures are extracted.
 Columnes are cleaned by:
  * removing ()
  * Expanding Shorthands like Acc to Accelerometer etc
  * column names starting with t anf f are marked as time and frequency

- Averages are calcualted on columns with measurements, group by subject and activity

- A new data set,tidydata.csv is created and saved

-tidydata is output to a file named tidydata.txt

# Output:
Resultant files is a single file tidydata.txt 
To View output:
data<-read.table(file='tidaydata.txt', header=T)
View(data)
