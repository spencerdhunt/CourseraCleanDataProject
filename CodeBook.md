# CODE BOOK
## `process_data.R`
This R script produces (and writes to text files) two tidy data sets 
* [`full_data_tidy`](#full_tidy_data)
* [`mean_data_tidy`](#mean_data_tidy)  

These data sets are highlighted in more detail below.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## `full_tidy_data` 

`full_tidy_data` is a `data.frame` in `R` with 10299 observations of 68 variables.  These variables are listed below

* `subject_ID`: (integer) Indicates the number of the participant in the study.
* `activity_names`: (factor) Indicates the type of activity that the participant was engaging in during data capture.

All other 66 features are numerical identified with the following naming struture: `xREADING_fxn_dir` where
* `x` refers is either `t` or `f` referring to the domain captured (time or frequency, respectively)
* `READING` refers to the type of inertial signal and can be one of:
  - `BodyAcc`: body acceleration
  - `GravityAcc`: gravity acceleration signal
  - `BodyAccJerk`: body acceleration jerk signal
  - `BodyGyro`: body gyro signal
  -  `BodyGyroJerk`: body gyro signal
  -  `BodyAccMag`: body acceleration magnitude
* `fxn` refers to the aggregate function applied to the data in `xREADING`.  In this we report only mean (`mean`) and standard deviation (`std`) values.  
* `dir` refers to the direction that the signal data was captured (`X`, `Y`, and `Z` directions).

## `mean_tidy_data` 

`mean_tidy_data` is a `data.frame` in `R` with 40 observations of 68 variables.  This is the aggregate reading of the 66 features listed above aggregated (by mean) over all participant-activity combinations.  I'm not sure why I only got 40 observations, it seems like all participants didn't do all activities, not sure why...

* `activity_names`: (factor) Indicates the activity the participant was engaging in during data capture
* `subject_ID`: (integer) Indicates the integer ID value of each of the participants.
* all the other 66 values refer to the mean values of each of the 66 numerical features listed above

