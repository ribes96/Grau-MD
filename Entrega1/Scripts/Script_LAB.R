#rm(list = ls()) # Clear workspace
install.packages("xlsx", dep=T)
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
View(dataset)


dd <- dataset
dd <- dd[!is.na(dd[,"ID"])&!is.na(dd[,"AGE"])&!is.na(dd[,"REST_BLOOD_PRESSURE"])&!is.na(dd[,"CHOLESTEROL"])&!is.na(dd[,"MAX_HR"]),]
View(dd)

objects()
attributes(dd)

#
# VISUALISATION OF DATA
#
# PRINCIPAL COMPONENT ANALYSIS OF CONTINcUOUS VARIABLES, WITH Dictamen PROJECTED AS ILLUSTRATIVE
#

# CREATION OF THE DATA FRAME OF CONTINUOUS VARIABLES

attach(dd)
names(dd)


#set a list of numerical variables


dcon <- data.frame (ID,AGE,REST_BLOOD_PRESSURE,CHOLESTEROL,MAX_HR)



# PRINCIPAL COMPONENT ANALYSIS OF dcon

pc1 <- prcomp(dcon, scale=TRUE)
class(pc1)
attributes(pc1)

print(pc1)




# WHICH PERCENTAGE OF THE TOTAL INERTIA IS REPRESENTED IN SUBSPACES?

pc1$sdev
inerProj<- pc1$sdev^2 
inerProj
totalIner<- sum(inerProj)
totalIner
pinerEix<- 100*inerProj/totalIner
pinerEix
barplot(pinerEix)

#Cummulated Inertia in subspaces, from first principal component to the 11th dimension subspace
barplot(100*cumsum(pc1$sdev[1:dim(dcon)[2]]^2)/dim(dcon)[2])
percInerAccum<-100*cumsum(pc1$sdev[1:dim(dcon)[2]]^2)/dim(dcon)[2]
percInerAccum


# SELECTION OF THE SINGIFICNT DIMENSIONS (keep 80% of total inertia)

nd = 6

# STORAGE OF THE EIGENVALUES, EIGENVECTORS AND PROJECTIONS IN THE nd DIMENSIONS


Psi = pc1$x[,1:nd]

# STORAGE OF LABELS FOR INDIVIDUALS AND VARIABLES

iden = row.names(dcon)
etiq = names(dcon)
ze = rep(0,length(etiq)) # WE WILL NEED THIS VECTOR AFTERWARDS FOR THE GRAPHICS

# PLOT OF INDIVIDUALS

#select your axis
eje1<-1
eje2<-2

plot(Psi[,eje1],Psi[,eje2])
text(Psi[,eje1],Psi[,eje2],labels=iden, cex=0.5)
axis(side=1, pos= 0, labels = F, col="cyan")
axis(side=3, pos= 0, labels = F, col="cyan")
axis(side=2, pos= 0, labels = F, col="cyan")
axis(side=4, pos= 0, labels = F, col="cyan")

#library(rgl)
#plot3d(Psi[,1],Psi[,2],Psi[,3])

#Projection of variables

Phi = cor(dcon,Psi)

#select your axis

X<-Phi[,eje1]
Y<-Phi[,eje2]

plot(Psi[,eje1],Psi[,eje2],type="n")
axis(side=1, pos= 0, labels = F)
axis(side=3, pos= 0, labels = F)
axis(side=2, pos= 0, labels = F)
axis(side=4, pos= 0, labels = F)
arrows(ze, ze, X, Y, length = 0.07,col="blue")
text(X,Y,labels=etiq,col="darkblue", cex=0.7)


#zooms
plot(Psi[,eje1],Psi[,eje2],type="n",xlim=c(min(X,0),max(X,0)))
axis(side=1, pos= 0, labels = F)
axis(side=3, pos= 0, labels = F)
axis(side=2, pos= 0, labels = F)
axis(side=4, pos= 0, labels = F)
arrows(ze, ze, X, Y, length = 0.07,col="blue")
text(X,Y,labels=etiq,col="darkblue", cex=0.7)



#Now we project both cdgs of levels of a selected qualitative variable without
#representing the individual anymore

plot(Psi[,eje1],Psi[,eje2],type="n")
axis(side=1, pos= 0, labels = F, col="cyan")
axis(side=3, pos= 0, labels = F, col="cyan")
axis(side=2, pos= 0, labels = F, col="cyan")
axis(side=4, pos= 0, labels = F, col="cyan")

#select your qualitative variable
k<-1 #dictamen in credsco
varcat<-dd[,k]
fdic1 = tapply(Psi[,eje1],varcat,mean)
fdic2 = tapply(Psi[,eje2],varcat,mean) 

#points(fdic1,fdic2,pch=16,col="blue", labels=levels(varcat))
text(fdic1,fdic2,labels=levels(varcat),col="blue", cex=0.7)


#all qualitative together
plot(Psi[,eje1],Psi[,eje2],type="n")
axis(side=1, pos= 0, labels = F, col="cyan")
axis(side=3, pos= 0, labels = F, col="cyan")
axis(side=2, pos= 0, labels = F, col="cyan")
axis(side=4, pos= 0, labels = F, col="cyan")

#nominal qualitative variables

dcat<-c(1,3,6:7)
#divide categoricals in several graphs if joint representation saturates

#build a palette with as much colors as qualitative variables 

colors<-c("blue","red","green","orange","darkgreen")
#alternative
#colors<-rainbow(length(dcat))

c<-1
for(k in dcat){
  seguentColor<-colors[c]
  fdic1 = tapply(Psi[,eje1],dd[,k],mean)
  fdic2 = tapply(Psi[,eje2],dd[,k],mean) 
  
  text(fdic1,fdic2,labels=levels(dd[,k]),col=seguentColor, cex=0.6)
  c<-c+1
}
legend("bottomleft",names(dd)[dcat],pch=1,col=colors, cex=0.6)

#determine zoom level
#use the scale factor or not depending on the position of centroids
# ES UN FACTOR D'ESCALA PER DIBUIXAR LES FLETXES MES VISIBLES EN EL GRAFIC
#fm = round(max(abs(Psi[,1]))) 
fm=20

#scale the projected variables
X<-fm*U[,eje1]
Y<-fm*U[,eje2]

#represent numerical variables in background
plot(Psi[,eje1],Psi[,eje2],type="n",xlim=c(-1,1), ylim=c(-3,1))
#plot(X,Y,type="none",xlim=c(min(X,0),max(X,0)))
axis(side=1, pos= 0, labels = F, col="cyan")
axis(side=3, pos= 0, labels = F, col="cyan")
axis(side=2, pos= 0, labels = F, col="cyan")
axis(side=4, pos= 0, labels = F, col="cyan")

#add projections of numerical variables in background
arrows(ze, ze, X, Y, length = 0.07,col="lightgray")
text(X,Y,labels=etiq,col="gray", cex=0.7)

#add centroids
c<-1
for(k in dcat){
  seguentColor<-colors[c]
  
  fdic1 = tapply(Psi[,eje1],dd[,k],mean)
  fdic2 = tapply(Psi[,eje2],dd[,k],mean) 
  
  #points(fdic1,fdic2,pch=16,col=seguentColor, labels=levels(dd[,k]))
  text(fdic1,fdic2,labels=levels(dd[,k]),col=seguentColor, cex=0.6)
  c<-c+1
}
legend("bottomleft",names(dd)[dcat],pch=1,col=colors, cex=0.6)


#add ordinal qualitative variables. Ensure ordering is the correct

dordi<-c(8)


levels(dd[,dordi[1]])
#reorder modalities: when required
dd[,dordi[1]] <- factor(dd[,dordi[1]], ordered=TRUE,  levels= c("WorkingTypeUnknown","altres sit","temporal","fixe","autonom"))
levels(dd[,dordi[1]])

c<-1
for(k in dordi){
  seguentColor<-colors[col]
  fdic1 = tapply(Psi[,eje1],dd[,k],mean)
  fdic2 = tapply(Psi[,eje2],dd[,k],mean) 
  
  #points(fdic1,fdic2,pch=16,col=seguentColor, labels=levels(dd[,k]))
  #connect modalities of qualitative variables
  lines(fdic1,fdic2,pch=16,col=seguentColor)
  text(fdic1,fdic2,labels=levels(dd[,k]),col=seguentColor, cex=0.6)
  c<-c+1
  col<-col+1
}
legend("topleft",names(dd)[dordi],pch=1,col=colors[1:length(dordi)], cex=0.6)



# PROJECTION OF ILLUSTRATIVE qualitative variables on individuals' map
# PROJECCIÓ OF INDIVIDUALS DIFFERENTIATING THE Dictamen
# (we need a numeric Dictamen to color)

varcat=dd[,1]
plot(Psi[,1],Psi[,2],col=varcat)
axis(side=1, pos= 0, labels = F, col="darkgray")
axis(side=3, pos= 0, labels = F, col="darkgray")
axis(side=2, pos= 0, labels = F, col="darkgray")
axis(side=4, pos= 0, labels = F, col="darkgray")
legend("bottomleft",levels(varcat),pch=1,col=c(1,2), cex=0.6)


# Overproject THE CDG OF  LEVELS OF varcat
fdic1 = tapply(Psi[,1],varcat,mean)
fdic2 = tapply(Psi[,2],varcat,mean) 

text(fdic1,fdic2,labels=levels(varcat),col="cyan", cex=0.75)


