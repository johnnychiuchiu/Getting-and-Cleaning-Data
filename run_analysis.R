library(dplyr)
setwd('/Users/JohnnyChiu/Desktop/檔案總管/學習/coursera/JohnHopkins-DataScience/Getting and Cleaning Data//UCI HAR Dataset')
                                  
run_analysis<-function(){
  library(dplyr)
  x_test<-read.table('test/X_test.txt') %>% tbl_df
  y_test<-read.table('test/y_test.txt') %>% tbl_df
  x_train<-read.table('train/X_train.txt') %>% tbl_df
  y_train<-read.table('train/y_train.txt') %>% tbl_df 
  subject_test<-read.table('test/subject_test.txt') %>% tbl_df 
  subject_train<-read.table('train/subject_train.txt') %>% tbl_df 
  colnames(y_test)='Y'
  colnames(y_train)='Y'
  colnames(subject_test)='subject'
  colnames(subject_train)='subject'
  test<-tbl_df(cbind(x_test,y_test,subject_test)) %>% mutate(status='test')
  train<-cbind(x_train,y_train,subject_train)%>% tbl_df %>% mutate(status='train')
  
  data<-rbind_list(train,test)
  group_by_activity_labels<-data %>% group_by(Y) %>% summarise_each(funs(mean,sd)) %>% print
  group_by_subject<-data %>% group_by(subject) %>% summarise_each(funs(mean,sd)) %>% print                                    
  
  return(data)
  return(group_by_activity_labels)
  return(group_by_subject)
}

write.table(data,'FinalData.txt',row.name=FALSE)