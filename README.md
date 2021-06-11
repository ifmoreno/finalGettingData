# finalGettingData

The code works with the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and uses the tidyverse package. The following steps describe the workflow of the code
1. Download the zip file and unzip the data
2. Create 3 tables with (i) features, (ii) activity names, and a (iii)list with the index of interest variables
3. get the train and test data
4. merge both datasets, give names to each activity, and create the independent tidy data set with the average of each variable for each activity and each subject.
