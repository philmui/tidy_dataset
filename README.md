Project for Getting & Cleaning Data
===================================
author: "Phil Mui"
date: "February 14, 2016"

This project prepares a tidy dataset based on cleaning up the original datasets collected by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto at the SmartLab at the Università degli Studi di Genova.  

The resultant dataset is a summary dataset for these 6 activites by 30 subjects wearing Galaxy S II smartphone on their wrists:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

The original dataset is located at the project sub-folder: "UCI HAR Dataset".  Inside this dataset is 2 sets of data: train and test data in proportion of roughly 70% vs 30%.

Output
-------
The combined summary dataset is located at project sub-folder: "Combined Dataset".  The file containing the tidy result dataset is called "combined_mean_std.txt".

Script
-------
The main script "runAnalysis.R" processes the UCI HAR dataset to accomplish the following

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the 
   average of each variable for each activity and each subject.

Assumptions
------------
We assume the following in the script:
 1. The source directory: "UCI Har Dataset" and its subdirs exists in the
    project folder
 2. The output directory will be: "Combined Dataset" in the project folder
 3. The combined feature mean and standard deviations will be output to the
    file: "Combined Dataset/combined_mean_std.txt"


References
-----------

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Original datasets collected from the following:

----------------------------------------------------------------------
Human Activity Recognition Using Smartphones Dataset
Version 1.0
----------------------------------------------------------------------
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
----------------------------------------------------------------------