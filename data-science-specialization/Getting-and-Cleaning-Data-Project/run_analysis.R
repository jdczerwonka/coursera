  setwd("C:\\Users\\Jonathan.WSF\\Desktop\\UCI HAR Dataset")
  df_test <- read.table("test\\X_test.txt", colClasses = as.numeric())
  df_train <- read.table("train\\X_train.txt", colClasses = as.numeric())

  df_test_f <- read.table("test\\y_test.txt",colClasses = as.numeric())
  df_train_f <- read.table("train\\y_train.txt",colClasses = as.numeric())
  
  df_test_sub <- read.table("test\\subject_test.txt",colClasses = as.numeric())
  df_train_sub <-read.table("train\\subject_train.txt",colClasses = as.numeric())
  
  df_comb <- rbind(df_test,df_train)
  df_comb_f <- rbind(df_test_f,df_train_f)
  df_comb_sub <- rbind(df_test_sub,df_train_sub)
  
  df <- df_comb[,c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)]
  df <- cbind(df_comb_f,df)
  df <- cbind(df_comb_sub,df)
  
  VarNames <- c("BodyAccXMean","BodyAccYMean","BodyAccZMean","BodyAccXStd","BodyAccYStd","BodyAccZStd",
                   "GravAccXMean","GravAccYMean","GravAccZMean","GravAccXStd","GravAccYStd","GravAccZStd",
                   "BodyAccJerkXMean","BodyAccJerkYMean","BodyAccJerkZMean","BodyAccJerkXStd","BodyAccJerkYStd","BodyAccJerkZStd",
                   "BodyGyroXMean","BodyGyroYMean","BodyGyroZMean","BodyGyroXStd","BodyGyroYStd","BodyGyroZStd",
                   "BodyGyroJerkXMean","BodyGyroJerkYMean","BodyGyroJerkZMean","BodyGyroJerkXStd","BodyGyroJerkYStd","BodyGyroJerkZStd",
                   "BodyAccMagMean","BodyAccMagStd","GravAccMagMean","GravAccMagStd","BodyAccMagJerkMean","BodyAccMagJerkStd",
                   "BodyGyroMagMean","BodyGyroMagStd","BodyGyroJerkMagMean","BodyGyroJerkMagStd",
                   "fftBodyAccXMean","fftBodyAccYMean","fftBodyAccZMean","fftBodyAccXStd","fftBodyAccYStd","fftBodyAccZStd",
                   "fftBodyAccJerkXMean","fftBodyAccJerkYMean","fftBodyAccJerkZMean","fftBodyAccJerkXStd","fftBodyAccJerkYStd","fftBodyAccJerkZStd",
                   "fftBodyGyroXMean","fftBodyGyroYMean","fftBodyGyroZMean","fftBodyGyroXStd","fftBodyGyroYStd","fftBodyGyroZStd",
                   "fftBodyAccMagMean","fftBodyAccMagStd","fftBodyBodyAccJerkMagMean","fftBodyBodyAccJerkMagStd","fftBodyBodyGyroMagMean","fftBodyBodyGyroMagStd",
                   "fftBodyBodyGyroJerkMagMean","fftBodyBodyGyroJerkMagStd")
  colnames(df) = c("Subject","Activity",VarNames)
  
  for(x in 1:nrow(df)){
    if(df[x,"Activity"]==1){
      df[x,"Activity"] <- "Walking"
    }else if(df[x,"Activity"]==2){
      df[x,"Activity"] <- "WalkingUp"
    }else if(df[x,"Activity"]==3){
      df[x,"Activity"] <- "WalkingDown"
    }else if(df[x,"Activity"]==4){
      df[x,"Activity"] <- "Sitting"
    }else if(df[x,"Activity"]==5){
      df[x,"Activity"] <- "Standing"
    }else if(df[x,"Activity"]==6){
      df[x,"Activity"] <- "Laying"
    }
  }

  tidy_df <-aggregate(df[,3:ncol(df)], by=list(df$Subject,df$Activity), FUN=mean, na.rm=TRUE)
  colnames(tidy_df) = c("Subject","Activity",VarNames)  
  write.table(tidy_df,"Tidy Data.txt", quote=FALSE, row.name=FALSE)
