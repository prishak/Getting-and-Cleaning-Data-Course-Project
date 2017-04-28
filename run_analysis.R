                  ##"DOWNLOADING AND UNZIPPING FILE"##
 #Downloading zip file
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL,destfile = "c:/Users/TAkshak/Desktop/R working/data cleaning/project4/Dataset.zip")
 #unzip file in project4 directory
unzip(zipfile="c:/Users/TAkshak/Desktop/R working/data cleaning/project4/Dataset.zip",exdir="c:/Users/TAkshak/Desktop/R working/data cleaning/project4")
                 ##"READING FILE"##
#Reading test folder
x_test <- read.table("c:/Users/Takshak/Desktop/R working/data cleaning/project4/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("c:/Users/Takshak/Desktop/R working/data cleaning/project4/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("c:/Users/Takshak/Desktop/R working/data cleaning/project4/UCI HAR Dataset/test/subject_test.txt")
#Reading train folder
x_train <- read.table("c:/Users/Takshak/Desktop/R working/data cleaning/project4/UCI HAR Dataset/train/X_train.txt")
y_train<- read.table("c:/Users/Takshak/Desktop/R working/data cleaning/project4/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("c:/Users/Takshak/Desktop/R working/data cleaning/project4/UCI HAR Dataset/train/subject_train.txt")
#Reading features document
freatures <- read.table("c:/Users/Takshak/Desktop/R working/data cleaning/project4/UCI HAR Dataset/features.txt")
#Reading activity_labels
activity_labels <- read.table("c:/Users/Takshak/Desktop/R working/data cleaning/project4/UCI HAR Dataset/activity_labels.txt")
             ##"Assigning column names"##
#Colum name of test 
colnames(x_test) <- freatures[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
#colum name of train
colnames(x_train) <-freatures[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"
#colum name to activity_labels
colnames(activity_labels) <- c('activityId','activityType')
                 #1#"Merging and creating one data set"
mrg_test <- cbind(y_test, subject_test, x_test)
mrg_train <- cbind(y_train, subject_train, x_train)
setAllInOne <- rbind(mrg_train, mrg_test)
                #3#Extracts only the measurements on the mean and standard deviation for each measurement
#reading column names
colNames <- colnames(setAllInOne)
#Extracting mean and standard deviation
mean_std <-(grepl("activityId",colNames)|
              grepl("subjectId",colNames)|
              grepl("mean..",colNames)|
              grepl("std..",colNames)
            )
setForMeanAndStd <- setAllInOne[,mean_std==TRUE]
             #4#Uses descriptive activity names to name the activities in the data set
setWithActivityNames <- merge(setForMeanAndStd, activity_labels,by='activityId',all.x=TRUE)
             #5#creating a second, independent tidy data set with the average of each variable for each activity and each subject
tidydt <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- tidydt[order(tidydt$subjectId, tidydt$activityId),]
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)

