activityLabels <- read.delim("./UCI HAR Dataset/activity_labels.txt",
                             col.names = c("classLabels", "activityName"))
features <- read.delim("./UCI HAR Dataset/features.txt", col.names = c("index",
                                                                       "featureName"))

featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, "featureNames"]
measurements <- gsub('[()]', '', measurements)

train <- fread(file.path(path, "./UCI HAR Dataset/train/X_train.txt"))[, featuresWanted, with = FALSE]

data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(path, "./UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
trainSubjects <- fread(file.path(path, "./UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)

test <- fread(file.path(path, "./UCI HAR Dataset/test/X_test.txt"))[, featuresWanted, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(path, "./UCI HAR Dataset/test/Y_test.txt")
                        , col.names = c("Activity"))
testSubjects <- fread(file.path(path, "./UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

combined <- rbind(train, test)

combined[["Activity"]] <- factor(combined[, Activity],
                                 levels = activityLabels[["classLabels"]]
                                 , labels = activityLabels[["activityName"]])

combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])
combined <- reshape2::melt(data = combined , id = c("SubjectNum", 'Activity'))
combined <- reshape2::dcast(data= combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = combined, file = "tidyData.csv", quote = FALSE)
