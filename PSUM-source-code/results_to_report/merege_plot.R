rm(list=ls())
load("plot/leukemia_plot.Rdata")
library(ggplot2)
library(grid)
vplayout<-function(x,y){
  viewport(layout.pos.row = x,layout.pos.col = y)
}

grid.newpage()
pushViewport(viewport(layout=grid.layout(2,2)))

print(p1,vp=vplayout(1,1))
print(p2,vp=vplayout(1,2))
print(p3,vp=vplayout(2,1))
print(p4,vp=vplayout(2,2))

grid.newpage()
pushViewport(viewport(layout=grid.layout(2,1)))
print(p1,vp=vplayout(1,1))
print(p3,vp=vplayout(2,1))

rm(list=ls())
load("sim_plot.Rdata")
library(ggplot2)
library(grid)
vplayout<-function(x,y){
  viewport(layout.pos.row = x,layout.pos.col = y)
}

grid.newpage()
pushViewport(viewport(layout=grid.layout(2,1)))
print(p1,vp=vplayout(1,1))
print(p2,vp=vplayout(2,1))

