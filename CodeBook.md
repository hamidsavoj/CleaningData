
#Course Project for Getting and Cleaning Data


## Loading and Processing  Data

This data is originally extracted from 
[a link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

We used 
[a link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
               
Loaded the files 
    *features.txt"
    *activity_labels.txt"
    *train/X_train.txt
    *train/y_train.txt
    *train/subject_train.txt
    *test/X_test.txt
    *test/y_test.txt
    *test/subject_test.txt


into the corresponsing data frame variables features, activity_labels, X_train, y_train, subject_train, X_test, y_test, and subject_test.

## Merging, Cleaning, and Creating First Tidy Data

The rows of test data and train data are merged to created merged variables subject_merge, X_merge, and y_merge. The column names for **X_merge** data frame are copied from **features** data frame. Some of the names have errors that makes them not match the names of initial data. Corrections are made to convert BodyBody to Body. All columns of **X_merge** that have mean() or std() in their name are pulled out to form a new data frame called **X_merge_tidy**. An extra clean up step, removes **()** from the column names of **X_merge_tidy**. Also added a new column labeled **activity** that shows type of activity for each row of
**X_merge_tidy**. X_merge_tidy is written into the file X_merge_tidy.csv. The separator used for writing this data is **,Tab**.

## Creating Second Tidy Data

The variable **twofactor** is a list that combines activity and subject factors. The average for each subset of each column of **X_merge_tidy** is stored in a new data frame. All data frames are assembled into a list called **listOfDataFrames**. Each data frame has 6 rows corresponding to 6 activities and 30 columns corresponding to 30 subjects. The values stored at each data frame in **listOfDataFrames** correspond to averages of one of the columns of **X_merge_tidy**. The lables for each row of 
**listOfDataFrames[i]** are adjusted to represent the device and also the column of **X_merge_tidy**. This is done by concatenating the two string and storing it in the row lablel. Also an extra column is added to each dataframe storing the corresponding name of the column of **X_merge_tidy**.


The final tidy data **avgTidyData** is a dataframe obtained by combining all data frames in **listOfDataFrames**. This data is written to avgTidyData.csv. The separator used for writing this data is **,Tab**.