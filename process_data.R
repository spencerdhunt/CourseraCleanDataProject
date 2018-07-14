##########################
# Code to tidy some data that was very poorly explained
##########################

# use the package tidyverse because they seem to be able to do everything better
library(tidyverse)

# 1. Function to pull the appropriate features (those with mean and std in them)
# (Did anyone get this when it said extract? I thought they wanted us to find the mean
# and standard dev for these features.  Boy was I totally wrong. Perhaps if the features
# were better explained I could have avoided undue turmoil, or maybe I'm just a total dunce)


# you downloaded it already right?  If not, get on it! If so, just use your pathway :)
setwd("~/Documents/DataScienceCourse/Course3/data/UCI HAR Dataset/")

#function to pull the feature names

pull_features <- function(){
    
    features <- read_table2("./features.txt",col_names = c("column","feat_name"))
    
    all_feat <- features$feat_name
    #pull the features that have mean in them (remember I'm not taking the mean, they've already done it DUHHHHH)
    those_with_mean <- all_feat[grep("mean\\(\\)",all_feat)]
    #pull the features that have std in them (remember I'm not taking the std, they've already done it DUHHHHH)
    those_with_sd <- all_feat[grep("std\\(\\)",all_feat)]
    
    #put those badboys side by side
    c(rbind(those_with_mean,those_with_sd))
}

#function to clean the feature names

clean_features <- function(feature_names){
    #remeber that these feature names are ugly! Like put that paper bag over them ugly
    #we're going to try to fix that (too bad there isn't a "botox" package in R)
    
    # First we don't need parentheses anymore because they are hefty and we're trying to slim
    # these puppies down
    feature_names <- gsub("\\(\\)","",feature_names)
    
    # we also want to swap out these nasty hyphens 
    # (those things look just like minus signs and I ain't about that life)
    # Underscores are good, they carry their weight in the bottom section instead of the 
    # midsection, and we want to be a triangle
    
    feature_names <- gsub("-","_",feature_names)
    
    feature_names
}

#function that puts the data together

combine_data <- function(source){
    
    #This function puts the data together to it's super clean and only includes
    # the measurements that are means or standard deviations
    # the data should look  as follows
    # subject_id    activity    meas1_mean  meas2_std   ...
    #           1   SITTING     0.001       0.0001
    #           1   STANDING    0.01        0.0010
    
    #don't even let these people do something that isn't test or train
    if (source != "test" & source != "train"){
        stop("You must only use a source that is 'train' or 'test'!")
    }
    
    #we are going to load the participant data
    
    subject <- read_table(paste0("./",source,"/subject_",source,".txt"),
                          col_names = c("subject_ID"))
    
    # load in the activity IDs and names
    
    activity_names <- read_table(paste0("./","activity_labels.txt"),
                           col_names = c("activity_id","activity_name"))
    # load the activities for the readings
    
    activity_num <- read_table(paste0("./",source,"/y_",source,".txt"),
                           col_names = c("activity_id"))
    activity_names <- merge(activity_num,activity_names, by = "activity_id")
    cleanlabels <- tolower(activity_names$activity_name)
    #cleanlabels <- gsub("_"," ",cleanlabels)
    activity <- data.frame(activity_names = cleanlabels)
    activity[] <- as.factor(cleanlabels)
    
    #pull the feature names (complete list)
    all_feature_names  <- read_table2("./features.txt",col_names = c("column","feat_name"))
    
    #load all the features data
    features <- read_table(paste0("./",source,"/X_",source,".txt"),
                           col_names = all_feature_names$feat_name)
    
    #load only the intersting features (mean and std)
    feat_interest <- pull_features()
    features <- features[,feat_interest]
    
    #clean up the column names
    colnames(features) <- clean_features(feat_interest)
    
    # get like Dr. Frankenstein and stitch these babies together
    cbind(subject,activity,features)
    
}

#now actually pull the test and train data and merge these sets
test_data <- suppressWarnings(combine_data("test"))
train_data <- suppressWarnings(combine_data("train"))

full_data_tidy <- rbind(test_data,train_data)

##############################
# Time to determine the average of these averages...cool
##############################

mean_data_tidy <- full_data_tidy %>% group_by(activity_names,subject_ID) %>% summarize_all(funs(mean = mean),na.rm = T)

write.table(mean_data_tidy,"./TidyProcess/mean_tidy_data.txt")
write.table(full_data_tidy,"./TidyProcess/full_data_tidy.txt")
