# --------- n1000p100rho0 -----------
## -- sim_n1000p1001e-2 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-2
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_2 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_2 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_2,time_2,file="results/n1000p100rho0lambda1e-2.Rdata" )
## -- sim_n1000p1001e-3 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-3
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_3 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_3 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_3,time_3,file="results/n1000p100rho0lambda1e-3.Rdata" )
## -- sim_n1000p1001e-4 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-4
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_4 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_4 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_4,time_4,file="results/n1000p100rho0lambda1e-4.Rdata" )
## -- sim_n1000p1001e-5 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-5
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_5 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_5 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_5,time_5,file="results/n1000p100rho0lambda1e-5.Rdata" )
## -- sim_n1000p1001e-6 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-6
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_6 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_6 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_6,time_6,file="results/n1000p100rho0lambda1e-6.Rdata" )
## -- sim_n1000p1001e-7 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-7
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_7 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_7 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_7,time_7,file="results/n1000p100rho0lambda1e-7.Rdata" )
# --------- n1000p100rho050 -----------
## -- sim_n1000p1001e-2 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-2
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_2 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_2 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_2,time_2,file="results/n1000p100rho050lambda1e-2.Rdata" )
## -- sim_n1000p1001e-3 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-3
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_3 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_3 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_3,time_3,file="results/n1000p100rho050lambda1e-3.Rdata" )
## -- sim_n1000p1001e-4 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-4
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_4 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_4 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_4,time_4,file="results/n1000p100rho050lambda1e-4.Rdata" )
## -- sim_n1000p1001e-5 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-5
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_5 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_5 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_5,time_5,file="results/n1000p100rho050lambda1e-5.Rdata" )
## -- sim_n1000p1001e-6 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-6
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_6 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_6 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_6,time_6,file="results/n1000p100rho050lambda1e-6.Rdata" )
## -- sim_n1000p1001e-7 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-7
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_7 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_7 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_7,time_7,file="results/n1000p100rho050lambda1e-7.Rdata" )

# --------- n1000p100rho095 -----------
## -- sim_n1000p1001e-2 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-2
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_2 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_2 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_2,time_2,file="results/n1000p100rho095lambda1e-2.Rdata" )
## -- sim_n1000p1001e-3 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-3
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_3 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_3 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_3,time_3,file="results/n1000p100rho095lambda1e-3.Rdata" )
## -- sim_n1000p1001e-4 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-4
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_4 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_4 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_4,time_4,file="results/n1000p100rho095lambda1e-4.Rdata" )
## -- sim_n1000p1001e-5 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-5
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_5 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_5 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_5,time_5,file="results/n1000p100rho095lambda1e-5.Rdata" )
## -- sim_n1000p1001e-6 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-6
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_6 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_6 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_6,time_6,file="results/n1000p100rho095lambda1e-6.Rdata" )
## -- sim_n1000p1001e-7 --
rm(list=ls())
load("test/sim_test/sim_n1000p100rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-7
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_7 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_7 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_7,time_7,file="results/n1000p100rho095lambda1e-7.Rdata" )

# --------- n100p1000rho0 -----------
## -- sim_n100p10001e-2 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-2
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_2 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_2 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_2,time_2,file="results/n100p1000rho0lambda1e-2.Rdata" )
## -- sim_n100p10001e-3 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-3
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_3 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_3 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_3,time_3,file="results/n100p1000rho0lambda1e-3.Rdata" )
## -- sim_n100p10001e-4 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-4
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_4 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_4 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_4,time_4,file="results/n100p1000rho0lambda1e-4.Rdata" )
## -- sim_n100p10001e-5 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-5
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_5 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_5 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_5,time_5,file="results/n100p1000rho0lambda1e-5.Rdata" )
## -- sim_n100p10001e-6 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-6
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_6 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_6 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_6,time_6,file="results/n100p1000rho0lambda1e-6.Rdata" )
## -- sim_n100p10001e-7 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho0.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-7
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_7 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_7 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_7,time_7,file="results/n100p1000rho0lambda1e-7.Rdata" )
# --------- n100p1000rho050 -----------
## -- sim_n100p10001e-2 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-2
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_2 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_2 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_2,time_2,file="results/n100p1000rho050lambda1e-2.Rdata" )
## -- sim_n100p10001e-3 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-3
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_3 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_3 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_3,time_3,file="results/n100p1000rho050lambda1e-3.Rdata" )
## -- sim_n100p10001e-4 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-4
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_4 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_4 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_4,time_4,file="results/n100p1000rho050lambda1e-4.Rdata" )
## -- sim_n100p10001e-5 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-5
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_5 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_5 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_5,time_5,file="results/n100p1000rho050lambda1e-5.Rdata" )
## -- sim_n100p10001e-6 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-6
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_6 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_6 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_6,time_6,file="results/n100p1000rho050lambda1e-6.Rdata" )
## -- sim_n100p10001e-7 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho050.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-7
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_7 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_7 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_7,time_7,file="results/n100p1000rho050lambda1e-7.Rdata" )
# --------- n100p1000rho095 -----------
## -- sim_n100p10001e-2 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-2
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_2 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_2 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_2,time_2,file="results/n100p1000rho095lambda1e-2.Rdata" )
## -- sim_n100p10001e-3 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-3
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_3 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_3 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_3,time_3,file="results/n100p1000rho095lambda1e-3.Rdata" )
## -- sim_n100p10001e-4 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-4
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_4 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_4 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_4,time_4,file="results/n100p1000rho095lambda1e-4.Rdata" )
## -- sim_n100p10001e-5 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-5
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_5 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_5 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_5,time_5,file="results/n100p1000rho095lambda1e-5.Rdata" )
## -- sim_n100p10001e-6 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-6
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_6 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_6 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_6,time_6,file="results/n100p1000rho095lambda1e-6.Rdata" )
## -- sim_n100p10001e-7 --
rm(list=ls())
load("test/sim_test/sim_n100p1000rho095.RData")
source('test/sim_test/paulforlogit.R')
source('test/sim_test/ubforlogit.R')
source('test/sim_test/ubforlogit_random.R')
source('test/sim_test/aubforlogit.R')
lambda <- 1e-7
r1<-paulforlogit(x,y,lambda,s=1)
r2<-ubforlogit (x, y, lambda)
r3 <- list()
for (i in seq_len(10)){
  r3[[i]]<- ubforlogit_random (x, y, lambda)
}
r4 <- list()
for (i in seq_len(10)){
  r4[[i]]<- aubforlogit (x, y, lambda)
}
r3_time <- rep(0,10)
for (i in seq_len(10)){
  r3_time[i]<- r3[[i]]$time
}
r3.time <- as.difftime(mean(r3_time),units="mins")
r3_objval <- rep(0,10)
for (i in seq_len(10)){
  r3_objval[i]<- r3[[i]]$object_value
}
r3.objval <- mean(r3_objval)
r4_time <- rep(0,10)
for (i in seq_len(10)){
  r4_time[i]<- r4[[i]]$time
}
r4.time <- as.difftime(mean(r4_time),units="mins")
r4_objval <- rep(0,10)
for (i in seq_len(10)){
  r4_objval[i]<- r4[[i]]$object_value
}
r4.objval <- mean(r4_objval)
fval_7 <- data.frame(r1$object_value,r2$object_value,r3.objval,r4.objval)
time_7 <- data.frame(r1$time,r2$time,r3.time,r4.time)
save(r1,r2,r3,r4,fval_7,time_7,file="results/n100p1000rho095lambda1e-7.Rdata" )
