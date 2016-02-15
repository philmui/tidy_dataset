tidy_dataset : CodeBook
=======================

Introduction
-------------
This "tidy_dataset" project aims to extract the mean and standard deviation of each of  measurement per subject per activity.

Measurements
-------------
Each of the measurements containing "XYZ" has really 3 axial measurements: X, Y, and Z.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

There are 8 axial measures, this translate to : 8 * 3 = 24 measurements. In addition to the other 9 measures, we have a total of 24 + 9 = 33 measures.

For each of these 33 measures, we have 17 variables that were estimated from these signals:

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Multiplying the 33 measures each of which has 17 variables: we have 33 x 17 = 561 measurements total -- which is the total number of columns in the training & testing datasets.

Activities & Subjects
----------------------
The measurements are taken from 6 distinct activites for 30 different subjects:

- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

Generating the Summary
-----------------------
After combining the "train" and "test" datasets, this script "runAnalysis.R" aggregates measurements for the same *subject* (which ranges from 1-30) and the same *activity* (there are 6 distinct activities) for a total of 180 aggregate values (180 rows) in the final summary table (dimension: 180 rows x 561 cols)

The script [runAnalysis.R] (https://github.com/philmui/tidy_dataset/blob/master/runAnalysis.R) calculates average values of measurements for each subject for each activity.

Output
-------
The combined summary dataset is located at project sub-folder: "Combined Dataset". The file containing the tidy result dataset is called "combined_mean_std.txt".

