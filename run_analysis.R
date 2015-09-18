build_data <- function(dataType){
  
  require(dplyr)
  
  features <- read.table("data/features.txt", col.names=c("id", "feature"))
  
  activities <- read.table(
    paste("data/", dataType, "/y_", dataType, ".txt", sep=""),
    col.names=c("activity_id")
  )
  
  subjects <- read.table(
    paste("data/", dataType, "/subject_", dataType, ".txt", sep=""),
    col.names=c("subject_id"),
    nrows = length(activities$activity_id)
  )
  
  measurements <- read.table(
    paste("data/", dataType, "/X_", dataType, ".txt", sep=""), 
    col.names=features$feature,
    nrows = length(activities$activity_id)
  )
  
  allData <- data.frame(c(subjects, activities, measurements))
  allData
  
}

combine_data <- function(){
  require(dplyr)
  combine <- bind_rows(build_data("test"), build_data("train"))
  combine
}

name_activities <- function(data){
  require(dplyr)
  activityNames <- read.table("data/activity_labels.txt", 
                              col.names = c("activity_id", "activity"))
  
  dataWithNames <- inner_join(data, activityNames, by="activity_id")
  dataWithNames
  
}