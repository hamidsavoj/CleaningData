
#Course Project for Getting and Cleaning Data


## Loading and Processing  Data

This data is originally extracted from 
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

We used 
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
               
Loaded the files 

    * features.txt"
    * activity_labels.txt"
    * train/X_train.txt
    * train/y_train.txt
    * train/subject_train.txt  
    * test/X_test.txt
    * test/y_test.txt
    * test/subject_test.txt


into the corresponsing data frame variables features, activity_labels, X_train, y_train, subject_train, X_test, y_test, and subject_test.

## Merging, Cleaning, and Creating First Tidy Data

The rows of test data and train data are merged to created merged variables subject_merge, X_merge, and y_merge. The column names for **X_merge** data frame are copied from **features** data frame. Some of the names have errors that makes them not match the names of initial data. Corrections are made to convert BodyBody to Body. All columns of **X_merge** that have mean() or std() in their name are pulled out to form a new data frame called **X_merge_tidy**. An extra clean up step, removes **()** from the column names of **X_merge_tidy** and converts "-" to ".". Also added a new column labeled **activity** that shows type of activity for each row of
**X_merge_tidy**. X_merge_tidy is written into the file X_merge_tidy.txt.

Many of the standrad deviation columns have negative values. Since Standard Deviation is a square root function, it has to be greater than or equal to 0. I can correct those values by taking absolute values of all STD values but I am not sure if this is correct or not. I am going to leave this alone for the purpose of this assignment.

## Creating Second Tidy Data

The variable **twofactor** is a list that combines activity and subject factors. The average for each subset of each column of **X_merge_tidy** is stored in a new data frame. All data frames are assembled into a list called **listOfDataFrames**. Each data frame has 180 rows corresponding to 6 activities and 30 subjects, and 1 column corresponding to column in **X_merge_tidy**. The values stored at each data frame in **listOfDataFrames** correspond to averages of one of the columns of **X_merge_tidy**. The lables for each row of 
**listOfDataFrames[i]** are adjusted to represent the device and activity. This is done by unmatrix function in gdata library. 



The final tidy data **avgTidyData** is a dataframe obtained by combining all data frames in **listOfDataFrames**. This data is written to avgTidyData.txt. 