# ---- rho0 -----
library(scales)
library(ggplot2)
library(grid)
rm(list = ls())
load("results/n1000p100rho0lambda1e-2.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p1 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho0lambda1e-3.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p2 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho0lambda1e-4.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p3 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho0lambda1e-5.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p4 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho0lambda1e-6.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p5 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho0lambda1e-7.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p6 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

# ---- rho050 ---
library(scales)
library(ggplot2)
library(grid)
rm(list = ls())
load("results/n1000p100rho050lambda1e-2.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p1 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho050lambda1e-3.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p2 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho050lambda1e-4.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p3 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho050lambda1e-5.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p4 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho050lambda1e-6.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p5 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/n1000p100rho050lambda1e-7.Rdata")
t <- c(seq_len(r1$iteration+1),seq_len(r2$iteration+1),
       seq_len(r3[[1]]$iteration+1),seq_len(r4[[1]]$iteration+1))
obj_val <- c(r1$fvalue_normalized,r2$fvalue_normalized,r3[[1]]$fvalue_normalized,
             r4[[1]]$fvalue_normalized)
label <- c(rep("Paul",r1$iteration+1),rep("UB",r2$iteration+1),
           rep("RUB",r3[[1]]$iteration+1),rep("APCG",r4[[1]]$iteration+1))
data <- data.frame(t,obj_val,label)
p6 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())
