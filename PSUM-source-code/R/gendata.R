rm(list=ls())
#setwd("test/initial_test")
p <- 10000
n <- 1000
epsilon <- rnorm(n,0,1)
genx2=function(n,p,rho){
  #    generate x's multivariate normal with equal corr rho
  if(abs(rho)<1){
    beta=sqrt(rho/(1-rho))
    x0=matrix(rnorm(n*p),ncol=p)
    z=rnorm(n)
    x=beta*matrix(z,nrow=n,ncol=p,byrow=F)+x0
  }
  if(abs(rho)==1){ x=matrix(z,nrow=n,ncol=p,byrow=F)}
  
  return(x)
}
genjerry=
  function(x,snr){
    # generate data according to Friedman's setup
    n=nrow(x)
    p=ncol(x)
    b=((-1)^(1:p))*exp(-2*( (1:p)-1)/20)
    f=x%*%b
    e=rnorm(n)
    k=sqrt(var(f)/(snr*var(e)))
    y=f+k*e
    return(y)
  }
x <- genx2(n,p,0.2)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
n <- nrow(x)
x <- scale(x)*sqrt(n)/sqrt(n - 1)
data <- data.frame(y,x)
#write.csv(data,file="n10000p1000rho020.csv")
save(data,file = "n1000p10000rho020.Rdata")
