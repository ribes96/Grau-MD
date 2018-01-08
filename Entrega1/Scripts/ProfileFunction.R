#CPG plots

source("../Scripts/profile3.R")
#CPG(iris, iris$Species, method= "", path="D:/karina/docencia/areferenciesPPT/9.Clustering/PracticaEnR/",  nrow=3, ncol=5)

#setwd("D:/karina/docencia/areferenciesPPT/0DadesPractiques/CREDSCO")
#dd <- read.csv("credscoClean.csv", sep=";");
#attach(dd)

active<-c(1:)


#createCPG(dd[,active], Tipo.trabajo)

#Fer gran la finestra del R
createCPG(dd[,active], Dictamen)

dades<-iris
attach(dades)
plotConditionalTable(dades[,1:2], Species)

#fer creixer la finestra de plots
#control - per fer menor el tipus de lletra en R
createCPG(dd[,active], as.factor(c2))

#falta jugar amb els marges