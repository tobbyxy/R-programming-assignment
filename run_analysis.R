activityLabels <- read.delim("./UCI HAR Dataset/activity_labels.txt",
                             col.names = c("classLabels", "activityName"))
features <- read.delim("./UCI HAR Dataset/features.txt", col.names = c("index",
                                                                       "featureName"))