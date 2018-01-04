
 ##################
 # ALL PREPROCESS #
 ##################

# Set the environment

rm(list = ls()) # Clear workspace
setwd("/home/raul/MD/Grau-MD-master/Entrega1/Datos")
dataset <- readRDS("original.rds")
# Set NAs
dataset[dataset == -9] <- NA

# Change column names
names <- c("AGE", "SEX", "CHEST_PAIN", "REST_BLOOD_PRESSURE", "CHOLESTEROL", "BLOOD_SUGAR", "REST_ELECTROCARDIO_RESULTS", "MAX_HR", "REST_HR", "EXERCISE_INDUCED_ANGINA", "ST_DIFF_EXERCISE_VS_REST", "ST_SLOPE", "MAJOR_VESSELS", "THALIUM_STRESS_TEST_RESULT", "SMOKE", "CIGARETTES", "SMOKING_YEARS", "DISEASE_STATUS", "EXERCISE_PROTOCOL", "EXERCISE_DURATION_MINUTES")
colnames(dataset) <- names

# Subsets
hungarian <- dataset[seq(1,294,1),]
longbeach <- dataset[seq(295,494,1),]
switzerland <- dataset[seq(495,617,1),]
cleveland <- dataset[seq(618,899,1),]

# Use this method after changes on subsets to refresh dataset accordingly
sync <- function() {
  dataset <<- rbind(hungarian, longbeach, switzerland, cleveland)
}

# -----
# Set as a factor qualitative variables and also set as a factor internally.

# SEX is qualitative
# Is better work with specific type in order to avoid possible errors.
dataset$SEX <- as.character(dataset$SEX)
dataset$SEX[dataset$SEX == "1"] <- "M"
dataset$SEX[dataset$SEX == "0"] <- "F"
dataset$SEX <- as.factor(dataset$SEX)

# CHEST_PAIN is qualitative
dataset$CHEST_PAIN <- as.character(dataset$CHEST_PAIN)
dataset$CHEST_PAIN[dataset$CHEST_PAIN == "1"] <- "typical_angina"
dataset$CHEST_PAIN[dataset$CHEST_PAIN == "2"] <- "atypical_angina"
dataset$CHEST_PAIN[dataset$CHEST_PAIN == "3"] <- "non-anginal_pain"
dataset$CHEST_PAIN[dataset$CHEST_PAIN == "4"] <- "asymptomatic"
dataset$CHEST_PAIN <- as.factor(dataset$CHEST_PAIN)

# BLOOD_SUGAR is qualitative
dataset$BLOOD_SUGAR <- as.character(dataset$BLOOD_SUGAR)
dataset$BLOOD_SUGAR[dataset$BLOOD_SUGAR == "1"] <- "yes"
dataset$BLOOD_SUGAR[dataset$BLOOD_SUGAR == "0"] <- "no"
dataset$BLOOD_SUGAR <- as.factor(dataset$BLOOD_SUGAR)

# REST_ELECTROCARDIO_RESULTS is qualitative
dataset$REST_ELECTROCARDIO_RESULTS <- as.character(dataset$REST_ELECTROCARDIO_RESULTS)
dataset$REST_ELECTROCARDIO_RESULTS[dataset$REST_ELECTROCARDIO_RESULTS == "0"] <- "normal"
dataset$REST_ELECTROCARDIO_RESULTS[dataset$REST_ELECTROCARDIO_RESULTS == "1"] <- "st-t_wave_abnormality"
dataset$REST_ELECTROCARDIO_RESULTS[dataset$REST_ELECTROCARDIO_RESULTS == "2"] <- "left_ventricular_hypertrophy"
dataset$REST_ELECTROCARDIO_RESULTS <- as.factor(dataset$REST_ELECTROCARDIO_RESULTS)

# EXERCISE_INDUCED_ANGINA is qualitative
dataset$EXERCISE_INDUCED_ANGINA <- as.character(dataset$EXERCISE_INDUCED_ANGINA)
dataset$EXERCISE_INDUCED_ANGINA[dataset$EXERCISE_INDUCED_ANGINA == "1"] <- "yes"
dataset$EXERCISE_INDUCED_ANGINA[dataset$EXERCISE_INDUCED_ANGINA == "0"] <- "no"
dataset$EXERCISE_INDUCED_ANGINA <- as.factor(dataset$EXERCISE_INDUCED_ANGINA)

# ST_SLOPE is qualitative
dataset$ST_SLOPE <- as.character(dataset$ST_SLOPE)
dataset$ST_SLOPE[dataset$ST_SLOPE == "1"] <- "upsloping"
dataset$ST_SLOPE[dataset$ST_SLOPE == "2"] <- "flat"
dataset$ST_SLOPE[dataset$ST_SLOPE == "3"] <- "downsloping"
dataset$ST_SLOPE <- as.factor(dataset$ST_SLOPE)

# MAJOR_VESSELS is qualitative
dataset$MAJOR_VESSELS <- as.character(dataset$MAJOR_VESSELS)
dataset$MAJOR_VESSELS <- as.factor(dataset$MAJOR_VESSELS)

# THALIUM_STRESS_TEST_RESULT is qualitative
dataset$THALIUM_STRESS_TEST_RESULT <- as.character(dataset$THALIUM_STRESS_TEST_RESULT)
dataset$THALIUM_STRESS_TEST_RESULT[dataset$THALIUM_STRESS_TEST_RESULT == "3"] <- "normal"
dataset$THALIUM_STRESS_TEST_RESULT[dataset$THALIUM_STRESS_TEST_RESULT == "6"] <- "fixed_defect"
dataset$THALIUM_STRESS_TEST_RESULT[dataset$THALIUM_STRESS_TEST_RESULT == "7"] <- "reversable_defect"
dataset$THALIUM_STRESS_TEST_RESULT <- as.factor(dataset$THALIUM_STRESS_TEST_RESULT)

# SMOKE is qualitative
dataset$SMOKE <- as.character(dataset$SMOKE)
dataset$SMOKE[dataset$SMOKE == "1"] <- "yes"
dataset$SMOKE[dataset$SMOKE == "0"] <- "no"
dataset$SMOKE <- as.factor(dataset$SMOKE)

# DISEASE_STATUS is qualitative
dataset$DISEASE_STATUS <- as.character(dataset$DISEASE_STATUS)
dataset$DISEASE_STATUS[dataset$DISEASE_STATUS == "0"] <- "less_than_fifthy_percent_diameter_narrowing"
dataset$DISEASE_STATUS[dataset$DISEASE_STATUS == "1"] <- "greater_than_fifthy_percent_diameter_narrowing"
dataset$DISEASE_STATUS <- as.factor(dataset$DISEASE_STATUS)

# EXERCISE_PROTOCOL is qualitative
dataset$EXERCISE_PROTOCOL <- as.character(dataset$EXERCISE_PROTOCOL)
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "1"] <- "Bruce"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "2"] <- "Kottus"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "3"] <- "McHenry"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "4"] <- "Fast_Balke"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "5"] <- "Balke"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "6"] <- "Noughton"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "7"] <- "Bike_150"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "8"] <- "Bike_125"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "9"] <- "Bike_100"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "10"] <- "Bike_75"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "11"] <- "Bike_50"
dataset$EXERCISE_PROTOCOL[dataset$EXERCISE_PROTOCOL == "12"] <- "Arm_Ergometer"
dataset$EXERCISE_PROTOCOL <- as.factor(dataset$EXERCISE_PROTOCOL)

# -----
#Cigarettes preprocessing (We are not a tobacco company)
didSmoke <- function(smoke, cigs, years) {
  if (!is.na(smoke) || !is.na(cigs) || !is.na(years)) {
    if (!is.na(smoke) && smoke == "yes" || !is.na(cigs) && cigs > 0 || !is.na(years) && years > 0) {
      "yes"
    } else {
      "no"
    }
  } else {
    NA 
  }
}

dataset$SMOKED <- Map(didSmoke, dataset$SMOKE, dataset$CIGARETTES, dataset$SMOKING_YEARS)
dataset$SMOKE <- NULL
dataset$SMOKING_YEARS <- NULL
dataset$CIGARETTES <- NULL

#sync()
# -----


######

saveRDS(dataset, "dataset.RDS")

######

 #####################
 # TIME TO FIX THE   #
 # REMAINING DATASET #
 #####################

# Set the environment

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

# FIX SOME NUMERICAL VARIABLES
dataset$EXERCISE_DURATION_MINUTES <- as.character(dataset$EXERCISE_DURATION_MINUTES)
dataset$EXERCISE_DURATION_MINUTES <- as.numeric(dataset$EXERCISE_DURATION_MINUTES)
dataset$ST_DIFF_EXERCISE_VS_REST <- as.character(dataset$ST_DIFF_EXERCISE_VS_REST)
dataset$ST_DIFF_EXERCISE_VS_REST <- as.numeric(dataset$ST_DIFF_EXERCISE_VS_REST)

# REPLACE SOME 0 VALUES AS NA

dataset$CHOLESTEROL[dataset$CHOLESTEROL == 0] <- NA
dataset$REST_BLOOD_PRESSURE[dataset$REST_BLOOD_PRESSURE == 0] <- NA

# Insert from which Hospital each row comes from

x <- rep(1,899)
x[1:294] <- 'HUNGARIAN'
x[295:494] <- 'LONGBEACH'
x[495:617] <- 'SWITZERLAND'
x[618:899] <- 'CLEVELAND'
dataset$HOSPITAL <- x
dataset$HOSPITAL <- as.character(dataset$HOSPITAL)
dataset$HOSPITAL <- as.factor(dataset$HOSPITAL)
dataset$HOSPITAL <- droplevels(dataset$HOSPITAL)
levels(dataset$HOSPITAL)

####

dataset2 = dataset

saveRDS(dataset, "dataset2.rds")

####

# We execute the Script "GettingBestCut.R" in order to clean the NA values.

source('~/MD/Grau-MD-master/Entrega1/Scripts/GettingBestCut.R')

