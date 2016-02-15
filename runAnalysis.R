###########################################################################################
# runAnalysis.R
# 
# This script contains methods that process the UCI HAR dataset to accomplish the following
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
#
# Assumes the following for these scripts
# 1. The source directory: "UCI Har Dataset" and its subdirs exists in the
#    project folder
# 2. The output directory will be: "Combined Dataset" in the project folder
# 3. The combined feature mean and standard deviations will be output to the
#    file: "Combined Dataset/combined_mean_std.txt"
#
# @author: Phil Mui
# @date: "2016-02-14 09:29:05 PST"
#
###########################################################################################

#
# project set: setting current working directories & project variables
#

projectdir="/Users/philmui/tidy_dataset"
destdir=paste0(projectdir, "/Combined Dataset")
outputfilename="combined_mean_std.txt"

srcdir=paste0(projectdir, "/UCI HAR Dataset")
inertdir="/Inertial Signals"

setwd(projectdir)

if (!file.exists(srcdir)) { 
  error(paste0("Source directory does not exist: ", srcdir))
}

##-----------------------------------------------------------------------------------------
# utility functions
##-----------------------------------------------------------------------------------------

# read from both "train" and "test" folders & combine them in write
combineTrainTest <- function(fname, subdir="") {
  
  dir <- paste0(srcdir, "/train", subdir)
  train <- read.table(paste0(dir, "/", fname, "_train.txt"))

  dir <- paste0(srcdir, "/test", subdir)
  test  <- read.table(paste0(dir, "/", fname, "_test.txt"))
  total <- rbind(train, test)
  
  total
}

##-----------------------------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
#
#    The output directory for the combined datasets will be: 
#             "Combined Dataset" 
#    in the project folder
##-----------------------------------------------------------------------------------------

#
# Read the combined test & training sets & write to the combined total:
#
combinedX       <- combineTrainTest("X")
combinedY       <- combineTrainTest("y")
combinedSubject <- combineTrainTest("subject")

##-----------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for 
#    each measurement.
#
# 3. Uses descriptive activity names to name the activities in the data set
#
# 4. Appropriately labels the data set with descriptive variable names.
##-----------------------------------------------------------------------------------------
featuresfile=paste0(srcdir, "/features.txt")
features <- read.table(featuresfile, stringsAsFactors=FALSE)
  
# Uses descriptive activity names to name the activities in the data set
colnames(combinedX) <- features[,2]

activities=c("Walking", 
             "Walking Upstairs",
             "Walking Downstairs",
             "Sitting",
             "Standing",
             "Laying");
mappingXY = data.frame(num=c(1:6), 
                       activity=activities,
                       stringsAsFactors = FALSE)

createCombinedXYSwithLabels <- function() {
  
  result <- combinedY
  for (i in 1:nrow(combinedY)) {
    activitynum <- as.integer(combinedY[i,1])
    result[i,1] <- as.character(mappingXY[activitynum, 2])
  }
  result <- cbind(result, combinedSubject)
  result_colnames <- c("activity", "subject")
  
  # only pick those columns which are 'mean' or 'std'
  cnames <- colnames(combinedX)
  for (i in 1:length(cnames)) {
    if (grepl("mean\\(\\)|std\\(\\)", cnames[i])) {
      result <- cbind(result, combinedX[,i])
      result_colnames <- append(result_colnames, cnames[i])
    }
  }
  colnames(result)  <- result_colnames
  result
}

##-----------------------------------------------------------------------------------------
# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.
##-----------------------------------------------------------------------------------------

library(dplyr)

createAverageSet <- function(combinedXYS) {
  fulldata <- tbl_df(combinedXYS)
  result <- list()
  for (s in 1:30) {
    for (a in activities) {
      selectedrows <- filter(fulldata, 
                             subject==s, 
                             activity==a)
      mat <- select(selectedrows, 3:ncol(selectedrows))
      cmean <- as.numeric(colMeans(mat))
      thisrow <- c(a, s)
      thisrow <- append(thisrow, cmean)
      result <- rbind(result, thisrow, deparse.level = 0)
    }
  }
  #result <- as.data.frame(result)
  colnames(result) <- colnames(fulldata)
  result
}

combinedXYS <- createCombinedXYSwithLabels()
curateddata <- createAverageSet(combinedXYS)
if (!file.exists(destdir)) { dir.create(destdir)}
write.table(curateddata, file=paste0(destdir, "/", outputfilename), row.names = FALSE)


