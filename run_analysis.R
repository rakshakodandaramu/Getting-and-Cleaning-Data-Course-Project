####---------------- read data -----------------------#############

setwd("C:/Course Work/Machine learning/Courseera/R/Course 3/Assignemnet 2/UCI HAR Dataset/")
testdata_x<-read.table("test/X_test.txt")
tesdata_y<-read.table("test/y_test.txt")
tesdata_subject<-read.table("test/subject_test.txt")
traindata_x<-read.table("train/X_train.txt")
traindata_y<-read.table("train/y_train.txt")
traindata_subject<-read.table("train/subject_train.txt")

########## extract features, activity lables and then only filter mean and std features-----------########
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")
featureIndex<-grep("-mean()|-std()",as.character(unlist(features[2])))
finFeatureNames<-features$V2[featureIndex]
########3 install package tidyverse
########### merge data and add feature names #######################
testdata_x<-testdata_x[,featureIndex]
traindata_x<-traindata_x[,featureIndex]
test<-cbind(testdata_x,tesdata_y,tesdata_subject)
colnames(test)<-c(as.character(unlist(finFeatureNames)),"activity","subject")
train<-cbind(traindata_x,traindata_y,traindata_subject)
colnames(train)<-c(as.character(unlist(finFeatureNames)),"activity","subject")
Findata<-rbind(test,train)

########### summarising Data ########
SummData<-Findata %>% group_by(activity,subject) %>% summarise_all(funs(mean))
