#

# Download dataset and uncompress if absent
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




# Main

fetch_data()
