
 ####################
 # FINDING BEST CUT #
 # FOR HIERARCHICAL #
 ####################

rm(list = ls())
setwd("/home/raul/MD/Grau-MD-master/Entrega1/Datos")
dataset <- readRDS("dataset2.rds")

library(cluster)

variables <- c(1,2,3,6,7,10,12,13,14,15,16,18)

dissimMatrix <- daisy(dataset[,variables], metric = "gower", stand=TRUE)

distMatrix<-dissimMatrix^2

h1 <- hclust(distMatrix,method="ward.D2")

original <- dataset

for (cut in seq(10,400,10)){
  
  dataset <- original
  
  cat("CUT: ",cut, " \n")
  
  CT <- cutree(h1,cut)
  
  dataset["cluster"] <- CT
  
  for (clust in c(1:cut)){
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
  numNAs = max(colSums(is.na(dataset)))
  cat(" - Max number of NAs: ", numNAs, " \n")
}

# We think that the best cut is 100

dataset <- original

bestCut <- 100

CT <- cutree(h1,bestCut)

dataset["cluster"] <- CT

for (clust in c(1:cut)){
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

dataset$cluster <- as.factor(dataset$cluster)

# Encara hi han NaNs perquè els valors del cluster eren NaN.
# Així que hem d'eliminar els files que tenen algun NaN.

# Mirem quins són els clusters amb valors nulls

summary(dataset)

badClusters = unique(dataset$cluster[is.na(dataset$EXERCISE_DURATION_MINUTES)])

# Fem un dataset per mirar qué tenen d'especials aquests casos i els eliminem

removed <- dataset[dataset$cluster %in% badClusters, ]

dataset <- dataset[complete.cases(dataset), ]

dataset2 <- dataset[ , !(names(dataset) == "cluster")]

saveRDS(dataset,"dataset3.rds")
saveRDS(removed,"removed.rds")
