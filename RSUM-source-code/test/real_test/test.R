#--------------------test1.1 Leku single----------------------------------------
rm(list = ls())
library(glmnet)
library(ggplot2)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
lambda <- 0.02397336
p <- ncol(x)
iteration <- 10*p
r1<-paulforlogit(x,y,lambda,s=1,iteration)
r2<-ubforlogit(x,y,lambda,iteration)
r3<-ubforlogit_random(x,y,lambda,iteration)
r4<-aubforlogit(x,y,lambda,iteration)

data.frame(r1$hatbeta,r2$hatbeta,r3$hatbeta,r4$hatbeta)
data.frame(r1$object_value,r2$object_value,r3$object_value,r4$object_value)
data.frame(r1$iteration,r2$iteration,r3$iteration,r4$iteration)
data.frame(r1$time,r2$time,r3$time,r4$time)
 
t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3$fvalue,r4$fvalue)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
p_mont <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()
p_mont
save(r1,r2,r3,r4,file ="results/leu_single_run.Rdata")
# -------------plot
library(ggplot2)
library(scales)
load("results/leu_single_run.Rdata")
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
p <- ncol(x)
iteration <- 10 * p
t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3$fvalue,r4$fvalue)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))

# --------------------test1.2 Leku MC-------------------------------------------
rm(list = ls())
library(glmnet)
library(ggplot2)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
load("results/leu_single_run.Rdata")
rm(r3,r4)
lambda <- 0.02397336
p <- ncol(x)
iteration <- 10 * p
r3_fval <- rep(0,iteration+1)
r4_fval <- rep(0,iteration+1)
for (i in seq_len(50)){
  r3_fval <- ubforlogit_random(x,y,lambda,iteration)$fvalue + r3_fval
}
for (i in seq_len(50)){
  r4_fval <- aubforlogit(x,y,lambda,iteration)$fvalue + r4_fval
}

t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3_fval/50,r4_fval/50)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
p_mont <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line(alpha=0.9)
p_mont
save(r1,r2,r3_fval,r4_fval,file="results/leu_50_run.Rdata")
# ------------ plot
load("results/leu_50_run.Rdata")
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
p <- ncol(x)
iteration <- 10 * p
t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3_fval/50,r4_fval/50)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))

# --------------------test1.3 Leku MC lambda------------------------------------
## 1e-1
rm(list = ls())
library(ggplot2)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
lambda <- 1e-1
p <- ncol(x)
iteration <- 20 * p
r1<-paulforlogit(x,y,lambda,s=1,iteration)
r2<-ubforlogit(x,y,lambda,iteration)
r3_fval <- rep(0,iteration+1)
r4_fval <- rep(0,iteration+1)
numofmc <- 10 
for (i in seq_len(numofmc)){
  r3_fval <- ubforlogit_random(x,y,lambda,iteration)$fvalue + r3_fval
}
for (i in seq_len(numofmc)){
  r4_fval <- aubforlogit(x,y,lambda,iteration)$fvalue + r4_fval
}

t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3_fval/numofmc,r4_fval/numofmc)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
save(r1,r2,r3_fval,r4_fval,data,file="results/leu_1e-1_10run.Rdata")
## 1e-2
rm(list = ls())
library(ggplot2)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
lambda <- 1e-2
p <- ncol(x)
iteration <- 20 * p
r1<-paulforlogit(x,y,lambda,s=1,iteration)
r2<-ubforlogit(x,y,lambda,iteration)
r3_fval <- rep(0,iteration+1)
r4_fval <- rep(0,iteration+1)
numofmc <- 10 
for (i in seq_len(numofmc)){
  r3_fval <- ubforlogit_random(x,y,lambda,iteration)$fvalue + r3_fval
}
for (i in seq_len(numofmc)){
  r4_fval <- aubforlogit(x,y,lambda,iteration)$fvalue + r4_fval
}

t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3_fval/numofmc,r4_fval/numofmc)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
save(r1,r2,r3_fval,r4_fval,data,file="results/leu_1e-2_10run.Rdata")
## 1e-3
rm(list = ls())
library(ggplot2)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
lambda <- 1e-3
p <- ncol(x)
iteration <- 20 * p
r1<-paulforlogit(x,y,lambda,s=1,iteration)
r2<-ubforlogit(x,y,lambda,iteration)
r3_fval <- rep(0,iteration+1)
r4_fval <- rep(0,iteration+1)
numofmc <- 10 
for (i in seq_len(numofmc)){
  r3_fval <- ubforlogit_random(x,y,lambda,iteration)$fvalue + r3_fval
}
for (i in seq_len(numofmc)){
  r4_fval <- aubforlogit(x,y,lambda,iteration)$fvalue + r4_fval
}

t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3_fval/numofmc,r4_fval/numofmc)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
save(r1,r2,r3_fval,r4_fval,data,file="results/leu_1e-3_10run.Rdata")
## 1e-4
rm(list = ls())
library(ggplot2)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
lambda <- 1e-4
p <- ncol(x)
iteration <- 20 * p
r1<-paulforlogit(x,y,lambda,s=1,iteration)
r2<-ubforlogit(x,y,lambda,iteration)
r3_fval <- rep(0,iteration+1)
r4_fval <- rep(0,iteration+1)
numofmc <- 10 
for (i in seq_len(numofmc)){
  r3_fval <- ubforlogit_random(x,y,lambda,iteration)$fvalue + r3_fval
}
for (i in seq_len(numofmc)){
  r4_fval <- aubforlogit(x,y,lambda,iteration)$fvalue + r4_fval
}

t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3_fval/numofmc,r4_fval/numofmc)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
save(r1,r2,r3_fval,r4_fval,data,file="results/leu_1e-4_10run.Rdata")
## 1e-5
rm(list = ls())
library(ggplot2)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
lambda <- 1e-5
p <- ncol(x)
iteration <- 20 * p
r1<-paulforlogit(x,y,lambda,s=1,iteration)
r2<-ubforlogit(x,y,lambda,iteration)
r3_fval <- rep(0,iteration+1)
r4_fval <- rep(0,iteration+1)
numofmc <- 10 
for (i in seq_len(numofmc)){
  r3_fval <- ubforlogit_random(x,y,lambda,iteration)$fvalue + r3_fval
}
for (i in seq_len(numofmc)){
  r4_fval <- aubforlogit(x,y,lambda,iteration)$fvalue + r4_fval
}

t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3_fval/numofmc,r4_fval/numofmc)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
save(r1,r2,r3_fval,r4_fval,data,file="results/leu_1e-5_10run.Rdata")
## 1e-6
rm(list = ls())
library(ggplot2)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
lambda <- 1e-6
p <- ncol(x)
iteration <- 20 * p
r1<-paulforlogit(x,y,lambda,s=1,iteration)
r2<-ubforlogit(x,y,lambda,iteration)
r3_fval <- rep(0,iteration+1)
r4_fval <- rep(0,iteration+1)
numofmc <- 10 
for (i in seq_len(numofmc)){
  r3_fval <- ubforlogit_random(x,y,lambda,iteration)$fvalue + r3_fval
}
for (i in seq_len(numofmc)){
  r4_fval <- aubforlogit(x,y,lambda,iteration)$fvalue + r4_fval
}

t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3_fval/numofmc,r4_fval/numofmc)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
save(r1,r2,r3_fval,r4_fval,data,file="results/leu_1e-6_10run.Rdata")

#--------------------test2.1 Ad single----------------------------------------
rm(list = ls())
library(glmnet)
library(ggplot2)
load("test/real_test/InternetAd.RData")
x<-as.matrix(InternetAd$x)
y<-as.matrix(InternetAd$y)
source("test/real_test/paulforlogit.R")
source("test/real_test/ubforlogit.R")
source("test/real_test/ubforlogit_random.R")
source("test/real_test/aubforlogit.R")
#cvfit<-cv.glmnet(x,y,family=c("binomial"),type.measure = "class")
#lambda<-cvfit$lambda.min
lambda <- 0.0019
p <- ncol(x)
iteration <- 10*p
r1<-paulforlogit(x,y,lambda,s=1,iteration)
r2<-ubforlogit(x,y,lambda,iteration)
r3<-ubforlogit_random(x,y,lambda,iteration)
r4<-aubforlogit(x,y,lambda,iteration)
data.frame(r1$hatbeta,r2$hatbeta,r3$hatbeta,r4$hatbeta)
data.frame(r1$object_value,r2$object_value,r3$object_value,r4$object_value)
data.frame(r1$iteration,r2$iteration,r3$iteration,r4$iteration)
data.frame(r1$time,r2$time,r3$time,r4$time)

t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3$fvalue,r4$fvalue)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
p_mont <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()
p_mont
save(r1,r2,r3,r4,file ="results/ad_single_run.Rdata")
# -------------plot
library(ggplot2)
library(scales)
load("results/ad_single_run.Rdata")
load("test/real_test/InternetAd.RData")
x<-as.matrix(InternetAd$x)
p <- ncol(x)
iteration <- 10 * p
t <- rep(seq_len(iteration+1),4)
obj_val <- c(r1$fvalue,r2$fvalue,r3$fvalue,r4$fvalue)
label <- c(rep("Paul",iteration+1),rep("UB",iteration+1),
           rep("RUB",iteration+1),rep("APCG",iteration+1))
data <- data.frame(t,obj_val,label)
ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))
# --------------------test3.1 CV LEUKIMIA---------------------------------------
rm(list = ls())
library(glmnet)
source("test/real_test/cvlogit.R")
data(BinomialExample)
#cvfit<-cv.glmnet(x,y,family=c("binomial"),type.measure = "class")
#plot(cvfit)
#min(cvfit$cvm)#0.14
#cvfit$lambda.min#0.0147554
x <- as.matrix(x)
y <- as.matrix(y)
p <- ncol(x)
iteration <- 20 * p
r <- cvlogit(x,y,nlambda=100,K=10,method="UB",iteration)
# min(r$MSEP) #0.14
# r$best_lambda # 0.007163291
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
#-----
rm(list = ls())
source("test/real_test/cvlogit.R")
load("test/real_test/Leukemia.Rdata")
x <- as.matrix(Leukemia$x)
y <- as.matrix(Leukemia$y)
p <- ncol(x)
iteration <- 20 * p
r <- cvlogit(x,y,nlambda=100,K=10,method="UB",iteration)
save(r,"results/cv_leu.Rdata")
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

# --------------------test3.2 CV LEUKIMIA---------------------------------------
