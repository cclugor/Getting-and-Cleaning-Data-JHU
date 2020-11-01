Getting and Cleaning Data JHU - coursera
Peer-graded Assignment

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


Development of the tasks:
1. First, I downloaded the .zip data, and unzipped it, located it in my local folder: G:/Mi unidad/Certificados hoja de vida/Coursera/8. Getting and Cleaning Data JHU/Peer-Graded assignment/UCI HAR Dataset"
2. Then, I imported each data set: subject, X and y for each type of data, train as well as test data. Also, imported the features.txt and activity_labels.txt in order to properly join datasets.
3. I renamed the X datasets columns, using the features.txt variables.
4. I merged subject_train,y_train, X_train into a single train dataset, and subject_test,y_test, X_test into a single test dataset.
5. Before merging I created a variable called DB that identified if the observation came from test or train datasets.
6. Then, I filtered mean and std for each measurement, using select and contains dplyr functions and excluded other variables that were included in the dataset but did not match the variables found in the features.txt list os variables. 
7. I used dply's gather function in order to create a long dataset where features where a variable, that I called Var.
8. Since each variable in Var contained information about other variables (statistic and angle) I used separate function to make sure every variable had its own column.
9. Finally, I used group_by and summarise dplyr verbs to find the mean of each variable, activity and subject studied. The final tidy dataset is called: tidy_data.

