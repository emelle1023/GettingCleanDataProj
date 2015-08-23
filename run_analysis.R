# #############################################
#           Pre-set directories 
# #############################################
dirPersonal <- "~/Documents/My Courses/Data Science/3. Getting and Cleaning Data/Exercises/Course Project"
dirRoot <- paste(dirPersonal, "GettingCleanDataProj", sep = "/")
filename <- "getdata_dataset.zip"
dirname <- "UCI HAR Dataset"
dirTest <- "test"
dirTrain <- "train"
dirInertial <- "Inertial Signals"


# #############################################
#           Download and unzip file 
# #############################################
setwd(dirRoot)
if (!file.exists(filename)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")    
}
if (!file.exists("UCI HAR Dataset")) {
    unzip(filename)
}

# ###########################################################################
#   1. Merge the training and the test sets to create one data set.          
# ###########################################################################

# -------------------------------
#       Load test datasets
# -------------------------------

# Load actvity and rename the columns
setwd(paste(dirRoot, dirname, sep="/"))
labels <- read.table("activity_labels.txt")
names(labels)[1] <- "label_id"; names(labels)[2] <- "label"

# Load feature and rename the columns
features <- read.table("features.txt")
names(features)[1] <- "feature_id"; names(features)[2] <- "feature"

# Load subject_test and rename the columns
setwd(paste(dirRoot, dirname, dirTest, sep = "/")) 
subject_test <- read.table("subject_test.txt"); names(subject_test)[1] <- "subject_id"

# Load y_test and rename the column
y_test <- read.table("y_test.txt")
names(y_test)[1] <- "label_id"

# Load x test data and name the columns by features
x_test <- read.table("X_test.txt")
for (i in 1:nrow(features)) {
    names(x_test)[i] <- as.character(features$feature[i])
}

# Load inertia data and name the columns
setwd(paste(dirRoot, dirname, dirTest, dirInertial, sep = "/")) 
bodyAccXTest <- read.table("body_acc_x_test.txt")
bodyAccYTest <- read.table("body_acc_y_test.txt")
bodyAccZTest <- read.table("body_acc_z_test.txt")
bodyGyroXTest <- read.table("body_gyro_x_test.txt")
bodyGyroYTest <- read.table("body_gyro_y_test.txt")
bodyGyroZTest <- read.table("body_gyro_z_test.txt")
totalAccXTest <- read.table("total_acc_x_test.txt")
totalAccYTest <- read.table("total_acc_y_test.txt")
totalAccZTest <- read.table("total_acc_z_test.txt")
for (i in 1:length(bodyAccXTest)) {
    names(bodyAccXTest)[i] <- paste0("accx", i)
    names(bodyAccYTest)[i] <- paste0("accy", i)
    names(bodyAccZTest)[i] <- paste0("accz", i)
    names(bodyGyroXTest)[i] <- paste0("gyrox", i)
    names(bodyGyroYTest)[i] <- paste0("gyroy", i)
    names(bodyGyroZTest)[i] <- paste0("gyroz", i)
    names(totalAccXTest)[i] <- paste0("totalaccx", i)
    names(totalAccYTest)[i] <- paste0("totalaccy", i)
    names(totalAccZTest)[i] <- paste0("totalaccz", i)
}

# -----------------------------------
#       combine test datasets
# -----------------------------------

# combine y_test and labels, y_test_label
y_test_label <- merge(y_test, labels, by.x = "label_id", by.y = "label_id", all=TRUE)
subject_y_test_label <- cbind(subject_test, y_test_label)

# Combine all inertia data
subject_y_test_label_inertial <- cbind(subject_y_test_label, 
    bodyAccXTest, bodyAccYTest, bodyAccZTest, bodyGyroXTest, 
    bodyGyroYTest, bodyGyroZTest, totalAccXTest, totalAccYTest, totalAccZTest)

# Combine all test data sets
test <- cbind(subject_y_test_label_inertial, x_test)

# Specify a new column to represent test data
test <- cbind(data="test", test)


# --------------------------------------
#       Load training data sets
# --------------------------------------

# Load subject_train and rename the column
setwd(paste(dirRoot, dirname, dirTrain, sep="/"))
subject_train <- read.table("subject_train.txt")
names(subject_train)[1] <- "subject_id"

# Load y_train and rename columns
y_train <- read.table("y_train.txt")
names(y_train)[1] <- "label_id"

# Load the x_train data and name the columns by feature
x_train <- read.table("X_train.txt")
for (i in 1:nrow(features)) {
    names(x_train)[i] <- as.character(features$feature[i])
}

# Load all inertia training data and name columns
setwd(paste(dirRoot, dirname, dirTrain, dirInertial, sep="/"))
bodyAccXTrain <- read.table("body_acc_x_train.txt")
bodyAccYTrain <- read.table("body_acc_y_train.txt")
bodyAccZTrain <- read.table("body_acc_z_train.txt")
bodyGyroXTrain <- read.table("body_gyro_x_train.txt")
bodyGyroYTrain <- read.table("body_gyro_y_train.txt")
bodyGyroZTrain <- read.table("body_gyro_z_train.txt")
totalAccXTrain <- read.table("total_acc_x_train.txt")
totalAccYTrain <- read.table("total_acc_y_train.txt")
totalAccZTrain <- read.table("total_acc_z_train.txt")
for (i in 1:length(bodyAccXTrain)) {
    names(bodyAccXTrain)[i] <- paste0("accx", i)
    names(bodyAccYTrain)[i] <- paste0("accy", i)
    names(bodyAccZTrain)[i] <- paste0("accz", i)
    names(bodyGyroXTrain)[i] <- paste0("gyrox", i)
    names(bodyGyroYTrain)[i] <- paste0("gyroy", i)
    names(bodyGyroZTrain)[i] <- paste0("gyroz", i)
    names(totalAccXTrain)[i] <- paste0("totalaccx", i)
    names(totalAccYTrain)[i] <- paste0("totalaccy", i)
    names(totalAccZTrain)[i] <- paste0("totalaccz", i)
}

# ----------------------------------------
#       Combine training data sets
# ----------------------------------------

# merge y and labels 
y_train_label <- merge(y_train, labels, by.x = "label_id", by.y = "label_id", all=TRUE)

# merge subjects and y_train_label 
subject_y_train_label <- cbind(subject_train, y_train_label)

# merge all inertia training data
subject_y_train_label_inertial <- cbind(subject_y_train_label, 
    bodyAccXTrain, bodyAccYTrain, bodyAccZTrain, bodyGyroXTrain, bodyGyroYTrain, 
    bodyGyroZTrain, totalAccXTrain, totalAccYTrain, totalAccZTrain)

# Merge all x training data
train <- cbind(subject_y_train_label_inertial, x_train)

# Specify a new column to represent train data
train <- cbind(data="train", train)


# ------------------------------------------------
#       Merge test and train together
# ------------------------------------------------
dataset <- rbind(train, test)

################################################################################################
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
################################################################################################
features


# select columns from dataset contains keyword mean and std
inertiaActivities <- names(dataset)[5:ncol(dataset)]
meanActivity <- grep("mean()", inertiaActivities, value = TRUE, fixed = TRUE)
stdActivity <- grep('std()', inertiaActivities, value = TRUE, fixed = TRUE)
meanStdAct <- c(meanActivity, stdActivity); 

# Add the first 4 columns and columns that contain only mean and std
firstForthHeader <- dataset[, 1:4]
dataset1 <- dataset[,c( names(firstForthHeader), meanStdAct)]


##############################################################################
# 3. Use descriptive activity names to name the activities in the data set
##############################################################################

names(dataset1) <- tolower(names(dataset1))
names(dataset1) <- gsub("_","", names(dataset1))


# ##########################################################################
# 4. Appropriately label the data set with descriptive activity names. 
# ##########################################################################

names(dataset1) <- gsub("\\()","", names(dataset1))
names(dataset1) <- gsub("acc", "accelerometer", names(dataset1))
names(dataset1) <- gsub("gyro", "gyroscope", names(dataset1))
names(dataset1) <- gsub("mag", "magnitude", names(dataset1))
names(dataset1) <- gsub("-","", names(dataset1))


# ############################################################################
#   5. Creates a second, independent tidy data set with the average of 
#           each variable for each activity and each subject. 
# ############################################################################

# Creat the mean only for mean and std by each subject
library(dplyr)

dataset2 <- dataset1
newMeanVector <- names(dataset2)[5:length(dataset2)]
newMeanVector
# newMeanVectorBySubject <- paste0(newMeanVector, "bysubject") 

names(dataset2)

dataset3 <- dataset2 %>% group_by(subjectid, labelid, label) %>% summarise_each(funs(mean), 5:70)

# Write the final dataset to a text file
setwd(paste(dirRoot, dirname, sep="/"))
write.table(dataset3, file = "dataset.txt", row.names = FALSE)


