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
    col.names=c(features$feature),
    nrows = length(activities$activity_id)
  )
  
  allData <- data.frame(c(subjects, activities, measurements))
  allData
  
}