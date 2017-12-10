
librery(dyplyr)


##### loading dataset

subject_test <- read.table("test/subject_test.txt")

X_test <- read.table("test/X_test.txt")

y_test <- read.table("test/y_test.txt")


subject_train <- read.table("train/subject_train.txt")

X_train <- read.table("train/X_train.txt")

y_train <- read.table("train/y_train.txt")


#### combining test datasets

test <- cbind(subject_test,y_test,X_test )

### combining train datasets

train <- cbind(subject_train,y_train,X_train )

###### combining test and train datasets

test_train <- rbind(train, test)

#### Appropriately labels the data set with descriptive variable names.

features <- read.table("features.txt")

colnames(test_train) <- c("subject", "lables", as.character(features[,2]))

###### Extracts only the measurements on the mean and standard deviation for each measurement


mean_sd <- grep("mean|std",colnames(test_train))

test_train2 <- test_train[,c(1,2,mean_sd)]

#### Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("activity_labels.txt")

test_train3 <- merge(activity_labels,test_train2, by.y = "lables", by.x = "V1" )

test_train3 <- select(test_train3,-V1)

colnames(test_train3)[1] <- "activity" 

####  creates a second, independent tidy data set with the average of each variable for each activity and each subject 

test_train3$subject <- as.factor(test_train3$subject)

final <- group_by(test_train3, subject,activity)

final2 <- summarise_all(final,funs(mean))


write.table(final2,"dataset.txt",quote = FALSE, row.names = FALSE )


