library(xlsx)
setwd("../Datos/")
dataset <- read.xlsx("Datos MD.xlsx", sheetIndex = 7)
View(dataset)
