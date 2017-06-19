rm(list = ls())
source("test/cv_test/cvlogit.R")
load("test/cv_test/Leukemia.Rdata")
x <- as.matrix(Leukemia$x)
y <- as.matrix(Leukemia$y)
p <- ncol(x)
iteration <- 20 * p
r <- cvlogit(x,y,nlambda=100,K=10,method="UB",iteration)
save(r,file="results/cv_leu.Rdata")
# -- plot --
library(ggplot2)
data <- data.frame(log.lambda=log(r$nlambda),error=r$MSEP,sig=r$nsigma)
index<-which.min(r$MSEP)
std <- r$nsigma[index]
lb <- min(r$MSEP)-std
ub <- min(r$MSEP)+std
pars_index <- min(which(r$MSEP > lb & r$MSEP < ub))
pars_lambda <- r$nlambda[pars_index]
ggplot(data, aes(log.lambda, y=error)) +
  geom_line(aes(group=2)) +
  geom_point(size=1) +
  geom_errorbar(aes(ymin=error-sig, ymax=error+sig), width=0.08)+
  labs(x = "log(Lambda)", y = "Misclassification Error ")+
  geom_vline(xintercept=log(r$best_lambda),linetype="dashed", size=0.3)+
  geom_vline(xintercept=log(pars_lambda),linetype="dashed", size=0.3)

#---- SAheart
rm(list = ls())
source("R/cvlogit_new.R")
library(ElemStatLearn)
library(glmnet)
data(SAheart)
SA <- SAheart
rm(SAheart)
SA$famhist <- as.numeric(SA$famhist)
x <- as.matrix(SA[-c(5,10)])
x <- scale(x)
y <- as.matrix(SA$chd)
cvfit<-cv.glmnet(x,y,family=c("binomial"),type.measure = "class")
r <- cvlogit_new(x,y,nlambda=100,K=10)
library(ggplot2)
data <- data.frame(log.lambda=log(r$nlambda),error=r$MSEP,sig=r$nsigma)
index<-which.min(r$MSEP)
std <- r$nsigma[index]
lb <- min(r$MSEP)-std
ub <- min(r$MSEP)+std
pars_index <- min(which(r$MSEP > lb & r$MSEP < ub))
pars_lambda <- r$nlambda[pars_index]
ggplot(data, aes(log.lambda, y=error)) +
  geom_line(aes(group=2)) +
  geom_point(size=1) +
  geom_errorbar(aes(ymin=error-sig, ymax=error+sig), width=0.08)+
  labs(x = "log(Lambda)", y = "Misclassification Error ")+
  geom_vline(xintercept=log(r$best_lambda),linetype="dashed", size=0.3)+
  geom_vline(xintercept=log(pars_lambda),linetype="dashed", size=0.3)

plot(cvfit)
cvfit$lambda.min

# -- simulated
# simialar mean ; 2 times of glmnet's 1se
load("test/sim_test/sim_n1000p100rho0.Rdata")
x <- x[1:500,4:10];
y <- y[1:500,,drop=F]
source("R/cvlogit_new.R")
r <- cvlogit_new(x,y,nlambda=100,K=10)
library(ggplot2)
data <- data.frame(log.lambda=log(r$nlambda),error=r$MSEP,sig=r$nsigma)
index<-which.min(r$MSEP)
std <- r$nsigma[index]
lb <- min(r$MSEP)-std
ub <- min(r$MSEP)+std
pars_index <- min(which(r$MSEP > lb & r$MSEP < ub))
pars_lambda <- r$nlambda[pars_index]
ggplot(data, aes(log.lambda, y=error)) +
  geom_line(aes(group=2)) +
  geom_point(size=1) +
  geom_errorbar(aes(ymin=error-sig, ymax=error+sig), width=0.08)+
  labs(x = "log(Lambda)", y = "Misclassification Error ")+
  geom_vline(xintercept=log(r$best_lambda),linetype="dashed", size=0.3)+
  geom_vline(xintercept=log(pars_lambda),linetype="dashed", size=0.3)

# --- nippv ---
rm(list=ls())
nippv <- read.csv("/Users/Roth/Desktop/logit/test/cv_test/nippv.csv")
y <- as.matrix(nippv[,9])
x <- as.matrix(nippv[,-c(9)])
n <- nrow(x) ; p <- ncol(x)
x <- scale(x)*sqrt(n)/sqrt(n - 1)
source("R/cvlogit_new.R")
r <- cvlogit_new(x,y,nlambda=100,K=10)
library(glmnet)
cvfit<-cv.glmnet(x,y,family=c("binomial"),type.measure = "class",nlambda=150)
plot(cvfit)
save(r,file="/Users/Roth/Desktop/logit/test/cv_test/nippv_results.Rdata")
