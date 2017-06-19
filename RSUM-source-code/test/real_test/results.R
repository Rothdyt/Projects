library(scales)
library(ggplot2)
library(grid)
rm(list = ls())
load("results/leu_1e-1_10run.Rdata")
iteration <- 71420
data$label <- c(rep("CD",iteration+1),rep("SUM",iteration+1),
                         rep("RUM",iteration+1),rep("APCG",iteration+1))
p1 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
   theme(legend.position=c(0.9,0.8))+
   theme(legend.background=element_blank()) + 
   theme(legend.key=element_blank()) + 
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

load("results/leu_1e-2_10run.Rdata")
iteration <- 71420
data$label <- c(rep("CD",iteration+1),rep("SUM",iteration+1),
                rep("RUM",iteration+1),rep("APCG",iteration+1))
p2 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) +       
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())


load("results/leu_1e-3_10run.Rdata")
iteration <- 71420
data$label <- c(rep("CD",iteration+1),rep("SUM",iteration+1),
                rep("RUM",iteration+1),rep("APCG",iteration+1))
p3 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) +       
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())


load("results/leu_1e-4_10run.Rdata")
iteration <- 71420
data$label <- c(rep("CD",iteration+1),rep("SUM",iteration+1),
                rep("RUM",iteration+1),rep("APCG",iteration+1))
p4 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) +       
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())


load("results/leu_1e-5_10run.Rdata")
iteration <- 71420
data$label <- c(rep("CD",iteration+1),rep("SUM",iteration+1),
                rep("RUM",iteration+1),rep("APCG",iteration+1))
p5 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) +       
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())


load("results/leu_1e-6_10run.Rdata")
iteration <- 71420
data$label <- c(rep("CD",iteration+1),rep("SUM",iteration+1),
                rep("RUM",iteration+1),rep("APCG",iteration+1))
p6 <- ggplot(data,aes(x=t,y=obj_val,colour=label,linetype=label))+geom_line()+
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  theme(legend.position=c(0.9,0.8))+
  theme(legend.background=element_blank()) + 
  theme(legend.key=element_blank()) +       
  theme(axis.title.x=element_blank())+
  theme(axis.title.y=element_blank())

vplayout<-function(x,y){
  viewport(layout.pos.row = x,layout.pos.col = y)
}

grid.newpage()
pushViewport(viewport(layout=grid.layout(2,3)))

print(p1,vp=vplayout(1,1))
print(p2,vp=vplayout(1,2))
print(p3,vp=vplayout(1,3))
print(p4,vp=vplayout(2,1))
print(p5,vp=vplayout(2,2))
print(p6,vp=vplayout(2,3))
