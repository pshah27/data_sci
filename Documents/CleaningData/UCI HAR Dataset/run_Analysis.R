#This script is for part 1 of the course project.
library(data.table)
library(dplyr)
library(tidyr)

#load the features
features<-read.table("features.txt")

#Train dataset

X_Train<-read.table("./train/X_train.txt",col.names=features[,2])
#Load the activity data
y_train<-read.table("./train/y_train.txt",col.names="Activity")
#load the subject data
sub_train<-read.table("./train/subject_train.txt",col.names="Subject")

#Test dataset

X_Test<-read.table("./test/X_test.txt",col.names=features[,2])
#Load the activity data
y_test<-read.table("./test/y_test.txt",col.names="Activity")
#load the subject data
sub_test<-read.table("./test/subject_test.txt",col.names="Subject")

#Merge the four data sets above into one
#First organize the training set
Train<-cbind(sub_train,y_train,X_Train)
#Second organize the test set
Test<-cbind(sub_test,y_test,X_Test)
#Row bind the training and testing data set
TT<-rbind(Train,Test)


#Extract only the measurements on the mean and standard deviation
TT_MeanSD<-select(TT,Subject,Activity,contains("mean"),contains("std"),contains("Mean"))

#Name the activities in the data set created above
acts<-read.table("activity_labels.txt",col.names=c("Id","Activities"))
TT_MeanSD_Acts<-merge(TT_MeanSD,acts,by.x="Activity",by.y="Id")
TT_MeanSD_Acts<-select(TT_MeanSD_Acts,Subject:Activities) 
TT_MeanSD_Acts<-TT_MeanSD_Acts[c(88,1:87)]



#Create a mean for each variable for each activity and each subject
#need to group the data set by subject and then activities
final<-group_by(TT_MeanSD_Acts,Activities,Subject)
test<-aggregate(final,list(final$Activities,final$Subject),mean)
test1<-select(test,-contains("Activities"),-contains("Subject"))
names (test1)[1]="Activities"
names (test1)[2]="Subject"


#Write out the final data frame onto a text file
write.table(test1, "Tidy_Data.txt",row.name=FALSE)
