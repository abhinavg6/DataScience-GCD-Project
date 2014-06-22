run_analysis <- function() {
    # Load the library reshape2 to use melt() and dcast()
    library(reshape2)
    
    message("Started - running analysis for accelerometer data")
    # Read the reference data files
    # Read the activities file
    activities <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
    # Set appropriate names for columns in activities data frame
    setnames(activities, old=c("V1","V2"), new=c("actindex","activity"))
    # Read the features file
    features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)
    # Set appropriate names for columns in features data frame
    setnames(features, old=c("V1","V2"), new=c("featindex","feature"))
    message("Got and transformed ref data")
    
    # Read the training data files
    # Read the training subject file
    trngsubdata <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
    # Set appropriate names for columns in training subject data frame
    setnames(trngsubdata, old="V1", new="subject")
    # Read the training activity labels file
    trngactdata <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
    # Set appropriate names for columns in training activity labels data frame
    setnames(trngactdata, old="V1", new="actindex")
    # Read the training set data file
    trngsetdata <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
    # Set appropriate names for columns in training set data frame
    # Related to ask 4 in course project
    colnames(trngsetdata) <- features$feature
    # Add training activity label to training set data
    trngsetdata <- cbind(actindex=trngactdata$actindex, trngsetdata)
    # Add training subject information to training set data
    trngsetdata <- cbind(subject=trngsubdata$subject, trngsetdata)
    # Add activity name to training set data by merging with activities data frame
    # Related to ask 3 in course project
    trngactsetdata <- merge(activities, trngsetdata, by="actindex")
    # Remove the actindex column from merged training set data
    trngactsetdata <- trngactsetdata[,!(names(trngactsetdata) %in% c("actindex"))]
    message("Got and transformed training data")
    
    # Read the test data files
    # Read the test subject file
    testsubdata <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
    # Set appropriate names for columns in test subject data frame
    setnames(testsubdata, old="V1", new="subject")
    # Read the test activity labels file
    testactdata <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
    # Set appropriate names for columns in test activity labels data frame
    setnames(testactdata, old="V1", new="actindex")
    # Read the test set data file
    testsetdata <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
    # Set appropriate names for columns in test set data frame
    # Related to ask 4 in course project
    colnames(testsetdata) <- features$feature
    # Add test activity label to test set data
    testsetdata <- cbind(actindex=testactdata$actindex, testsetdata)
    # Add test subject information to test set data
    testsetdata <- cbind(subject=testsubdata$subject, testsetdata)
    # Add activity name to test set data by merging with activities data frame
    # Related to ask 3 in course project
    testactsetdata <- merge(activities, testsetdata, by="actindex")
    # Remove the actindex column from merged training set data
    testactsetdata <- testactsetdata[,!(names(testactsetdata) %in% c("actindex"))]
    message("Got and transformed test data")
    
    # Join/Merge the training and test data sets
    # Related to ask 1 in course project
    actsetdata <- rbind(trngactsetdata, testactsetdata)
    message("Merged training and test data")
    
    # Create a vector including names of all mean and standard deviation features
    idcols <- c("subject","activity")
    measurecols <- grep("mean()", features$feature, value=TRUE, fixed=TRUE)
    measurecols <- c(measurecols, grep("std()", features$feature,
                                       value=TRUE,
                                       fixed=TRUE))
    allcols <- c(idcols, measurecols)
    # Extract only relevant columns from joined training and test data
    # Related to ask 2 in course project
    actsetdata <- actsetdata[,(names(actsetdata) %in% allcols)]
    message("Extracted required columns for merged data")
    
    # Reshape the data to get avg of each column for each activity and subject
    actsetdatamelt <- melt(actsetdata, id=idcols, measure.vars=measurecols)
    actsetfinaldata <- dcast(actsetdatamelt, subject*activity ~ variable, 
                             mean)
    message("Reshaped to get the final data set")
    
    # Write the final data set to a file
    write.table(actsetfinaldata, file="tidy_dataset_course_project.txt", 
                row.names=FALSE, col.names=TRUE)
    message("Complete - written the final data set to output file")
}