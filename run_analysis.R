#### Instructions ####
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
# on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data 
# set as described below, 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or work that you performed 
# to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this
# article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to
# attract new users. The data linked to from the course website represent data collected from the accelerometers 
# from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
#   
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
## This R script was created to perform the following tasks:

# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.


# Development of the tasks:
# 1. Merge the training and the test sets to create one data set.
getwd()
data_dir<-"C:/Users/lugor/OneDrive/Documentos/GitHub/GnCD JHU coursera/Getting-and-Cleaning-Data-JHU/UCI HAR Dataset"

library(readr)
library(dplyr)
library(tidyr)
#----import labs---- 
features <- read_table2(paste0(data_dir,"/features.txt"),col_names = FALSE)
activity_labels <- read_table2(paste0(data_dir,"/activity_labels.txt"),col_names = FALSE)
colnames(activity_labels)<-c("id_act","act_lab")
#----import training data---- 
subject_train<- read_table2(paste0(data_dir,"/train/subject_train.txt"),col_names = FALSE)
X_train <- read_table2(paste0(data_dir,"/train/X_train.txt"),col_names = FALSE)
y_train <- read_table2(paste0(data_dir,"/train/y_train.txt"),col_names = FALSE)
colnames(subject_train)<-"ID"
#----import test data---- 
subject_test <- read_table2(paste0(data_dir,"/test/subject_test.txt"),col_names = FALSE)
X_test <- read_table2(paste0(data_dir,"/test/X_test.txt"),col_names = FALSE)
y_test <- read_table2(paste0(data_dir,"/test/y_test.txt"),col_names = FALSE)
colnames(subject_test)<-"ID"

# str(y_train)
# str(X_train)
# summary(y_test)

## ---- assign names to variables ----
colnames(X_train)<-unlist(features[,2])
colnames(X_test)<-unlist(features[,2])

colnames(y_train)<-"id_act"
colnames(y_test)<-"id_act"

y_train<-merge(y_train,activity_labels)
y_test<-merge(y_test,activity_labels)

##---- merge train and test dataset ----
train<-cbind(subject_train,y_train, X_train)
train[,length(train)+1]<-"train"
test<-cbind(subject_test,y_test, X_test)
test[,length(test)+1]<-"test"


total<-rbind(train,test)
total<-total[,-3]
total<-total%>%rename(DB=V566)

##----  2. Extract only the measurements on the mean and standard deviation for each measurement.-----
glimpse(total)

feat<-unlist(features[,2])
length(feat)
# filter mean and std for each measurement
total_m_sd<-total%>%select("ID","id_act","act_lab","DB",contains(c("mean","std")))%>%select(-contains(c("angle","Freq")))
length(total_m_sd)

# gather summary statistic
glimpse(total_m_sd_1)
total_m_sd_1<-total_m_sd%>%gather(key="Variable",value = "SumStat",-c("ID","id_act","act_lab","DB"))
str(total_m_sd_1)

#total_m_sd_xyz<-total_m_sd_1%>%filter(grepl('-X|-Y|-Z', Variable))
#total_m_sd_xyz_1<-total_m_sd_xyz%>%separate(col="Variable",into=c("Var","SumStatistic","Angle"))
#table(total_m_sd_xyz_1$Angle)

total_m_sd_2<-total_m_sd_1%>%separate(col="Variable",into=c("Var","SumStatistic","Angle"))

# 3. Use descriptive activity names to name the activities in the data set.
# I did this and the following task before merging datasets for clarity 
# 4. Appropriately labels the data set with descriptive variable names.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.
tidy_data<-total_m_sd_2%>%group_by(ID,act_lab,Var,SumStatistic,Angle)%>%summarise(mean_each=mean(SumStat))
tidy_data

write.table(tidy_data,file ="tidy_data.csv" ,row.name=FALSE)

