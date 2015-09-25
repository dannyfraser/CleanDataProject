#Coursera Data Science Specialization
#Getting &amp; Cleaning Data Course Project

##Purpose
This project is an example of using R to manipulate an unwieldy dataset and extract meaningful, tidy data.

The source data is a sample of data from wearable technology (details available [here][1]).

Further details of the data in the output file are available in the [Codebook][2]


##What does this script do?
The "run_analysis.R" script downloads and unzips the dataset to a folder called "UCI HAR Dataset" in the working directory. It then combines the test and training files and extracts all of the mean and standard deviation columns from the dataset. The output file is the average of each column grouped by test subject and activity. It is found in the "tidy_output.txt" file in the working directory.


[1]:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
[2]:https://github.com/dannyfraser/CleanDataProject/blob/master/CodeBook.md