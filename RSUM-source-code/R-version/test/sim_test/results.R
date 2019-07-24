# ---- n1000p100rho0 ----
rm(list=ls())
load("results/n1000p100rho0lambda1e-2.Rdata")
load("results/n1000p100rho0lambda1e-3.Rdata")
load("results/n1000p100rho0lambda1e-4.Rdata")
load("results/n1000p100rho0lambda1e-5.Rdata")
load("results/n1000p100rho0lambda1e-6.Rdata")
load("results/n1000p100rho0lambda1e-7.Rdata")
time <- matrix(c(time_2,time_3,time_4,time_5,time_6,time_7),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <- matrix(c(fval_2,fval_3,fval_4,fval_5,fval_6,fval_7),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval
plot(r1$fvalue_normalized,type="l",col="red")
lines(r2$fvalue_normalized,col="black")
lines(r3[[4]]$fvalue_normalized,col="blue")
lines(r4[[6]]$fvalue_normalized,col="green")
# ---- n1000p100rho050 ----
rm(list=ls())
load("results/n1000p100rho050lambda1e-2.Rdata")
load("results/n1000p100rho050lambda1e-3.Rdata")
load("results/n1000p100rho050lambda1e-4.Rdata")
load("results/n1000p100rho050lambda1e-5.Rdata")
load("results/n1000p100rho050lambda1e-6.Rdata")
load("results/n1000p100rho050lambda1e-7.Rdata")
time <- matrix(c(time_2,time_3,time_4,time_5,time_6,time_7),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <- matrix(c(fval_2,fval_3,fval_4,fval_5,fval_6,fval_7),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval
plot(r1$fvalue_normalized,type="l",col="red")
lines(r2$fvalue_normalized,col="black")
lines(r3[[4]]$fvalue_normalized,col="blue")
lines(r4[[6]]$fvalue_normalized,col="green")
# ---- n1000p100rho095 ----
rm(list=ls())
load("results/n1000p100rho095lambda1e-2.Rdata")
load("results/n1000p100rho095lambda1e-3.Rdata")
load("results/n1000p100rho095lambda1e-4.Rdata")
load("results/n1000p100rho095lambda1e-5.Rdata")
load("results/n1000p100rho095lambda1e-6.Rdata")
load("results/n1000p100rho095lambda1e-7.Rdata")
time <- matrix(c(time_2,time_3,time_4,time_5,time_6,time_7),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <- matrix(c(fval_2,fval_3,fval_4,fval_5,fval_6,fval_7),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval
plot(r1$fvalue_normalized,type="l",col="red")
lines(r2$fvalue_normalized,col="black")
lines(r3[[4]]$fvalue_normalized,col="blue")
lines(r4[[6]]$fvalue_normalized,col="green")

# ---- n100p1000rho0 ----
rm(list=ls())
load("results/n100p1000rho0lambda1e-2.Rdata")
load("results/n100p1000rho0lambda1e-3.Rdata")
load("results/n100p1000rho0lambda1e-4.Rdata")
load("results/n100p1000rho0lambda1e-5.Rdata")
load("results/n100p1000rho0lambda1e-6.Rdata")
load("results/n100p1000rho0lambda1e-7.Rdata")
time <- matrix(c(time_2,time_3,time_4,time_5,time_6,time_7),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <- matrix(c(fval_2,fval_3,fval_4,fval_5,fval_6,fval_7),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval
plot(r1$fvalue_normalized,type="l",col="red")
lines(r2$fvalue_normalized,col="black")
lines(r3[[4]]$fvalue_normalized,col="blue")
lines(r4[[6]]$fvalue_normalized,col="green")

# ---- n100p1000rho050 ----
rm(list=ls())
load("results/n100p1000rho050lambda1e-2.Rdata")
load("results/n100p1000rho050lambda1e-3.Rdata")
load("results/n100p1000rho050lambda1e-4.Rdata")
load("results/n100p1000rho050lambda1e-5.Rdata")
load("results/n100p1000rho050lambda1e-6.Rdata")
load("results/n100p1000rho050lambda1e-7.Rdata")
time <- matrix(c(time_2,time_3,time_4,time_5,time_6,time_7),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <- matrix(c(fval_2,fval_3,fval_4,fval_5,fval_6,fval_7),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval
plot(r1$fvalue_normalized,type="l",col="red")
lines(r2$fvalue_normalized,col="black")
lines(r3[[4]]$fvalue_normalized,col="blue")
lines(r4[[6]]$fvalue_normalized,col="green")

# ---- n100p1000rho095 ----
rm(list=ls())
load("results/n100p1000rho095lambda1e-2.Rdata")
load("results/n100p1000rho095lambda1e-3.Rdata")
load("results/n100p1000rho095lambda1e-4.Rdata")
load("results/n100p1000rho095lambda1e-5.Rdata")
load("results/n100p1000rho095lambda1e-6.Rdata")
load("results/n100p1000rho095lambda1e-7.Rdata")
time <- matrix(c(time_2,time_3,time_4,time_5,time_6,time_7),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <- matrix(c(fval_2,fval_3,fval_4,fval_5,fval_6,fval_7),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval
plot(r1$fvalue_normalized,type="l",col="red")
lines(r2$fvalue_normalized,col="black")
lines(r3[[4]]$fvalue_normalized,col="blue")
lines(r4[[6]]$fvalue_normalized,col="green")

# ----- new rule ----
# check rule floor(n/p) * 10
rm(list = ls())
cor <- "rho0"
lambda <- 1e-7
source("test/sim_test/timeandfval.R")
timeandfval(cor,lambda)
results[[5]]
results[[6]]
# ---- n1000p100rho0 ----
rm(list=ls())
subpath <- "p_round_check"
load(paste("results/n1000p100time/",subpath,"/rho0lambda1e-2.Rdata",sep=""))
results2 <- results
load(paste("results/n1000p100time/",subpath,"/rho0lambda1e-3.Rdata",sep=""))
results3 <- results
load(paste("results/n1000p100time/",subpath,"/rho0lambda1e-4.Rdata",sep=""))
results4 <- results
load(paste("results/n1000p100time/",subpath,"/rho0lambda1e-5.Rdata",sep=""))
results5 <- results
load(paste("results/n1000p100time/",subpath,"/rho0lambda1e-6.Rdata",sep=""))
results6 <- results
load(paste("results/n1000p100time/",subpath,"/rho0lambda1e-7.Rdata",sep=""))
results7 <- results
time <- matrix(c(results2[[5]],results3[[5]],results4[[5]],results5[[5]],
                 results6[[5]],results7[[5]]),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <-  matrix(c(results2[[6]],results3[[6]],results4[[6]],results5[[6]],
                  results6[[6]],results7[[6]]),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval

# ---- n1000p100rho050 ----
rm(list=ls())
subpath <- "p_round_check"
load(paste("results/n1000p100time/",subpath,"/rho050lambda1e-2.Rdata",sep=""))
results2 <- results
load(paste("results/n1000p100time/",subpath,"/rho050lambda1e-3.Rdata",sep=""))
results3 <- results
load(paste("results/n1000p100time/",subpath,"/rho050lambda1e-4.Rdata",sep=""))
results4 <- results
load(paste("results/n1000p100time/",subpath,"/rho050lambda1e-5.Rdata",sep=""))
results5 <- results
load(paste("results/n1000p100time/",subpath,"/rho050lambda1e-6.Rdata",sep=""))
results6 <- results
load(paste("results/n1000p100time/",subpath,"/rho050lambda1e-7.Rdata",sep=""))
results7 <- results
time <- matrix(c(results2[[5]],results3[[5]],results4[[5]],results5[[5]],
                 results6[[5]],results7[[5]]),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <-  matrix(c(results2[[6]],results3[[6]],results4[[6]],results5[[6]],
                  results6[[6]],results7[[6]]),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval


# ---- n1000p100rho095 ----
rm(list=ls())
subpath <- "p_round_check"
load(paste("results/n1000p100time/",subpath,"/rho095lambda1e-2.Rdata",sep=""))
results2 <- results
load(paste("results/n1000p100time/",subpath,"/rho095lambda1e-3.Rdata",sep=""))
results3 <- results
load(paste("results/n1000p100time/",subpath,"/rho095lambda1e-4.Rdata",sep=""))
results4 <- results
load(paste("results/n1000p100time/",subpath,"/rho095lambda1e-5.Rdata",sep=""))
results5 <- results
load(paste("results/n1000p100time/",subpath,"/rho095lambda1e-6.Rdata",sep=""))
results6 <- results
load(paste("results/n1000p100time/",subpath,"/rho095lambda1e-7.Rdata",sep=""))
results7 <- results
time <- matrix(c(results2[[5]],results3[[5]],results4[[5]],results5[[5]],
                 results6[[5]],results7[[5]]),ncol=4,byrow=T)
rownames(time) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(time) <- c("Paul","UB","RUB","APCG")
time
fval <-  matrix(c(results2[[6]],results3[[6]],results4[[6]],results5[[6]],
                  results6[[6]],results7[[6]]),ncol=4,byrow=T)
rownames(fval) <- c("1e-2","1e-3","1e-4","1e-5","1e-6","1e-7")
colnames(fval) <- c("Paul","UB","RUB","APCG")
fval

# -- plot --
load("results/n1000p100time/rho0lambda1e-5.Rdata")
plot(results$r3[[1]]$fvalue_normalized,type="l")
lines(results$r1$fvalue_normalized,col="blue")
lines(results$r2$fvalue_normalized,col="red")
lines(results$r4[[1]]$fvalue_normalized,col="green")
c(min(results$r1$fvalue_normalized),min(results$r2$fvalue_normalized),
  min(results$r3[[1]]$fvalue_normalized),min(results$r4[[1]]$fvalue_normalized))
c(results$r1$object_value,results$r2$object_value,
  results$r3[[1]]$object_value,results$r4[[1]]$object_value)
