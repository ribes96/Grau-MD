#rm(list = ls()) # Clear workspace
#install.packages("xlsx", dep=T)
library(xlsx)
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
