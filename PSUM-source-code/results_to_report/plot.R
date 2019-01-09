# ---------------- plot 1 contour plot ----------------
rm(list = ls())
library(ggplot2)
load("results_to_report/sim_n100p1000rho095.RData")
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
itc <- seq(-10,10,length.out = 100)
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
# contour(x = beta, y = itc,z = z,
#         nlev = 20, lty = 2, method = "simple",
#         drawlabels = F,axes = TRUE,
#         xlab=expression(beta[1]),ylab=expression(beta[0]))
# points(x=r1$beta_tracker,y=r1$itc_tracker,col="blue",pch=1)
# lines(x=r1$beta_tracker,y=r1$itc_tracker,col="blue",lty=1)
# points(x=r2$beta_tracker,y=r2$itc_tracker,col="red",pch=2)
# lines(x=r2$beta_tracker,y=r2$itc_tracker,col="red",lty=2)
# leg.1 <- paste("Jacobi, iterations=",r1$iteration)
# leg.2 <- paste("Gauss-Sidel, iterations=",r2$iteration)
# legend("topleft",legend = c(leg.1,leg.2),col=c("blue","red"),border = "red",
#        bty = "o",
#        pch=c(1,2),lty=c(1,2))
x_axis <- vector(); y_axis <- vector(); z_axis <- vector()
for (i in seq_len(100)){
  for (j in seq_len(100)){
    x_axis <- c(x_axis, beta[i])
    y_axis <- c(y_axis, itc[j])
    z_axis <- c(z_axis, z[i,j])
  }
}
plot_data <- data.frame(x=x_axis, y=y_axis, z=z_axis)
points <- data.frame(beta_tracker = c(r1$beta_tracker, r2$beta_tracker), 
                     itc_tracker = c(r1$itc_tracker, r2$itc_tracker),
                     label = c(rep("Jacobi, iterations=22", length(r1$itc_tracker)), rep("Gauss-Sidel, iterations=10", length(r2$itc_tracker))))
ggplot(plot_data, aes(x=x, y=y, z=z)) + stat_contour() +
  xlab(expression(beta[1])) + ylab(expression(beta[0])) + 
  geom_point(data=points, mapping=aes_string(x = "beta_tracker", y = "itc_tracker", colour="label"), 
             inherit.aes = FALSE)  + 
  geom_line(data=points, mapping=aes_string(x = "beta_tracker", y = "itc_tracker", lty="label", colour="label"), 
            inherit.aes = FALSE) + 
  theme(legend.position="top", legend.title = element_blank())
  

# r1<-sju(x,y,lambda,cr=-1)
# r3<-sju(x,y,lambda,cr=-0.5)
# contour(x = beta, y = itc,z = z, nlev = 20, lty = 2, 
#         method = "simple",drawlabels = F,axes = TRUE,
#         xlab=expression(beta~1),ylab=expression(beta~0))
# points(x=r1$beta_tracker,y=r1$itc_tracker,col="blue",pch=1,cex=1)
# points(x=r3$beta_tracker,y=r3$itc_tracker,col="red",pch=2,cex=0.5)
# 
# leg.1 <- paste("Smaller c,iterations=",r1$iteration)
# leg.3 <- paste("Larger c,iterations=",r3$iteration)
# legend("topleft",legend = c(leg.1,leg.3),col=c("blue","red"),pch=c(1,2))

points <- data.frame(beta_tracker = c(r1$beta_tracker, r3$beta_tracker), 
                     itc_tracker = c(r1$itc_tracker, r3$itc_tracker),
                     label = c(rep("Smaller c,iterations=22", length(r1$itc_tracker)), rep("Larger c,iterations=45", length(r3$itc_tracker))),
                     shape=c(rep("1", 46), rep("2", 23)))
ggplot(plot_data, aes(x=x, y=y, z=z)) + stat_contour() +
  xlab(expression(beta[1])) + ylab(expression(beta[0])) + 
  geom_point(data=points, mapping=aes_string(x = "beta_tracker", y = "itc_tracker", colour="label", shape="label", size="label"), 
             inherit.aes = FALSE)  + 
  theme(legend.position="top", legend.title = element_blank()) + scale_size_manual(values=c(1,1.5))
# -------------- plot2 leukemia 1e-2 --------------

rm(list=ls())
data <- read.csv("results_to_report/Leukemia_c001_1e-2.csv",header = F)
library(stringr)
data$V4 <- str_replace(data$V4,"q1None","q=1,cyclic")
data$V4 <- str_replace(data$V4,"q1True","q=1,random")
data$V4 <- str_replace(data$V4,"q4None","q=4,cyclic")
data$V4 <- str_replace(data$V4,"q4True","q=4,random")
data$V4 <- str_replace(data$V4,"q8None","q=8,cyclic")
data$V4 <- str_replace(data$V4,"q8True","q=8,random")
data$V4 <- str_replace(data$V4,"q32None","q=32,cyclic")
data$V4 <- str_replace(data$V4,"q32True","q=32,random")

iteration <- data$V1
relative_error <- data$V2 - min(data$V2)
relative_error[relative_error == 0] <- 1e-6 
time <- data$V3
label <- data$V4

library(ggplot2)
library(scales)
timeplot <- data.frame(time,relative_error,time,label)
p1 <- ggplot(timeplot,aes(x=time+1e-1,y=relative_error,colour=label,linetype=label)) + 
  geom_line() +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  xlab("time(in seconds)") + ylab("relative error")

p1
#####
d1_c <- max(data$V1[data$V4 == " q=1,cyclic"]) * 40 * 1
d1_r <- max(data$V1[data$V4 == " q=1,random"]) * 40 * 1
d4_c <- max(data$V1[data$V4 == " q=4,cyclic"]) * 40 * 4
d4_r <- max(data$V1[data$V4 == " q=4,random"]) * 40 * 4
d8_c <- max(data$V1[data$V4 == " q=8,cyclic"]) * 40 * 8
d8_r <- max(data$V1[data$V4 == " q=8,random"]) * 40 * 8
d32_c <- max(data$V1[data$V4 == " q=32,cyclic"]) * 40 * 32
d32_r <- max(data$V1[data$V4 == " q=32,random"]) * 40 * 32

methods <- c("q=1,cyclic","q=1,random","q=4,cyclic","q=4,random",
           "q=8,cyclic","q=8,random","q=32,cyclic","q=32,random")
data_access <- c(d1_c,d1_r,d4_c,d4_r,d8_c,d8_r,d32_c,d32_r)
barplot <- data.frame(data_access,methods)
p2 <- ggplot(barplot,aes(x=methods,y=data_access)) + geom_bar(stat="identity") +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  ylab("number of data access")


# -------------- plot3 leukemia 1e-6 --------------

rm(list=ls())
data <- read.csv("results_to_report/Leukemia_c001_1e-6.csv",header = F)
library(stringr)
data$V4 <- str_replace(data$V4,"q1None","q=1,cyclic")
data$V4 <- str_replace(data$V4,"q1True","q=1,random")
data$V4 <- str_replace(data$V4,"q4None","q=4,cyclic")
data$V4 <- str_replace(data$V4,"q4True","q=4,random")
data$V4 <- str_replace(data$V4,"q8None","q=8,cyclic")
data$V4 <- str_replace(data$V4,"q8True","q=8,random")
data$V4 <- str_replace(data$V4,"q32None","q=32,cyclic")
data$V4 <- str_replace(data$V4,"q32True","q=32,random")

iteration <- data$V1
relative_error <- data$V2 - min(data$V2)
relative_error[relative_error == 0] <- 1e-6 
time <- data$V3
label <- data$V4

library(ggplot2)
library(scales)
timeplot <- data.frame(time,relative_error,time,label)
p3 <- ggplot(timeplot,aes(x=time+1e-1,y=relative_error,colour=label,linetype=label)) + 
  geom_line() +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  xlab("time(in seconds)") + ylab("relative error")


#####
d1_c <- max(data$V1[data$V4 == " q=1,cyclic"]) * 40 * 1
d1_r <- max(data$V1[data$V4 == " q=1,random"]) * 40 * 1
d4_c <- max(data$V1[data$V4 == " q=4,cyclic"]) * 40 * 4
d4_r <- max(data$V1[data$V4 == " q=4,random"]) * 40 * 4
d8_c <- max(data$V1[data$V4 == " q=8,cyclic"]) * 40 * 8
d8_r <- max(data$V1[data$V4 == " q=8,random"]) * 40 * 8
d32_c <- max(data$V1[data$V4 == " q=32,cyclic"]) * 40 * 32
d32_r <- max(data$V1[data$V4 == " q=32,random"]) * 40 * 32

methods <- c("q=1,cyclic","q=1,random","q=4,cyclic","q=4,random",
             "q=8,cyclic","q=8,random","q=32,cyclic","q=32,random")
data_access <- c(d1_c,d1_r,d4_c,d4_r,d8_c,d8_r,d32_c,d32_r)
barplot <- data.frame(data_access,methods)
p4 <- ggplot(barplot,aes(x=methods,y=data_access)) + geom_bar(stat="identity") +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  ylab("number of data access")

save(p1,p2,p3,p4,file="leukemia_plot.Rdata")

# ------------------------------ plot4 rho020 1e-2 ------------------------------
rm(list=ls())
data <- read.csv("results_to_report/n1000p10000rho020_c001_1e-2.csv",header = F)
library(stringr)
data$V4 <- str_replace(data$V4,"q16None","q=16,cyclic")
data$V4 <- str_replace(data$V4,"q16True","q=16,random")
data$V4 <- str_replace(data$V4,"q32None","q=32,cyclic")
data$V4 <- str_replace(data$V4,"q32True","q=32,random")
data$V4 <- str_replace(data$V4,"q64None","q=64,cyclic")
data$V4 <- str_replace(data$V4,"q64True","q=64,random")

relative_error <- data$V2 - min(data$V2)
index <- which(relative_error <= 10^(-4.5))
data<- data[-c(index),]
iteration <- data$V1
time <- data$V3
label <- data$V4
relative_error <- relative_error[-index]
library(ggplot2)
library(scales)
timeplot <- data.frame(time,relative_error,label)
p1 <- ggplot(timeplot,aes(x=time+1e-1,y=relative_error,colour=label,linetype=label)) + 
  geom_line() + xlab("time(in seconds)") + ylab("relative error") +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))
p1
# -------------------- plot5 n10000p1000 rho020 1e-2 -----------------------------
rm(list=ls())
data <- read.csv("results_to_report/n10000p1000rho020_c001_1e-2.csv",header = F)
library(stringr)
data$V4 <- str_replace(data$V4,"q16None","q=16,cyclic")
data$V4 <- str_replace(data$V4,"q16True","q=16,random")
data$V4 <- str_replace(data$V4,"q32None","q=32,cyclic")
data$V4 <- str_replace(data$V4,"q32True","q=32,random")
data$V4 <- str_replace(data$V4,"q64None","q=64,cyclic")
data$V4 <- str_replace(data$V4,"q64True","q=64,random")

relative_error <- data$V2 - min(data$V2)
index <- which(relative_error <= 10^(-7))
data<- data[-c(index),]
iteration <- data$V1
time <- data$V3
label <- data$V4
relative_error <- relative_error[-index]
library(ggplot2)
library(scales)
timeplot <- data.frame(time,relative_error,label)
p2 <- ggplot(timeplot,aes(x=time+1e-1,y=relative_error,colour=label,linetype=label)) + 
  geom_line() + xlab("time(in seconds)") + ylab("relative error") +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))
save(p1,p2,file="sim_plot.Rdata")
# -------------------- plot6 cr compare -----------------------------------------
rm(list=ls())
data <- read.csv("results_to_report/Leukemia_cr_compare.csv",header = F)

relative_error <- data$V2 - min(data$V2)
relative_error[relative_error == 0] <- 1e-6 
time <- data$V3
label <- data$V4

library(ggplot2)
library(scales)
timeplot <- data.frame(time,relative_error,label)
ggplot(timeplot,aes(x=time+1e-1,y=relative_error,colour=label)) + 
  geom_line() + xlab("time(in seconds)") + ylab("relative error")+
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + 
                  theme(legend.position="none") + xlim(-1,40) +
  annotate("text", x=30, y=0.0012, parse=TRUE,label="c[1]") +
  annotate("text", x=22.5, y=0.0012, parse=TRUE,label="c[2]") +
  annotate("text", x=13, y=0.0012, parse=TRUE,label="c[3]")
