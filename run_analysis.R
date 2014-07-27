Enter file contents here#Reading data from the test dataset
X_test<-read.table("./project/UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./project/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./project/UCI HAR Dataset/test/subject_test.txt")

#Reading data from the training dataset
X_train<-read.table("./project/UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./project/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./project/UCI HAR Dataset/train/subject_train.txt")

#Reading the activity and features files
activity<-read.table("./project/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./project/UCI HAR Dataset/features.txt")

head(features,2) #to see the contents of features
features<-as.character(features$V2) #leaving only the names of the measurements in features

#Merging the train and test data

CombinedData<-rbind(X_train,X_test)



#Adding variable names

names(CombinedData)<-features


#Selecting only the data about the mean and the std

ReducedSet<-CombinedData[,grep("mean|std",names(CombinedData))]

#Adding subject and activity information
ReducedSet<-cbind(ReducedSet,rbind(subject_train,subject_test),rbind(Y_train,Y_test))

names(ReducedSet)[80:8]<-c("Subject","Activity")


#Aggregating data to creates a second, independent tidy data set with the average 
#of each variable for each activity and each subject. 

aggdat <- aggregate(. ~ Subject + Activity, data = ReducedSet, FUN=mean)


#determining the activity names
head(activity,2)
activity<-as.character(activity$V2)

#replacing the activity code(i.e the numbers in aggdat$Activity with names)
aggdat$Activity<-activity[aggdat$Activity]

#changing the variable names (impossible to make them fine)
names(aggdat)<-gsub("\\()","",names(aggdat))
names(aggdat)<-gsub("-","_",names(aggdat))




