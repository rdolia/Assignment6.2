#Importing the titanic dataset into R
library(xlsx)
titanicdf<-read.xlsx("titanic3.xls",1)
titanic_fare<- titanicdf[c(1,9)]
library(sqldf)
titanic_class1 <- sqldf("SELECT * FROM titanic_fare 
                        WHERE pclass = '1'")
titanic_class1
titanic_class2 <- sqldf("SELECT * FROM titanic_fare 
                        WHERE pclass = '2'")
titanic_class2
titanic_class3 <- sqldf("SELECT * FROM titanic_fare 
                        WHERE pclass = '3'")
titanic_class3


boxplot(titanic_class1$fare,titanic_class2$fare,titanic_class3$fare, xlab = "CLASSES", ylab = "FARES", main = "CLASSWISE FARES")

#. Is there any association with Passenger class and
#gender?
#  Note- show a stacked bar chart

titanic_gender_class <- titanicdf[c(1,4)]
library(sqldf)
class1_female <- sqldf("SELECT * 
      FROM titanic_gender_class 
      WHERE pclass = '1' AND `sex` = 'female'")

class1_male <- sqldf("SELECT * 
                       FROM titanic_gender_class 
                       WHERE pclass = '1' AND `sex` = 'male'")
class2_female <- sqldf("SELECT * 
      FROM titanic_gender_class 
                       WHERE pclass = '2' AND `sex` = 'female'")
class2_male <- sqldf("SELECT * 
      FROM titanic_gender_class 
                       WHERE pclass = '2' AND `sex` = 'male'")
class3_male <- sqldf("SELECT * 
      FROM titanic_gender_class 
                       WHERE pclass = '3' AND `sex` = 'male'")
class3_female <- sqldf("SELECT * 
      FROM titanic_gender_class 
                     WHERE pclass = '3' AND `sex` = 'female'")

#counts of classwise male and female
class1_fcount <- nrow(class1_female)
class1_mcount <-nrow(class1_male)
class2fcount  <-nrow(class2_female)
class2mcount  <-nrow(class2_male)
class3fcount  <-nrow(class3_female)
class3mcount  <-nrow(class3_male)

#rbinding m and f under same class
class1<- rbind(class1_fcount,class1_mcount)
class2<- rbind(class2fcount,class2mcount)
class3<- rbind(class3fcount,class3mcount)

#cbinding the 3 classes
all_classes<- cbind(class1,class2,class3)
colnames(all_classes) <- c("Class 1","Class 2","Class 3")
row.names(all_classes) <- c("Count of Female", "Count of Male")
barplot(as.matrix(all_classes),xlab = "CLASSES",ylab = "GENDER",
        main = "Classwise Gender Count",col = c("red","blue"))
legend("topleft",
       c("Female","Male"),
       fill = c("red","blue")
)
