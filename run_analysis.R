#  
#  Course Project. Getting an Cleaning Data, Oleg Shvaikovsky, 17.11.2014
#  Details: https://class.coursera.org/getdata-009/human_grading/view/courses/972587/assessments/3/submissions
# 
#  Task is to create one R script called run_analysis.R that does the following:
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement.
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive activity names.
#  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# 
#  NOTE: here we assume, that we downloaded and unzipped data manually to working directory 
#

setwd("/Users/olegshvaikovskypro/R-Coursera/GettingCleaningData/CourseProject")

#
#    Data is in "/Users/olegshvaikovskypro/R-Coursera/GettingCleaningData/CourseProject/UCI HAR Dataset"
#
#    file.exists("UCI HAR Dataset/train")

features <- read.table("UCI HAR Dataset/features.txt", col.names=c("feature_id", "feature_label"),)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity_id", "activity_label"),)
activity_lables[,2]<-as.character(activity_lables[,2])

#    --------------------------------------
#    reading TRAIN data

TrainDataMain = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
TrainDataY_train = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
TrainDataSubjectTrain = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

#    summary(TrainDataMain)

# TrainData <- cbind(TrainDataMain, TrainDataSmall1, TrainDataSmall2)

#    summary(TrainData)

#    --------------------------------------
#    reading TEST data

TestDataMain = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
TestDataY_test = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
TestDataSubjectTest = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

#    ---------------------------------------
# 1. Merges the training and the test sets to create one data set.

MergedData <- rbind (TrainDataMain, TestDataMain)

#    summary(MergedData)

#    ---------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

colnames(MergedData) <- c(as.character(features[,2]))
MergedData_Mean <- grep("mean()",colnames(MergedData),fixed=TRUE)
MergedData_SD <- grep("std()",colnames(MergedData),fixed=TRUE)
Result_MeanSD <- MergedData[,c(MergedData_Mean, MergedData_SD)]

#    ---------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set

Y_Data_Merged <- rbind(TrainDataY_train,TestDataY_test)
MeanSD_Labeled <- cbind(Y_Data_Merged, Result_MeanSD)
colnames(MeanSD_Labeled)[1] <- "Activity"

#    ---------------------------------------
# 4. Appropriately labels the data set with descriptive activity names.

for (i in 1:length(MeanSD_Labeled[,1])) {
     MeanSD_Labeled[i,1]<-activity_lables[MeanSD_Labeled[i,1],2]
}

#    ---------------------------------------
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

MergedResult <- cbind( rbind (TrainDataSubjectTrain, TestDataSubjectTest), MeanSD_Labeled)
colnames(MergedResult)[1] <- "Subject"

# Result_TidyFrame <- aggregate( MergedResult[,3] ~ Subject+Activity, data = MergedResult, FUN= "mean" )

for (i in 4:ncol(MergedResult)) {
     Result_TidyFrame[,i] <- aggregate( MergedResult[,i] ~ Subject+Activity, data = MergedResult, FUN= "mean" )[,3]
}

colnames(Result_TidyFrame)[3:ncol(Result_TidyFrame)] <- colnames(Result_MeanSD)

if (file.exists("OlegTidyDataResult.txt")) {
     file.rename("OlegTidyDataResult.txt", paste("OlegTidyDataResult", as.character(Sys.time()), ".txt"))
     
}

write.table(Result_TidyFrame, file = "OlegTidyDataResult.txt", row.name=FALSE)

#    YESSSS!!!!!


