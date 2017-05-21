ubforlogit <- function(x, y, lambda){
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
  # ------------------------------ Algorithms ----------------------------------
  # ------------------------------ Parameters ----------------------------------
  it <- 0 ; op <-1
  fvalue <- vector() ; beta_tracker <- matrix(ncol = p) ; itc_tracker <- vector()
  # ---------------------------- Initialization --------------------------------
  itc_current <- 5 ; beta_current <- rep(10,p)
  itc_update <- itc_current ; beta_update <- beta_current
  fvalue[1] <- fval(x,y,beta_current,itc_current,lambda)
  beta_tracker[1,] <- beta_update ; itc_tracker[1] <- itc_update
  # --------------------------- cyclic coordinate decent -----------------------
  timestart <- Sys.time()
  while (op == 1){
    for (j in seq_len(p)){
      hatyj <- x[,-j,drop=F] %*% beta_current[-j] + itc_current
      xstar_j <- x[,j] / (2 * sqrt(2))
      a_j <- exp(hatyj + x[,j] * beta_current[j])
      ystar_j <- sqrt(2) * y - sqrt(2) * (a_j / (1 + a_j)) + xstar_j * beta_current[j]
      z_j <- 1 / n * sum(xstar_j * ystar_j)
      beta_update[j] <- 8 * softT(z_j,lambda)
      beta_current <- beta_update
    }
    a_update <- exp(itc_update + x %*% beta_update)
    itc_temp <- sum(a_update / (1 + a_update) - y)
    itc_update <- itc_current - 4 * itc_temp / n
    itc_current <- itc_update 
    it <- it + 1
    fvalue[it+1] <- fval(x,y,beta_update,itc_update,lambda)
    beta_tracker[it+1] <- beta_update ; itc_tracker[it+1] <- itc_update
    if ( abs(fvalue[it] - fvalue[it+1]) < 1e-6) op <- 2
  }
  timeend <- Sys.time()
  beta_update <- beta_update
  results <- list()
  results$hatbeta <- c(itc_update,beta_update)
  results$object_value <- min(fvalue)
  results$fvalseq <- fvalue
  results$iteration <- it
  results$beta_tracker <- beta_tracker
  results$itc_tracker <- itc_tracker
  results$time <- difftime(timeend,timestart,units = "mins")
  return(results)
}