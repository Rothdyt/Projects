# ------------------------ dataset1 n1000p100rho0 ----------------------------------------
rm(list=ls())
p <- 10^4
n <- 100
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
    r <- list(beta=b,y=y)
    return(y)
  }
x <- genx2(n,p,0)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "test/sim_test/sim_n1000p100rho0.RData")
# ------------------------ dataset2 n1000p100rho050 ----------------------------------------
rm(list=ls())
p <- 100
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
x <- genx2(n,p,0.5)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "test/sim_test/sim_n1000p100rho050.RData")
# ------------------------ dataset3 n1000p100rho095 ----------------------------------------
rm(list=ls())
p <- 100
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
x <- genx2(n,p,0.95)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "test/sim_test/sim_n1000p100rho095.RData")
# ------------------------ dataset4 n100p1000rho0 ----------------------------------------
rm(list=ls())
p <- 1000
n <- 100
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
x <- genx2(n,p,0)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "test/sim_test/sim_n100p1000rho0.RData")
# ------------------------ dataset5 n100p1000rho050 ----------------------------------------
rm(list=ls())
p <- 1000
n <- 100
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
x <- genx2(n,p,0.5)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "test/sim_test/sim_n100p1000rho050.RData")
# ------------------------ dataset6 n100p1000rho095 ----------------------------------------
rm(list=ls())
p <- 1000
n <- 100
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
x <- genx2(n,p,0.95)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "test/sim_test/sim_n100p1000rho095.RData")
# ------------------------ dataset6 n100p1000rho095 ----------------------------------------
rm(list=ls())
p <- 1000
n <- 100
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
x <- genx2(n,p,0.95)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "test/sim_test/sim_n100p1000rho095.RData")
# ------------------------ dataset6 n100p1000rho095 ----------------------------------------
rm(list=ls())
p <- 1000
n <- 100
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
x <- genx2(n,p,0.95)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "test/sim_test/sim_n100p1000rho095.RData")
# ------------------------ dataset7 n100p10000rho0 ----------------------------------------
rm(list=ls())
setwd("test/initial_test")
p <- 10000
n <- 100
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
x <- genx2(n,p,0)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "n100p10000rho0.RData")
# ------------------------ dataset8 n100p10000rho010 ----------------------------------------
rm(list=ls())
setwd("test/initial_test")
p <- 10000
n <- 100
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
x <- genx2(n,p,0.1)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "n100p10000rho010.RData")
# ------------------------ dataset9 n100p10000rho020 ----------------------------------------
rm(list=ls())
setwd("test/initial_test")
p <- 10000
n <- 100
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
save(x,y,file = "n100p10000rho020.RData")
# ------------------------ dataset9 n100p10000rho050 ----------------------------------------
rm(list=ls())
setwd("test/initial_test")
p <- 10000
n <- 100
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
x <- genx2(n,p,0.5)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "n100p10000rho050.RData")
# ------------------------ dataset11 n100p10000rho095 ----------------------------------------
rm(list=ls())
setwd("test/initial_test")
p <- 10000
n <- 100
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
x <- genx2(n,p,0.9)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "n100p10000rho090.RData")
# ------------------------ dataset9 n100p10000rho020 ----------------------------------------
rm(list=ls())
setwd("test/initial_test")
p <- 10000
n <- 100
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
x <- genx2(n,p,0.95)
z <- genjerry(x,1)
prob <- 1 / (1+exp(-z))
set.seed(1)
y <- as.matrix(rbinom(n,1,prob))
save(x,y,file = "n100p10000rho095.RData")