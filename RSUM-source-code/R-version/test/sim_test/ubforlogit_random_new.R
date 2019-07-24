ubforlogit_random_new <- function(x, y, lambda){
  # ------------------------- function document --------------------------------
  # using CD algorithm to find solution path for logistics regression problems
  #
  # Args:
  #     x   :  design matrix of size n*p
  #     y   :  observation matrix of size n*1
  # lambda  :  a parameter to control the strength of penalty
  #            The lager lambda is, the stronger the penalty is.
  # methods :  methods used in parameters' update. 
  #            You can choose either `IRLS` or `UB`.
  # Outputs:  
  #   time    : running time
  # hatbeta   : the estimated parameter
  # iteration : the total iteration in this run
  # fvalue    : the object function value at point hatbeta
  # ------------------------- program information ------------------------------
  # author: Yutong Dai <rothdyt@gmail.com>
  # version: 1.0
  # last update: 2017.1.4 21:44
  # ------------------------- input inspection ---------------------------------
  if (class(x) != "matrix" | class(y) != "matrix"){
    stop("both input x and input y should be in the matrix form")
  }
  # ------------------------- sub-functions ------------------------------------
  # define soft-thresholding function
  softT <- function(z, r) {
    if (r < abs(z)){
      t <- ifelse(z>0,z-r,z+r)
    }else{
      t <- 0
    }
    return(t)
  }
  prob<-function(x,beta,itc){
    p<-1/(1+exp(-(itc+x%*%beta)))
    return(p)
  }
  fval <- function(x,y,beta,itc,lambda){
    n <- nrow(x)
    sum_temp3 <- sum(y*(itc + x %*% beta) - log(1+exp(itc+x %*% beta)))
    f <- (-sum_temp3)*0.5/n + lambda*sum(abs(beta))
    return(f)
  }
  # ------------------------- data preprocess ----------------------------------
  n <- nrow(x)
  p <- ncol(x)
  x_old <- x
  x <- scale(x)*sqrt(n)/sqrt(n - 1)  # make sure that 1/n*sum_{i=1}^n x_{i,j}^2=1
  mean_x <- apply(x, 2, mean)
  sigmax <- apply(x, 2, sd) * sqrt((n - 1)/n)
  # ------------------------------ Algorithms ----------------------------------
  # ------------------------------ Parameters ----------------------------------
  it <- 0 ; op <-1 ; psample <- rep(1,p)/p
  fvalue <- vector() ;   check_point<-c(0,0)
  # ---------------------------- Initialization --------------------------------
  itc_current <- 0 ; beta_current <- rep(0,p)
  itc_update <- itc_current ; beta_update <- beta_current
  check_slot <- matrix(ncol=2,nrow=p)
  check_slot[,1] <- beta_current
  check_slot[,2] <- beta_current
  # --------------------------- cyclic coordinate decent -----------------------
  timestart <- Sys.time()
  while (op == 1){#browser()
    if (it %% p == 0) print(it)
    beta_previous_loop <- beta_current
    j <- sample(p,1,replace=T,prob = psample)
    ifelse(it%%2 == 0,check_point[1]<-j,check_point[2]<-j)
    if (check_point[1] != check_point[2]){
      hatyj <- x[,-j,drop=F] %*% beta_current[-j] + itc_current
      xstar_j <- x[,j] / (2 * sqrt(2))
      a_j <- exp(hatyj + x[,j] * beta_current[j])
      ystar_j <- sqrt(2) * y - sqrt(2) * (a_j / (1 + a_j)) + xstar_j * beta_current[j]
      z_j <- 1 / n * sum(xstar_j * ystar_j)
      beta_update[j] <- 8 * softT(z_j,lambda)
      beta_current <- beta_update
      it <- it + 1
      fvalue[it] <- fval(x,y,beta_update,itc_update,lambda)
    }
    if (it %% p == 0){
      if ((it/p) %% 2 == 0){
        check_slot[,2] <- beta_update
      }else{
        check_slot[,1] <- beta_update
      }
      if(max(abs(check_slot[,1]-check_slot[,2])) < 1e-12) op <-2
    }
    if (it %% p == 0){
      a_update <- exp(itc_update + x %*% beta_update)
      itc_temp <- sum(a_update / (1 + a_update) - y)
      itc_update <- itc_current - 4 * itc_temp / n
      itc_current <- itc_update 
      it <- it + 1
      fvalue[it] <- fval(x,y,beta_update,itc_update,lambda)
    }
    if (it > 100 * p^2) op <-2
  }
  timeend <- Sys.time()
  beta_update <- beta_update/sigmax
  results <- list()
  results$hatbeta <- c(itc_update,beta_update)
  results$object_value <- fval(x_old,y,beta_update,itc_update,lambda) 
  results$iteration <- it
  results$fvalue_normalized <- c(fval(x_old,y,beta=rep(0,p),itc=0,lambda),fvalue)
  results$time <- difftime(timeend,timestart,units = "mins")
  return(results)
}