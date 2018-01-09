#CPG plots

fileToCPG <- "D:/karina/docencia/areferenciesPPT/9.Clustering/PracticaEnR/CPGkNoLatex.r"

source(fileToCPG)

dd <- dataset

dd$DISEASE_STATUS <- as.character(dd$DISEASE_STATUS)
dd$DISEASE_STATUS[dd$DISEASE_STATUS == "greater_than_fifthy_percent_diameter_narrowing"] <- "Disease_Found"
dd$DISEASE_STATUS[dd$DISEASE_STATUS == "less_than_fifthy_percent_diameter_narrowing"] <- "Disease_Not_Found"
dd$DISEASE_STATUS <- as.factor(dd$DISEASE_STATUS)

### Automatic CPG

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

### Manual plots to show the best ones

# Using Disease_Status

par(mfrow=c(2,6))

hist(x = dataset$AGE[dataset$DISEASE_STATUS == "Disease Found"], main = "Age", sub = "Disease Found", xlab = "AGE", ylab="Frequency",col="white")
plot(x = dataset$CHEST_PAIN[dataset$DISEASE_STATUS == "Disease Found"], main = "Chest Pain", sub = "Disease Found", xlab = "Chest Pain", ylab="Frequency",col="white")
hist(x = dataset$ST_DIFF_EXERCISE_VS_REST[dataset$DISEASE_STATUS == "Disease Found"], main = "ST Diff Exer. VS Rest", sub = "Disease Found", xlab = "ST Diff", ylab="Frequency",col="white")
plot(x = dataset$ST_SLOPE[dataset$DISEASE_STATUS == "Disease Found"], main = "ST Slope", sub = "Disease Found", xlab = "ST Slope", ylab="Frequency",col="white")
plot(x = dataset$THALIUM_STRESS_TEST_RESULT[dataset$DISEASE_STATUS == "Disease Found"], main = "Thalium Stress Test", sub = "Disease Found", xlab = "Thalium Stress Test", ylab="Frequency",col="white")
plot(x = dataset$HOSPITAL[dataset$DISEASE_STATUS == "Disease Found"], main = "Hospital", sub = "Disease Found", xlab = "Hospital", ylab="Frequency",col="white")

hist(x = dataset$AGE[dataset$DISEASE_STATUS == "Disease Not Found"], main = "Age", sub = "Disease Not Found", xlab = "AGE", ylab="Frequency",col="white")
plot(x = dataset$CHEST_PAIN[dataset$DISEASE_STATUS == "Disease Not Found"], main = "Chest Pain", sub = "Disease Not Found", xlab = "Chest Pain", ylab="Frequency",col="white")
hist(x = dataset$ST_DIFF_EXERCISE_VS_REST[dataset$DISEASE_STATUS == "Disease Not Found"], main = "ST Diff Exer. VS Rest", sub = "Disease Not Found", xlab = "ST Diff", ylab="Frequency",col="white")
plot(x = dataset$ST_SLOPE[dataset$DISEASE_STATUS == "Disease Not Found"], main = "ST Slope", sub = "Disease nOT Found", xlab = "ST Slope", ylab="Frequency",col="white")
plot(x = dataset$THALIUM_STRESS_TEST_RESULT[dataset$DISEASE_STATUS == "Disease Not Found"], main = "Thalium Stress Test", sub = "Disease Not Found", xlab = "Thalium Stress Test", ylab="Frequency",col="white")
plot(x = dataset$HOSPITAL[dataset$DISEASE_STATUS == "Disease Not Found"], main = "Hospital", sub = "Disease Not Found", xlab = "Hospital", ylab="Frequency",col="white")

# Using Hospitals

par(mfrow=c(4,6))

plot(x = dataset$SEX[dataset$HOSPITAL == "CLEVELAND"], main = "SEX", sub = "Cleveland", xlab = "SEX", ylab="Frequency",col="white")
plot(x = dataset$CHEST_PAIN[dataset$HOSPITAL == "CLEVELAND"], main = "Chest Pain", sub = "Cleveland", xlab = "Chest Pain", ylab="Frequency",col="white")
plot(x = dataset$REST_ELECTROCARDIO_RESULTS[dataset$HOSPITAL == "CLEVELAND"], main = "Electrocardio Results", sub = "Cleveland", xlab = "Electrocardio Results", ylab="Frequency",col="white")
plot(x = dataset$ST_SLOPE[dataset$HOSPITAL == "CLEVELAND"], main = "ST Slope", sub = "Cleveland", xlab = "ST Slope", ylab="Frequency",col="white")
plot(x = dataset$DISEASE_STATUS[dataset$HOSPITAL == "CLEVELAND"], main = "Disease Status", sub = "Cleveland", xlab = "Disease Status", ylab="Frequency",col="white")
plot(x = dataset$SMOKED[dataset$HOSPITAL == "CLEVELAND"], main = "Smoked", sub = "Cleveland", xlab = "Smoked", ylab="Frequency",col="white")

plot(x = dataset$SEX[dataset$HOSPITAL == "HUNGARIAN"], main = "SEX", sub = "Hungarian", xlab = "SEX", ylab="Frequency",col="white")
plot(x = dataset$CHEST_PAIN[dataset$HOSPITAL == "HUNGARIAN"], main = "Chest Pain", sub = "Hungarian", xlab = "Chest Pain", ylab="Frequency",col="white")
plot(x = dataset$REST_ELECTROCARDIO_RESULTS[dataset$HOSPITAL == "HUNGARIAN"], main = "Electrocardio Results", sub = "Hungarian", xlab = "Electrocardio Results", ylab="Frequency",col="white")
plot(x = dataset$ST_SLOPE[dataset$HOSPITAL == "HUNGARIAN"], main = "ST Slope", sub = "Hungarian", xlab = "ST Slope", ylab="Frequency",col="white")
plot(x = dataset$DISEASE_STATUS[dataset$HOSPITAL == "HUNGARIAN"], main = "Disease Status", sub = "Hungarian", xlab = "Disease Status", ylab="Frequency",col="white")
plot(x = dataset$SMOKED[dataset$HOSPITAL == "HUNGARIAN"], main = "Smoked", sub = "Hungarian", xlab = "Smoked", ylab="Frequency",col="white")

plot(x = dataset$SEX[dataset$HOSPITAL == "LONGBEACH"], main = "SEX", sub = "LongBeach", xlab = "SEX", ylab="Frequency",col="white")
plot(x = dataset$CHEST_PAIN[dataset$HOSPITAL == "LONGBEACH"], main = "Chest Pain", sub = "LongBeach", xlab = "Chest Pain", ylab="Frequency",col="white")
plot(x = dataset$REST_ELECTROCARDIO_RESULTS[dataset$HOSPITAL == "LONGBEACH"], main = "Electrocardio Results", sub = "LongBeach", xlab = "Electrocardio Results", ylab="Frequency",col="white")
plot(x = dataset$ST_SLOPE[dataset$HOSPITAL == "LONGBEACH"], main = "ST Slope", sub = "LongBeach", xlab = "ST Slope", ylab="Frequency",col="white")
plot(x = dataset$DISEASE_STATUS[dataset$HOSPITAL == "LONGBEACH"], main = "Disease Status", sub = "LongBeach", xlab = "Disease Status", ylab="Frequency",col="white")
plot(x = dataset$SMOKED[dataset$HOSPITAL == "LONGBEACH"], main = "Smoked", sub = "LongBeach", xlab = "Smoked", ylab="Frequency",col="white")

plot(x = dataset$SEX[dataset$HOSPITAL == "SWITZERLAND"], main = "SEX", sub = "Switzerland", xlab = "SEX", ylab="Frequency",col="white")
plot(x = dataset$CHEST_PAIN[dataset$HOSPITAL == "SWITZERLAND"], main = "Chest Pain", sub = "Switzerland", xlab = "Chest Pain", ylab="Frequency",col="white")
plot(x = dataset$REST_ELECTROCARDIO_RESULTS[dataset$HOSPITAL == "SWITZERLAND"], main = "Electrocardio Results", sub = "Swtizerland", xlab = "Electrocardio Results", ylab="Frequency",col="white")
plot(x = dataset$ST_SLOPE[dataset$HOSPITAL == "SWITZERLAND"], main = "ST Slope", sub = "SWitzerland", xlab = "ST Slope", ylab="Frequency",col="white")
plot(x = dataset$DISEASE_STATUS[dataset$HOSPITAL == "SWITZERLAND"], main = "Disease Status", sub = "Switzerland", xlab = "Disease Status", ylab="Frequency",col="white")
plot(x = dataset$SMOKED[dataset$HOSPITAL == "SWITZERLAND"], main = "Smoked", sub = "Switzerland", xlab = "Smoked", ylab="Frequency",col="white")

