#rm(list = ls()) # Clear workspace
#install.packages("xlsx", dep=T)
#install.packages("ref", dep=T)
library(xlsx)
library(ref)
setwd("../Datos")

# Load Workspace including Dataset
load("Workspace.RData")
raw_names <- c("ID", "AGE", "SEX", "CP", "TRESTBPS", "CHOL", "FBS", "RESTECG", "THALACH", "THALREST", "EXANG", "OLDPEAK", "SLOPE", "CA", "THAL", "SMOKE", "CIGS", "YEARS", "NUM", "PROTO", "THALDUR")

# Read from XLSX (commented because it is already in the workspace)
#dataset <- read.xlsx("Datos MD.xlsx", sheetIndex = 7, colIndex=seq(3,78,1), rowIndex=seq(1,900,1))[,raw_names]

# Fix NA
dataset[dataset == -9] <- NA

# Change column names
names <- c("ID", "AGE", "SEX", "CHEST_PAIN", "REST_BLOOD_PRESSURE", "CHOLESTEROL", "BLOOD_SUGAR", "REST_ELECTROCARDIO_RESULTS", "MAX_HR", "REST_HR", "EXERCISE_INDUCED_ANGINA", "ST_DIFF_EXERCISE_VS_REST", "ST_SLOPE", "MAJOR_VESSELS", "THALIUM_STRESS_TEST_RESULT", "SMOKE", "CIGARETTES", "SMOKING_YEARS", "DISEASE_STATUS", "EXERCISE_PROTOCOL", "EXERCISE_DURATION_MINUTES")
colnames(dataset) <- names()

dataset_ref <- refdata(dataset)
dataset <- function() {
  derefdata(dataset_ref)
}

hungarian <- dataset_ref[seq(1,294,1), , ref=T]
longbeach <- dataset_ref[seq(295,494,1), , ref=T]
switzerland <- dataset_ref[seq(495,617,1), , ref=T]
cleveland <- dataset_ref[seq(618,899,1), , ref=T]

#hungarian[1,2, ref=T] <- 20 # Edit with reference on hungarian and dataset

# Whole Dataset (no refresh)
View(dataset())

# Partial Dataset (no refresh)
View(hungarian[])
View(longbeach[])
View(switzerland[])
View(cleveland[])

# Summary
summary(dataset())

# Total NAs
sum(is.na(dataset()))
