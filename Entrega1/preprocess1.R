
rm(list = ls())
setwd("/home/raul/MD/Grau-MD-master/Entrega1/Datos")
dataset <- readRDS("dataset.rds")

# DISEASE_STATUS -> FIXING SOME VALUES

dataset$DISEASE_STATUS[dataset$DISEASE_STATUS == "1"] <- "greater_than_fifthy_percent_diameter_narrowing"
dataset$DISEASE_STATUS[dataset$DISEASE_STATUS == "2"] <- "greater_than_fifthy_percent_diameter_narrowing"
dataset$DISEASE_STATUS[dataset$DISEASE_STATUS == "3"] <- "greater_than_fifthy_percent_diameter_narrowing"
dataset$DISEASE_STATUS[dataset$DISEASE_STATUS == "4"] <- "greater_than_fifthy_percent_diameter_narrowing"
dataset$DISEASE_STATUS <- droplevels(dataset$DISEASE_STATUS)
levels(dataset$DISEASE_STATUS)

# SMOKED -> UNKNOWN QUALITATIVE

dataset$SMOKED[dataset$SMOKED == "NA"] <- "unknown"
dataset$SMOKED <- as.character(dataset$SMOKED)
dataset$SMOKED <- as.factor(dataset$SMOKED)
dataset$SMOKED <- droplevels(dataset$SMOKED)
levels(dataset$SMOKED)

# BLOOD_SUGAR -> UNKNOWN QUALITATIVE

dataset$BLOOD_SUGAR <- as.character(dataset$BLOOD_SUGAR)
dataset$BLOOD_SUGAR[is.na(dataset$BLOOD_SUGAR)] <- "unknown"
dataset$BLOOD_SUGAR <- as.factor(dataset$BLOOD_SUGAR)
dataset$BLOOD_SUGAR <- droplevels(dataset$BLOOD_SUGAR)
levels(dataset$BLOOD_SUGAR)

# REST_ELECTROCARDIO_RESULTS -> UNKNOWN QUALITATIVE

dataset$REST_ELECTROCARDIO_RESULTS <- as.character(dataset$REST_ELECTROCARDIO_RESULTS)
dataset$REST_ELECTROCARDIO_RESULTS[is.na(dataset$REST_ELECTROCARDIO_RESULTS)] <- "unknown"
dataset$REST_ELECTROCARDIO_RESULTS <- as.factor(dataset$REST_ELECTROCARDIO_RESULTS)
dataset$REST_ELECTROCARDIO_RESULTS <- droplevels(dataset$REST_ELECTROCARDIO_RESULTS)
levels(dataset$REST_ELECTROCARDIO_RESULTS)

# EXERCISE_INDUCED_ANGINA -> UNKNOWN QUALITATIVE

dataset$EXERCISE_INDUCED_ANGINA <- as.character(dataset$EXERCISE_INDUCED_ANGINA)
dataset$EXERCISE_INDUCED_ANGINA[is.na(dataset$EXERCISE_INDUCED_ANGINA)] <- "unknown"
dataset$EXERCISE_INDUCED_ANGINA <- as.factor(dataset$EXERCISE_INDUCED_ANGINA)
dataset$EXERCISE_INDUCED_ANGINA <- droplevels(dataset$EXERCISE_INDUCED_ANGINA)
levels(dataset$EXERCISE_INDUCED_ANGINA)

# ST_SLOPE -> UNKNOWN QUALITATIVE (ALSO REMOVED A "0" VALUE, NOW IS AN UNKNOWN)

dataset$ST_SLOPE <- as.character(dataset$ST_SLOPE)
dataset$ST_SLOPE[dataset$ST_SLOPE == 0] <- "unknown"
dataset$ST_SLOPE[is.na(dataset$ST_SLOPE)] <- "unknown"
dataset$ST_SLOPE <- as.factor(dataset$ST_SLOPE)
dataset$ST_SLOPE <- droplevels(dataset$ST_SLOPE)
levels(dataset$ST_SLOPE)

# MAJOR_VESSELS -> UNKNOWN QUALITATIVE (ALSO REMOVED A A "9" VALUE, NOW IS AN UNKNOWN)

dataset$MAJOR_VESSELS <- as.character(dataset$MAJOR_VESSELS)
dataset$MAJOR_VESSELS[dataset$MAJOR_VESSELS == 9] <- "unknown"
dataset$MAJOR_VESSELS[is.na(dataset$MAJOR_VESSELS)] <- "unknown"
dataset$MAJOR_VESSELS <- as.factor(dataset$MAJOR_VESSELS)
dataset$MAJOR_VESSELS <- droplevels(dataset$MAJOR_VESSELS)
levels(dataset$MAJOR_VESSELS)

# THALIUM_STRESS_TEST_RESULT -> UNKNOWN QUALITATIVE (ALSO REMOVEDA A "1", "2", "4" and "5" VALUES, NOW ARE UNKNOWN)

dataset$THALIUM_STRESS_TEST_RESULT <- as.character(dataset$THALIUM_STRESS_TEST_RESULT)
dataset$THALIUM_STRESS_TEST_RESULT[dataset$THALIUM_STRESS_TEST_RESULT == "1"] <- "unknown"
dataset$THALIUM_STRESS_TEST_RESULT[dataset$THALIUM_STRESS_TEST_RESULT == "2"] <- "unknown"
dataset$THALIUM_STRESS_TEST_RESULT[dataset$THALIUM_STRESS_TEST_RESULT == "4"] <- "unknown"
dataset$THALIUM_STRESS_TEST_RESULT[dataset$THALIUM_STRESS_TEST_RESULT == "5"] <- "unknown"
dataset$THALIUM_STRESS_TEST_RESULT[is.na(dataset$THALIUM_STRESS_TEST_RESULT)] <- "unknown"
dataset$THALIUM_STRESS_TEST_RESULT <- as.factor(dataset$THALIUM_STRESS_TEST_RESULT)
dataset$THALIUM_STRESS_TEST_RESULT <- droplevels(dataset$THALIUM_STRESS_TEST_RESULT)
levels(dataset$THALIUM_STRESS_TEST_RESULT)

# EXERCISE_PROTOCOL -> UNKNOWN QUALITATIVE (!!!! WE STILL NEED TO FIX SOME VALUES !!!!)

dataset$EXERCISE_PROTOCOL <- as.character(dataset$EXERCISE_PROTOCOL)
dataset$EXERCISE_PROTOCOL[is.na(dataset$EXERCISE_PROTOCOL)] <- "unknown"
dataset$EXERCISE_PROTOCOL <- as.factor(dataset$EXERCISE_PROTOCOL)
dataset$EXERCISE_PROTOCOL <- droplevels(dataset$EXERCISE_PROTOCOL)
levels(dataset$EXERCISE_PROTOCOL)

####

dataset2 = dataset

saveRDS(dataset, "dataset2.rds")

####

rm(list = ls())
setwd("/home/raul/MD/Grau-MD-master/Entrega1/Datos")
dataset <- readRDS("dataset2.rds")

dataset$EXERCISE_DURATION_MINUTES <- as.numeric(dataset$EXERCISE_DURATION_MINUTES)
dataset$ST_DIFF_EXERCISE_VS_REST <- as.numeric(dataset$ST_DIFF_EXERCISE_VS_REST)


library(cluster)

# First, we use some variables without NAs to do a Hierarchical Clustering

variables <- c(1,2,3,6,7,10,12,13,14,15,16,18)

dissimMatrix <- daisy(dataset[,variables], metric = "gower", stand=TRUE)

distMatrix<-dissimMatrix^2

h1 <- hclust(distMatrix,method="ward.D2")

# We use a lot of clusters to maximize the amount of different values.

k<-50

c2 <- cutree(h1,k)

dataset["cluster"] <- c2

dataset2 = dataset

for (clust in c(1:50)){
  # REST_BLOOD_PRESSURE
  aux = mean(dataset$REST_BLOOD_PRESSURE[dataset$cluster == clust],na.rm=TRUE)
  dataset$REST_BLOOD_PRESSURE[is.na(dataset$REST_BLOOD_PRESSURE) & dataset$cluster == clust] <- aux
  # CHOLESTEROL
  aux = mean(dataset$CHOLESTEROL[dataset$cluster == clust],na.rm=TRUE)
  dataset$CHOLESTEROL[is.na(dataset$CHOLESTEROL) & dataset$cluster == clust] <- aux
  # MAX_HR
  aux = mean(dataset$MAX_HR[dataset$cluster == clust],na.rm=TRUE)
  dataset$MAX_HR[is.na(dataset$MAX_HR) & dataset$cluster == clust] <- aux
  # REST_HR
  aux = mean(dataset$REST_HR[dataset$cluster == clust],na.rm=TRUE)
  dataset$REST_HR[is.na(dataset$REST_HR) & dataset$cluster == clust] <- aux
  # ST_DIFF_EXERCISE_VS_REST
  aux = mean(dataset$ST_DIFF_EXERCISE_VS_REST[dataset$cluster == clust],na.rm=TRUE)
  dataset$ST_DIFF_EXERCISE_VS_REST[is.na(dataset$ST_DIFF_EXERCISE_VS_REST) & dataset$cluster == clust] <- aux
  # EXERCISE_DURATION_MINUTES
  aux = mean(dataset$EXERCISE_DURATION_MINUTES[dataset$cluster == clust],na.rm=TRUE)
  dataset$EXERCISE_DURATION_MINUTES[is.na(dataset$EXERCISE_DURATION_MINUTES) & dataset$cluster == clust] <- aux
}

summary(dataset)


# Encara hi han NaNs perquè els valors del cluster eren NaN. Així que hem d'eliminar els files que tenen algun NaN.
dataset3 <- dataset

dataset <- dataset[complete.cases(dataset), ]

summary(dataset)

# Ens quedem amb 846 files.

saveRDS(dataset, "dataset3.rds")
