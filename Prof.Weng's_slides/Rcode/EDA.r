################
## Load Data ##
###############
rm(list = ls())
NIPPV <- read.table("NIPPV.txt")
colnames(NIPPV) <- c("Sex","Age","Duration","Breathing Rate","PH","PO2","PCO2","Plasma-albumin","Curative effect")
head(NIPPV)

#########################
## Five Number Summary ##
#########################
# This gives the minimum, 25th percentile, median, 75th percentile, maximum 
# of the data and is quick check on the distribution of the data.

summary(NIPPV)

########################
## Correlation Matrix ##
########################
library(corrplot)
nippv.cor <- cor(NIPPV)
round(nippv.cor, digits = 2)
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(nippv.cor, method="shade", shade.col=NA, tl.col="black", tl.srt=45,
         col=col(200), addCoef.col="black", addcolorlabel="no", order="AOE")
#############
## Boxplot ##
#############
par(mfrow=c(2,4))
boxplot(NIPPV$Age, col = "blue",xlab="Age")
boxplot(NIPPV$Duration, col = "blue",xlab="Duration")
boxplot(NIPPV$`Breathing Rate`, col = "blue",xlab="Breathing Rate")
boxplot(NIPPV$PH, col = "blue",xlab="PH")
boxplot(NIPPV$PO2, col = "blue",xlab="PO2")
boxplot(NIPPV$PCO2, col = "blue",xlab="PCO2")
boxplot(NIPPV$`Plasma-albumin`, col = "blue",xlab="Plasma-albumin")
PH.new <- NIPPV$PH[NIPPV$PH <=15]
boxplot(PH.new, col = "blue",xlab="PH revised")
# Boxplots are a visual representation of the five-number summary plus a bit more information. 
# In particular, boxplots commonly plot outliers that go beyond the bulk of the data.
library(dplyr)
sex <- NIPPV$Sex
sex[sex == 0] <-"Female"
sex[sex == 1] <- "Male"
effect <- NIPPV$`Curative effect`
effect[effect == 0] <- "N"
effect[effect == 1] <- "Y"

par(mfrow=c(1,2))
table(sex) %>% barplot(col = "wheat",main="Sex")
table(effect) %>% barplot(col = "lavender",main="Curative effect")
