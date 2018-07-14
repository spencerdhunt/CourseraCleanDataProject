# CourseraCleanDataProject
Clean Data project for the Data Science Coursera Project. This project highlights a script to tidy test and training data.  The script process_data.R is outlined below

## The process_data.R Script
This script utilizes features from the 'tidyverse' package. It contains a series of functions listed below

### pull_features() function
This function pulls the feature descriptions provided in the features.txt file in the original data set.  It then identifies the features of interest which are those that calculate the mean and standard deviation (std) from the readings data provided in the test/Inertial Signals/ directory.  

### clean_features(features_names) function
This function simply cleans the feature names.  It removes all "()" from the feature names and also changes the hypehn "=" to and undersore "_".

### combine_data(source) function
This function takes a data source type (one of either "test" or "train") and returns a tidy data set for each.  
* It then pulls the subjects that belong to each data source.  
* It also the list of activity names and maps it to the activity IDs listed in the ./test/y_test.txt or ./train/y_train.txt data sets.  It will then clean the names to they are all lower case and with underscores substituted with spaces
* Then it pulls the full set of features data for either test or train (./source/X_source.txt) 
