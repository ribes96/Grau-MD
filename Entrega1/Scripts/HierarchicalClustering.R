setwd("/Users/alcasser/Desktop/FIB/Grau-MD/Entrega1/Datos")
dd <- readRDS("dataset3.rds")
names(dd)
dim(dd)
summary(dd)

attach(dd)

#set a list of numerical variables
names(dd)

#euclidean distance with numerical variables.
dcon<-data.frame (AGE, REST_BLOOD_PRESSURE, CHOLESTEROL, MAX_HR, REST_HR, ST_DIFF_EXERCISE_VS_REST, EXERCISE_DURATION_MINUTES)

# which(names(dd)=="AGE") useful to know the column index of an attribute
d<-dist(dcon[1:7,])

#hierarchical clustering

#move to Gower mixed distance to deal 
#simoultaneously with numerical and qualitative data

library(cluster)

#dissimilarity matrix
#do not include in actives the identifier variables nor the potential response variable

actives<-c(1, 3:20)
dissimMatrix <- daisy(dd[,actives], metric = "gower", stand=TRUE)

distMatrix<-dissimMatrix^2

h1 <- hclust(distMatrix,method="ward.D2")  # NOTICE THE COST
#versions noves "ward.D" i abans de plot: par(mar=rep(2,4)) si se quejara de los margenes del plot

plot(h1)

# LET'S CUT AT 3 GROUPS
k<-3

c1 <- cutree(h1,k)

#class sizes 
table(c1)


#LET'S CUT AT 4 GROUPS

k<-4

c2 <- cutree(h1,k)

#class sizes 
table(c2)
#comparing with other partitions
table(c1,c2)


# LETS SEE THE QUALITY OF THE HIERARCHICAL PARTITION

cdg <- aggregate(as.data.frame(dcon),list(c2),mean)
cdg

plot(cdg[,1], cdg[,7])

# LETS SEE THE PARTITION VISUALLY

plot(EXERCISE_DURATION_MINUTES,CHOLESTEROL,col=c2,main="Clustering of heart disease data in 3 classes")
legend("topright",c("class1","class2","class3","class4"),pch=1,col=c(1:k))

plot(BLOOD_SUGAR,CHOLESTEROL,col=c2,main="Clustering of heart disease data in 3 classes")
legend("topright",c("class1","class2","class3","class4"),pch=1,col=c(1:k))

pairs(dcon[,1:7], col=c2)


names(dd)

# Boxplots
#rest blood pressure
boxplot(dd[,4]~c2, horizontal=TRUE)

#cholesterol
boxplot(dd[,5]~c2, horizontal=TRUE)

#max hr
boxplot(dd[,8]~c2, horizontal=TRUE)

#rest hr
boxplot(dd[,9]~c2, horizontal=TRUE)

#st diff exercis vs rest
boxplot(dd[,11]~c2, horizontal=TRUE)

#exercise duration minutes
boxplot(dd[,17]~c2, horizontal=TRUE)

# -----

pairs(dcon[,1:7], col=c2)


###########
# K-MEANS #
###########


library(cluster)
#install.packages('fpc')
library(fpc)

# KMEANS WITH 2 CLUSTERS

k1 <- kmeans(dcon, centers=2)
names(dcon)
print(k1)

attributes(k1)

k1$size

k1$withinss

k1$centers

plotcluster(dcon, k1$cluster)

# LETS COMPUTE THE DECOMPOSITION OF INERTIA

Bss <- sum(rowSums(k1$centers^2)*k1$size)
Bss
Wss <- sum(k1$withinss)
Wss
Tss <- k1$totss
Tss

Bss+Wss

Ib1 <- 100*Bss/(Bss+Wss)
Ib1

# KMEANS WITH 3 CLUSTERS

k2 <- kmeans(dcon, centers=3)
names(dcon)
print(k2)

k2$size

k2$withinss

k2$centers

plotcluster(dcon, k2$cluster)

# LETS COMPUTE THE DECOMPOSITION OF INERTIA

Bss <- sum(rowSums(k1$centers^2)*k2$size)
Bss
Wss <- sum(k2$withinss)
Wss
Tss <- k2$totss
Tss

Bss+Wss

Ib2 <- 100*Bss/(Bss+Wss)
Ib2
Ib1

# KMEANS WITH 4 CLUSTERS

k3 <- kmeans(dcon, centers=4)
names(dcon)
print(k3)

k3$size

k3$withinss

k3$centers

plotcluster(dcon, k3$cluster)

# LETS COMPUTE THE DECOMPOSITION OF INERTIA

Bss <- sum(rowSums(k3$centers^2)*k3$size)
Bss
Wss <- sum(k3$withinss)
Wss
Tss <- k3$totss
Tss

Bss+Wss

Ib3 <- 100*Bss/(Bss+Wss)
Ib2
Ib3



