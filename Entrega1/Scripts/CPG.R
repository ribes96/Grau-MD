#CPG plots

source("D:/karina/docencia/areferenciesPPT/9.Clustering/PracticaEnR/CPGkNoLatex.r")

dd <- dataset

dd$DISEASE_STATUS <- as.character(dd$DISEASE_STATUS)
dd$DISEASE_STATUS[dd$DISEASE_STATUS == "greater_than_fifthy_percent_diameter_narrowing"] <- "Disease_Found"
dd$DISEASE_STATUS[dd$DISEASE_STATUS == "less_than_fifthy_percent_diameter_narrowing"] <- "Disease_Not_Found"
dd$DISEASE_STATUS <- as.factor(dd$DISEASE_STATUS)

active1<-c(1,2,3,4)
active2<-c(5,6,7,8)
active3<-c(9,10,11,12)
active4<-c(13,14,15,16)
active5<-c(17,18,19,20)

createCPG(dd[,active1], dd$HOSPITAL)
createCPG(dd[,active2], dd$HOSPITAL)
createCPG(dd[,active3], dd$HOSPITAL)
createCPG(dd[,active4], dd$HOSPITAL)
createCPG(dd[,active5], dd$HOSPITAL)

