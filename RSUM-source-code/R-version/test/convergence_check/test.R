rm(list = ls())
library(glmnet)
data(BinomialExample)
x<-as.matrix(x)
y<-as.matrix(y)

source("test/convergence_check/ubforlogit.R")
source("test/convergence_check/ubforlogit_random.R")
lambda <- 1e-3
r2<-ubforlogit(x,y,lambda)
r3<-ubforlogit_random(x,y,lambda)

data.frame(r2$object_value,r3$object_value)
data.frame(r2$iteration,r3$iteration)
data.frame(r2$time,r3$time)
plot(r3$fvalue_normalized,type="l",xlim = c(10000,40600),ylim = c(0.055,0.065))
lines(r2$fvalue_normalized,col="red")

# -------
rm(list = ls())
load("results/leu_1e-2_10run.Rdata")
f2 <- r2$object_value
t2 <- r2$time
rm(data,r1,r2,r3_fval,r4_fval)
load("test/real_test/Leukemia.RData")
x<-as.matrix(Leukemia$x)
y<-as.matrix(Leukemia$y)
source("test/convergence_check/ubforlogit_random.R")
lambda <- 1e-2
r3<-ubforlogit_random(x,y,lambda)
c(f2,r3$object_value)
c(t2,r3$time)
r3$iteration

# ------
rm(list = ls())
load("test/initial_test/n100p10000rho010lambda1e-2.RData")
r2 <- results$r2
f2 <- r2$object_value
t2 <- r2$time
rm(r2,results)
load("test/initial_test/n100p10000rho0.RData")
source("test/convergence_check/ubforlogit_random.R")
lambda <- 1e-2
r3<-ubforlogit_random(x,y,lambda)
c(f2,r3$object_value)
c(t2,r3$time)
r3$iteration
