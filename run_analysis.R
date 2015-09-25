# functions to build data are defined first.
# main execution of script is at the bottom

build_data <- function(dataType){
    
    # creates a data frame of either test or train data
    
    require(dplyr)
    
    features <- read.table("UCI HAR Dataset/features.txt", col.names=c("id", "feature"))
    
    activities <- read.table(
        paste("UCI HAR Dataset/", dataType, "/y_", dataType, ".txt", sep=""),
        col.names=c("activity_id")
    )
    
    subjects <- read.table(
        paste("UCI HAR Dataset/", dataType, "/subject_", dataType, ".txt", sep=""),
        col.names=c("subject_id"),
        nrows = length(activities$activity_id)
    )
    
    measurements <- read.table(
        paste("UCI HAR Dataset/", dataType, "/X_", dataType, ".txt", sep=""), 
        col.names=features$feature,
        nrows = length(activities$activity_id)
    )
    
    builtData <- data.frame(c(subjects, activities, measurements))
    builtData
    
}

combine_data <- function(){
    # combines the test and train data
    require(dplyr)
    combine <- bind_rows(build_data("test"), build_data("train"))
    combine
}

name_activities <- function(data){
    # applies the activity labels to the data frame
    require(dplyr)
    activityNames <- read.table("UCI HAR Dataset/activity_labels.txt", 
                                col.names = c("activity_id", "activity"))
    
    dataWithNames <- inner_join(data, activityNames, by="activity_id")
    dataWithNames
    
}


# main execution - runs when script is sourced
library(dplyr)

# download the dataset if necessary
if(!file.exists("dataset.zip")){
    download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                  destfile="dataset.zip")
}
if(!file.exists("UCI HAR Dataset")){
    unzip("dataset.zip")
}

# call previously defined functions to build and combine the data, 
# then get the average of the required columns and output a file
allData <- name_activities(combine_data()) %>%
    select(  
        subject_id, 
        activity, 
        contains(".std"),
        contains(".mean"), 
        -contains(".meanFreq")
    ) %>%
    group_by(activity, subject_id) %>%
    summarise_each(funs(mean))
write.table(allData, file = "tidy_output.txt", row.names=FALSE, sep=",")
print("finished")
