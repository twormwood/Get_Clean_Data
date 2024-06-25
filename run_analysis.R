##Download data

if(!file.exists("./data")) {dir.create("./data")}
zipUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipUrl,destfile="UCI.zip", method="curl")
unzip("UCI.zip")


setwd("./UCI HAR Dataset/")


##Read data into R
features <- read.table("./features.txt", col.names = c("n","functions"))
X_test<-read.table("./test/X_test.txt", col.names=c(features$functions))
X_train<-read.table("./train/X_train.txt", col.names=c(features$functions))
y_test<-read.table("./test/y_test.txt", col.names="activity")
y_train<-read.table("./train/y_train.txt", col.names="activity")
subject_test<-read.table("./test/subject_test.txt", col.names="subject_id")
subject_train<-read.table("./train/subject_train.txt", col.names="subject_id")
activity_labels<-read.table("./activity_labels.txt")

##Add activity ID to test and train data files
X_test_activity<-cbind(y_test, X_test)
X_train_activity<-cbind(y_train,X_train)

##Add subject ID to test and train data files
X_test_activity_subject<-cbind(subject_test, X_test_activity)
X_train_activity_subject<-cbind(subject_train, X_train_activity)

##Add label to each dataset before merging
X_test_activity_subject<-cbind(X_test_activity_subject, dataset="test")
X_train_activity_subject<-cbind(X_train_activity_subject, dataset="train")

##Merge test and train datasets
complete_data<-rbind(X_test_activity_subject, X_train_activity_subject)

##Add activity character label to merged dataset
library(dplyr)
complete_data<-merge(complete_data, activity_labels, by.x="activity", by.y="V1", all=TRUE)
complete_data<-rename(complete_data, activity_label=V2, activity_id=activity)

##Reorganize columns so that descriptive variables are the first columns
complete_data<-select(complete_data, 564, 2, 1, 565, 3:563)


##Label variables for full dataset with descriptive names
names(complete_data)<-gsub(x = names(complete_data), pattern = "^tBody", replacement = "TimeBody-")
names(complete_data)<-gsub(x = names(complete_data), pattern = "^tGravity", replacement = "TimeGravity-")
names(complete_data)<-gsub(x = names(complete_data), pattern = "^fBody", replacement = "FrequencyBody-")


##The complete data set of training and test data with descriptive activity and variable labels is called 'complete_data'.
write.csv(complete_data, file="./complete_data.csv")

##Subset for only values that contain "mean()" and "std()". 
means_ind<-grep(".mean.", x=names(complete_data))
std_ind<-grep(".std.", x=names(complete_data))
subset_cd<-select(complete_data, 1:4, all_of(means_ind), all_of(std_ind))

##The dataset including only means and standard deviation measurements is called 'subset_cd'.
write.csv(subset_cd, file="./subset_cd.csv")

#Mean by subject ID and mean by activity label
mean_subject<-aggregate(complete_data[, 5:565], list(complete_data$subject_id), mean)
mean_subject<-rename(mean_subject, subject_id=Group.1)

mean_activity<-aggregate(complete_data[, 5:565], list(complete_data$activity_label), mean)
mean_activity<-rename(mean_activity, activity_label=Group.1)

##Combine means by activity and means by subject_id into one table
tidy_means<-bind_rows(mean_subject, mean_activity)
tidy_means<-relocate(tidy_means, activity_label, .after=subject_id)

##The data frame with the means by activity and subject_id is called 'tidy_means'.
write.csv(tidy_means, file="./tidy_means.csv")

##Time 10:49am 25 June