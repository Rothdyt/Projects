# ------------------------------ test 1 ---------------------------------------
rm(list = ls())
library(glmnet)
data(BinomialExample)
x<-as.matrix(x)
y<-as.matrix(y)
n <- nrow(x)
x <- scale(x)*sqrt(n)/sqrt(n - 1)

source("R/sju.R")
source("R/psepju.R")
source("R/ubforlogit.R")
fval <- function(x,y,beta,itc,lambda){
  n <- nrow(x)
  sum_temp3 <- sum(y*(itc + x %*% beta) - log(1+exp(itc+x %*% beta)))
  f <- (-sum_temp3)*0.5/n + lambda*sum(abs(beta))
  return(f)
}
cvfit<-cv.glmnet(x,y,family=c("binomial"),type.measure = "class",nlambda=100)
lambda<-cvfit$lambda.min
glm.beta<-as.matrix(coef(cvfit,s="lambda.min"))
glm.fval <- fval(x,y,glm.beta[-1],glm.beta[1],lambda)

lambda <- 0.01
r1<-sju(x,y,lambda,cr=0.01)
r2<-ubforlogit(x,y,lambda)
r3<-psepju(x,y,lambda,ncore=4,cr=0)

data.frame(r1$time,r2$time,r3$time) # r3 / r2 = 48 , 14 
#data.frame(r1$hatbeta,r2$hatbeta,r3$hatbeta,glm.beta)
data.frame(r1$object_value,r2$object_value,r3$object_value,glm.fval)
data.frame(r1$iteration,r2$iteration,r3$iteration)

max(abs(r1$hatbeta-r2$hatbeta))
r1$object_value-r2$object_value

plot(r1$fvalseq,type="l",col="red")
lines(r2$fvalseq,col="blue")
lines(r3$fvalseq,col="black")


# ------------------------------ test 2 ----------------------------------------
rm(list = ls())
library(glmnet)
library(Rdsm)
library(parallel)
source("R/pju.R")
data(BinomialExample)
x.o<-as.matrix(x)
y.o<-as.matrix(y)
n <- nrow(x.o) ; p <- ncol(x.o)
x.o <- scale(x.o)*sqrt(n)/sqrt(n - 1)
nworkers <- 2
cls <- makeCluster(nworkers)
mgrinit(cls)
mgrmakevar(cls,"x",n,p,savedesc=F)
x[,] <- x.o 
mgrmakevar(cls,"y",n,1,savedesc=F)
y[,] <- y.o
mgrmakevar(cls,"beta_current",(p+1),1,savedesc=F)
mgrmakevar(cls,"beta_update",(p+1),1,savedesc=F)
mgrmakevar(cls,"itc_current",1,1,savedesc=F)
mgrmakevar(cls,"itc_update",1,1,savedesc=F)
mgrmakelock(cls,"lck")
lambda <- 0.034
clusterExport(cls,"pju")
clusterEvalQ(cls,pju(x,y,lambda,ncore=2,numtoupdate=10))
print(beta_update[,])
# ------------------------------ test 3 ----------------------------------------
# visualization
rm(list = ls())
load("test/sim_test/sim_n100p1000rho095.RData")
x<-as.matrix(x)
y<-as.matrix(y)
n <- nrow(x)
x <- scale(x)*sqrt(n)/sqrt(n - 1)
x <- x[,1,drop=F]
lambda <- 0.01


fval <- function(x,y,beta,itc,lambda){
  n <- nrow(x)
  sum_temp2 <- sum(y*(itc + x %*% beta) - log(1+exp(itc+x %*% beta)))
  f <- (-sum_temp2)*0.5/n + lambda*sum(abs(beta))
  return(f)
}


beta <- seq(-10,10,length.out = 100)
itc <- seq(-9,9,length.out = 100)
z <- matrix(ncol=100,nrow=100)
for (i in seq_len(100)){
  for (j in seq_len(100)){
    z[i,j] <- fval(x,y,beta[i],itc[j],lambda)
  }
}

source("R/ubforlogit_tracker_version.R")
source("R/sju_tracker_version.R")
r1<-sju(x,y,lambda,cr=-1)
r2<-ubforlogit(x,y,lambda)
r3<-sju(x,y,lambda,cr=-0.1)
contour(x = beta, y = itc,z = z, nlev = 20, lty = 2, method = "simple",drawlabels = F,axes = TRUE)
points(x=r1$beta_tracker,y=r1$itc_tracker,col="blue",pch=1)
lines(x=r1$beta_tracker,y=r1$itc_tracker,col="blue",lty=1)
points(x=r2$beta_tracker,y=r2$itc_tracker,col="red",pch=2)
lines(x=r2$beta_tracker,y=r2$itc_tracker,col="red",lty=2)
leg.1 <- paste("Jacobi iterations=",r1$iteration)
leg.2 <- paste("Gauss-Sidel iterations=",r2$iteration)
legend(-11,10,legend = c(leg.1,leg.2),col=c("blue","red"),pch=c(1,2),lty=c(1,2))

r1<-sju(x,y,lambda,cr=-1)
r3<-sju(x,y,lambda,cr=-0.1)
contour(x = beta, y = itc,z = z, nlev = 20, lty = 2, method = "simple",drawlabels = F,axes = TRUE)
points(x=r1$beta_tracker,y=r1$itc_tracker,col="blue",pch=1,cex=1)
points(x=r3$beta_tracker,y=r3$itc_tracker,col="red",pch=2,cex=0.5)

leg.1 <- paste("Larger c,iteration=",r1$iteration)
leg.3 <- paste("Smaller c,iteration=",r3$iteration)
legend(-11,10,legend = c(leg.1,leg.3),col=c("blue","red"),pch=c(1,2),lty=c(1,2))

###########

rm(list = ls())
data <- read.csv("newrho080.csv")
y <- data[,2]
x <- data[,-c(1,2)]
x<-as.matrix(x)
y<-as.matrix(y)
n <- nrow(x)
x <- scale(x)*sqrt(n)/sqrt(n - 1)
source("R/psepju.R")
source("R/sju.R")
lambda <- 0.01
r1<-psepju(x,y,lambda,ncore=40,cr=0.01)
sju(x,y,lambda,cr=0.1)
