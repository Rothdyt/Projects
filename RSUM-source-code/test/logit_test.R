# ------------------------------ test 1 ---------------------------------------
rm(list = ls())
library(glmnet)
data(BinomialExample)
x<-as.matrix(x)
y<-as.matrix(y)
source("R/paulforlogit.R")
source("R/ubforlogit.R")
source("R/ubforlogit_random.R")
source("R/aubforlogit.R")
fval <- function(x,y,beta,itc,lambda){
  n <- nrow(x)
  sum_temp3 <- sum(y*(itc + x %*% beta) - log(1+exp(itc+x %*% beta)))
  f <- (-sum_temp3)*0.5/n + lambda*sum(abs(beta))
  return(f)
}
#set.seed(1)
cvfit<-cv.glmnet(x,y,family=c("binomial"),type.measure = "class",nlambda=100)
lambda<-cvfit$lambda.min
glm.beta<-as.matrix(coef(cvfit,s="lambda.min"))
glm.fval <- fval(x,y,glm.beta[-1],glm.beta[1],lambda)
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit(x,y,lambda)
r3<-ubforlogit_random(x,y,lambda)
r4<-aubforlogit(x,y,lambda)

data.frame(r1$hatbeta,r2$hatbeta,r3$hatbeta,r4$hatbeta,glm.beta)
data.frame(r1$object_value,r2$object_value,r3$object_value,r4$object_value,glm.fval)
data.frame(r1$iteration,r2$iteration,r3$iteration,r4$iteration)
data.frame(r1$time,r2$time,r3$time,r4$time)

max(abs(r1$hatbeta-r2$hatbeta))
r1$object_value-r2$object_value

plot(r4$fvalue_normalized,type="l",col="red")
lines(r1$fvalue_normalized,col="blue")
lines(r2$fvalue_normalized,col="black")
lines(r3$fvalue_normalized,col="green")



# ------------------------------ test 2 ----------------------------------------
rm(list = ls())
source("R/cvlogit.R")
library(glmnet)
data(BinomialExample)
x<-as.matrix(x) 
y<-as.matrix(y)
fval <- function(x,y,beta,itc,lambda){
  n <- nrow(x)
  sum_temp3 <- sum(y*(itc + x %*% beta) - log(1+exp(itc+x %*% beta)))
  f <- (-sum_temp3)*0.5/n + lambda*sum(abs(beta))
  return(f)
}
cost<-function(y, yhat) sum(y != yhat)/length(y)
set.seed(1)
cvfit<-cv.glmnet(x,y,family=c("binomial"),type.measure = "class")
lambda<-cvfit$lambda.min
glm.beta<-as.matrix(coef(cvfit,s="lambda.min"))
glm.fval <- fval(x,y,glm.beta[-1],glm.beta[1],lambda)
r <- cvlogit(x,y,nlambda=100,K=10,method="UB")
# ----
rm(list = ls())
source("R/cvlogit_new.R")
library(glmnet)
data(BinomialExample)
x<-as.matrix(x) 
y<-as.matrix(y)
r <- cvlogit_new(x,y,nlambda=100,K=10)
cvfit<-cv.glmnet(x,y,family=c("binomial"),type.measure = "class",nlambda=100)