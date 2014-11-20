# Getting_CourseProject
# =====================
#  
Course Project. Getting an Cleaning Data, Oleg Shvaikovsky, 17.11.2014
Details: https://class.coursera.org/getdata-009/human_grading/view/courses/972587/assessments/3/submissions
 
Task is to create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Steps to work on this course project

NOTE: here we assume, that we downloaded and unzipped data manually to working directory 
Download the data source and put into a folder on your local drive. 
You'll have a UCI HAR Dataset folder.
Put run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
Run source("run_analysis.R"), then it will generate a new file "OlegTidyDataResult.txt in your working directory.
If there exists old "OlegTidyDataResult.txt" file, then the old file will be renamed to the name, containing timestamp

