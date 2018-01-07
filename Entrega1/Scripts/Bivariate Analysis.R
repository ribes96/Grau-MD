
rm(list = ls()) # Clear workspace
setwd("/home/raul/MD/Grau-MD-master/Entrega1/Datos")
dataset <- readRDS("dataset3.rds")

names <- names(dataset)

par(mfrow=c(1,1))
for (i in seq(1,18,1)){
    plot(dataset$SMOKED,dataset[,i])
    title(names[i])
}

par(mfrow=c(1,1))
plot(dataset$HOSPITAL,dataset$MAJOR_VESSELS,col=c("red","green","blue","yellow","black"),ylab = "Major Vessels", xlab="Hospital")
legend("topright", legend = c("0","1","2","3","unknown"), pch = 19,col=c("red","green","blue","yellow","black"))

par(mfrow=c(1,1))
plot(dataset$REST_HR, dataset$MAX_HR,ylab="Max HR", xlab="Rest HR")
title("Todos")
lines(c(60,100),c(120,170),col="red",lwd = 10)

par(mfrow=c(4,1))
plot(dataset$REST_HR[dataset$HOSPITAL=="CLEVELAND"], dataset$MAX_HR[dataset$HOSPITAL=="CLEVELAND"],ylab="Max HR", xlab="Rest HR")
title("Cleveland")
plot(dataset$REST_HR[dataset$HOSPITAL=="HUNGARIAN"], dataset$MAX_HR[dataset$HOSPITAL=="HUNGARIAN"],ylab="Max HR", xlab="Rest HR")
title("Hungarian")
plot(dataset$REST_HR[dataset$HOSPITAL=="LONGBEACH"], dataset$MAX_HR[dataset$HOSPITAL=="LONGBEACH"],ylab="Max HR", xlab="Rest HR")
title("LongBeach")
plot(dataset$REST_HR[dataset$HOSPITAL=="SWITZERLAND"], dataset$MAX_HR[dataset$HOSPITAL=="SWITZERLAND"],ylab="Max HR", xlab="Rest HR")
title("Switzerland")

par(mfrow=c(1,1))
plot(dataset$REST_BLOOD_PRESSURE, dataset$AGE, ylab="AGE", xlab="Rest Blood Pressure")
lines(c(100,160),c(50,60),col="red",lwd=10)
title("Todos")

par(mfrow=c(1,1))
plot(dataset$REST_BLOOD_PRESSURE,dataset$AGE,col=c("red","blue","green","black")[dataset$HOSPITAL], ylab="AGE", xlab="Rest Blood Pressure")
legend("topleft", inset=c(-0.1,-0.2),legend = c("Cleveland","Hungarian","LongBeach","Switzerland"),col=c("red","blue","green","black"),pch=19)
title("TODOS")

par(mfrow=c(1,4))
plot(y = dataset$REST_BLOOD_PRESSURE[dataset$HOSPITAL=="CLEVELAND"], x=  dataset$AGE[dataset$HOSPITAL=="CLEVELAND"], xlab="AGE", ylab="Rest Blood Pressure")
title("Cleveland")
plot(y=dataset$REST_BLOOD_PRESSURE[dataset$HOSPITAL=="HUNGARIAN"],x= dataset$AGE[dataset$HOSPITAL=="HUNGARIAN"], xlab="AGE", ylab="Rest Blood Pressure")
title("Hungarian")
plot(y=dataset$REST_BLOOD_PRESSURE[dataset$HOSPITAL=="LONGBEACH"],x= dataset$AGE[dataset$HOSPITAL=="LONGBEACH"], xlab="AGE", ylab="Rest Blood Pressure")
title("LongBeach")
plot(y=dataset$REST_BLOOD_PRESSURE[dataset$HOSPITAL=="SWITZERLAND"],x= dataset$AGE[dataset$HOSPITAL=="SWITZERLAND"], xlab="AGE", ylab="Rest Blood Pressure")
title("Switzerland")

mean(dataset$AGE[dataset$REST_BLOOD_PRESSURE == 100])

par(mfrow=c(1,1))
plot(dataset$SMOKED, dataset$EXERCISE_DURATION_MINUTES, xlab="Smoker", ylab="Exercise Duration (min)")
title("TODOS")

par(mfrow=c(1,4))
plot(dataset$SMOKED[dataset$HOSPITAL=="CLEVELAND"], dataset$EXERCISE_DURATION_MINUTES[dataset$HOSPITAL=="CLEVELAND"], xlab="Smoker", ylab="Exercise Duration (min)")
title("Cleveland")
plot(dataset$SMOKED[dataset$HOSPITAL=="HUNGARIAN"], dataset$EXERCISE_DURATION_MINUTES[dataset$HOSPITAL=="HUNGARIAN"], xlab="Smoker", ylab="Exercise Duration (min)")
title("Hungarian")
plot(dataset$SMOKED[dataset$HOSPITAL=="LONGBEACH"], dataset$EXERCISE_DURATION_MINUTES[dataset$HOSPITAL=="LONGBEACH"], xlab="Smoker", ylab="Exercise Duration (min)")
title("LongBeach")
plot(dataset$SMOKED[dataset$HOSPITAL=="SWITZERLAND"], dataset$EXERCISE_DURATION_MINUTES[dataset$HOSPITAL=="SWITZERLAND"], xlab="Smoker", ylab="Exercise Duration (min)")
title("Switzerland")

par(mfrow=c(1,1))
plot(dataset$SMOKED, dataset$DISEASE_STATUS, xlab="SMOKED", ylab="DISEASE STATUS",yaxt='n',ann=FALSE)
legend("topright", legend = c("DISEASE FOUND","DISEASE NOT FOUND"),col=c(grey(0.6),grey(0.8)),pch=19)
title("Todos")

dataset2 <- dataset
dataset2$DISEASE_STATUS <- as.character(dataset2$DISEASE_STATUS)
dataset2$DISEASE_STATUS[dataset2$DISEASE_STATUS == "greater_than_fifthy_percent_diameter_narrowing"] <- "disease_found"
dataset2$DISEASE_STATUS[dataset2$DISEASE_STATUS == "less_than_fifthy_percent_diameter_narrowing"] <- "disease_not_found"
dataset2$DISEASE_STATUS <- as.factor(dataset2$DISEASE_STATUS)

par(mfrow=c(1,1))
plot(dataset2$SMOKED, dataset2$DISEASE_STATUS, xlab="SMOKED", ylab="DISEASE STATUS",yaxt='n',ann=FALSE)
title("Todos")

par(mfrow=c(1,4))
plot(dataset2$SMOKED[dataset$HOSPITAL=="CLEVELAND"], dataset2$DISEASE_STATUS[dataset$HOSPITAL=="CLEVELAND"], xlab="SMOKED", ylab="DISEASE STATUS",yaxt='n',ann=FALSE)
title("Cleveland")
plot(dataset2$SMOKED[dataset$HOSPITAL=="HUNGARIAN"], dataset2$DISEASE_STATUS[dataset$HOSPITAL=="HUNGARIAN"], xlab="SMOKED", ylab="DISEASE STATUS",yaxt='n',ann=FALSE)
title("Hungarian")
plot(dataset2$SMOKED[dataset$HOSPITAL=="LONGBEACH"], dataset2$DISEASE_STATUS[dataset$HOSPITAL=="LONGBEACH"], xlab="SMOKED", ylab="DISEASE STATUS",yaxt='n',ann=FALSE)
title("LongBeach")
plot(dataset2$SMOKED[dataset$HOSPITAL=="SWITZERLAND"], dataset2$DISEASE_STATUS[dataset$HOSPITAL=="SWITZERLAND"], xlab="SMOKED", ylab="DISEASE STATUS",yaxt='n',ann=FALSE)
title("Switzerland")

par(mfrow=c(1,1))
plot(dataset$MAX_HR,dataset$REST_HR,col=c("red","blue","green","black")[dataset$HOSPITAL],ylab = "REST_HR",xlab = "MAX_HR")
legend("topleft", inset=c(0.0,-0.0),legend = c("Cleveland","Hungarian","LongBeach","Switzerland"),col=c("red","blue","green","black"),pch=19)

par(mfrow=c(4,1))
plot(dataset$MAX_HR[dataset$HOSPITAL == "CLEVELAND"], dataset$REST_HR[dataset$HOSPITAL == "CLEVELAND"],ylab = "REST_HR",xlab = "MAX_HR")
title("CLEVELAND")
plot(dataset$MAX_HR[dataset$HOSPITAL == "HUNGARIAN"], dataset$REST_HR[dataset$HOSPITAL == "HUNGARIAN"],ylab = "REST_HR",xlab = "MAX_HR")
title("HUNGARIAN")
plot(dataset$MAX_HR[dataset$HOSPITAL == "LONGBEACH"], dataset$REST_HR[dataset$HOSPITAL == "LONGBEACH"],ylab = "REST_HR",xlab = "MAX_HR")
title("LONGBEACH")
plot(dataset$MAX_HR[dataset$HOSPITAL == "SWITZERLAND"], dataset$REST_HR[dataset$HOSPITAL == "SWITZERLAND"],ylab = "REST_HR",xlab = "MAX_HR")
title("SWITZERLAND")

