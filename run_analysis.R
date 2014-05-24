##run_analysis.R
##The purpose of this script is to create tidy data. The original source of data is
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


features<-read.table("features.txt")
activity_lables<-read.table("activity_labels.txt")

##read the training set
X_train<-read.table("train/X_train.txt")
y_train<-read.table("train/y_train.txt")
subject_train<-read.table("train/subject_train.txt")

##read the test set
X_test<-read.table("test/X_test.txt")
y_test<-read.table("test/y_test.txt")
subject_test<-read.table("test/subject_test.txt")

#merge files
subject_merge<-rbind(subject_train, subject_test)
X_merge<-rbind(X_train, X_test)
y_merge<-rbind(y_train, y_test)

##cleanup the names in features$V2. Change BodyBody to Body.
features$V2<-gsub("BodyBody", "Body", features$V2, fixed=TRUE)

##set the column names in X_Train from features list
colnames(X_merge)<-features$V2

##subseting to get mean() and std() columns
cols<-c(grep("mean()", colnames(X_merge), fixed=TRUE), grep("std()", colnames(X_merge), fixed=TRUE))

##get the relevant columns into a new data frame
X_merge_tidy<-X_merge[,sort(cols)]

##get rid of () in column names
colnames(X_merge_tidy)<-gsub("()", "", colnames(X_merge_tidy), fixed = TRUE)
colnames(X_merge_tidy)<-gsub("-", ".", colnames(X_merge_tidy), fixed = TRUE)

##create a new column that has activity labels. 
X_merge_tidy$activity <- activity_lables$V2[y_merge$V1]

##file looks cleaner using capture
options(max.print=5.5E5) 
capture.output( print(X_merge_tidy, print.gap=3), file="X_merge_tidy.txt")

##creating second data set 
##combine activity with subject for subsetting the data
##mean computes the average of each subset 
##results is stored listOfDataFrames. 
##There are 66 columns of data. A new data frame is created for each column. All data frames are stored in a list.
##The list is called listOfDataFrames.
##Row labels in each  data frame  show where data is coming from
## Used unmatrix from gdata library to convert matrix to vector and then data frame
twofactor<- list(X_merge_tidy$activity, factor(subject_merge$V1))
listOfDataFrames <- NULL
colLength<-length(cols)
for (i in 1:colLength) {
    listOfDataFrames[[i]]<-as.data.frame(unmatrix(tapply(X_merge_tidy[,i], twofactor, FUN=mean)))
    colnames(listOfDataFrames[[i]])<-colnames(X_merge_tidy)[i]
}

##combine all data frame into one large dataframe
##since row names are adjusted. It is easy to figure out where the average is coming from.
avgTidyData<-as.data.frame(do.call(cbind, listOfDataFrames))

##file looks cleaner using capture
capture.output( print(avgTidyData, print.gap=3), file="AvgTidyData.txt")


