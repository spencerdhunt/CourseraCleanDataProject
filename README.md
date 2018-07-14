# CourseraCleanDataProject
Clean Data project for the Data Science Coursera Project. This project highlights a script to tidy test and training data.  The script process_data.R is outlined below

## The process_data.R Script
This script utilizes features from the _tidyverse_ package. It contains a series of functions listed below

### pull_features() function
This function pulls the feature descriptions provided in the features.txt file in the original data set.  It then identifies the features of interest which are those that calculate the mean and standard deviation (std) from the readings data provided in the test/Inertial Signals/ directory.  

### clean_features(features_names) function
This function simply cleans the feature names.  It removes all "()" from the feature names and also changes the hypehn "=" to and undersore "_".

### combine_data(source) function
This function takes a data source type (one of either "test" or "train") and returns a tidy data set for each.  
* It then pulls the subjects that belong to each data source.  
* It also the list of activity names and maps it to the activity IDs listed in the ./test/y_test.txt or ./train/y_train.txt data sets.  It will then clean the names to they are all lower case and with underscores substituted with spaces
* Then it pulls the full set of features data for either test or train (./source/X_source.txt). Using the _pull_features()_ function it then subsets the data to only include the features of interest.  The feature names are then cleaned using the _clean_features(feature_names)_ function. 
* Lastly it binds the data along the columns into one tidy data set for either train or test data.

### Final Steps of _process_data.R_ Script
* The script generates a data set for both train and test data
* Then it binds them along the rows into one full tidy data set
* It uses the _group_by(subject_ID, activity_name)_ function and the _summarize_all()_ function to determine the summarize the data by the mean of all the features for each subject-activity combination.  This generates tidy mean data.
* lastly it writes these data sets to text files (both the full tidy data set and the tidy mean data). 
