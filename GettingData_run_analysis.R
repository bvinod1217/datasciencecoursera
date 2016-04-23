#load dependencies
library(dplyr)

#load features, class labels
setwd("~/Downloads/UCI HAR Dataset")
dat.colnames<-read.table("features.txt")
dat.colnames<-as.character(dat.colnames[,2])
dat.class.labels<-read.table("activity_labels.txt")

#load training data, clean up
setwd("~/Downloads/UCI HAR Dataset/train")
x.train<-readLines("X_train.txt")
x.train2<-lapply(x.train,function(x) unlist(strsplit(x,"[[:space:]]+"))[-1])
x.train3<-data.frame(x.train2)
x.train3<-t(x.train3)
x.train3<-apply(x.train3,c(1,2),as.numeric)
subj.train<-read.table("subject_train.txt")
y.train<-read.table("y_train.txt")
grep("",dat.colnames)

#load test data, clean up
setwd("~/Downloads/UCI HAR Dataset/test")
x.test<-readLines("X_test.txt")
x.test2<-lapply(x.test,function(x) unlist(strsplit(x,"[[:space:]]+"))[-1])
x.test3<-data.frame(x.test2)
x.test3<-t(x.test3)
x.test3<-apply(x.test3,c(1,2),as.numeric)
subj.test<-read.table("subject_test.txt")
y.test<-read.table("y_test.txt")
x.train3<-data.frame(x.train3,"DataSet"="train")
x.test3<-data.frame(x.test3,"DataSet"="test")

#combine training and test data, clean up
x.comb<-rbind(x.train3,x.test3)
subj.comb<-rbind(subj.train,subj.test)
y.comb<-rbind(y.train,y.test)
rownames(x.comb)<-1:nrow(x.comb)
colnames(x.comb)[1:(ncol(x.comb)-1)]<-dat.colnames
x.comb<-x.comb[,grep("mean[(][)]|std[(][)]|data",colnames(x.comb))]
dat.cleaned<-data.frame(subj.comb,y.comb,x.comb)
colnames(dat.cleaned)[c(1,2,ncol(dat.cleaned))]<-c("SubjectID","YLabel","DataSet")
colnames(dat.cleaned)<-gsub("\\.+","\\.",colnames(dat.cleaned))
dat.cleaned$YLabel<-merge(data.frame(dat.cleaned$YLabel),dat.class.labels,by.x="dat.cleaned.YLabel",by.y="V1")[,2]

#calculate summary table with averages of features for each ind and activity, output
data.summary<-ddply(dat.cleaned,.(),list(dat.cleaned$SubjectID,dat.cleaned$YLabel),mean)
dat.summary<-dat.cleaned %>% group_by(SubjectID,YLabel) %>% summarise_each(funs(mean(., na.rm=TRUE)),-DataSet)
write.table(dat.summary,"tidy.txt",row.names=F)

