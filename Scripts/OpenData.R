# rm(list = ls()) # Clear workspace
# install.packages("rJava")
# Diego: IF YOU HAVE WINDOWS, UNCOMMENT THE NEXT LINE. For Windows users, JAVA_HOME have to be set with the next command.
# Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_151')
library(xlsx)
setwd("../Datos")

# Load Workspace including Dataset
load("Workspace.RData")
raw_names <- c("AGE", "SEX", "CP", "TRESTBPS", "CHOL", "FBS", "RESTECG", "THALACH", "THALREST", "EXANG", "OLDPEAK", "SLOPE", "CA", "THAL", "SMOKE", "CIGS", "YEARS", "NUM", "PROTO", "THALDUR")

# Read from XLSX (commented because it is already in the workspace)
dataset <- read.xlsx("Datos MD.xlsx", sheetIndex = 7, colIndex=seq(3,78,1), rowIndex=seq(1,900,1))[,raw_names]

# Fix NA
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

# Whole Dataset
View(dataset)

# Partial Dataset
View(hungarian)
View(longbeach)
View(switzerland)
View(cleveland)

# Summary
summary(dataset)

# Total NAs
sum(is.na(dataset))
