paulforlogit<-function(x,y,lambda,s=1,iteration=500){
  # ------------------------- function document --------------------------------
  # using CD algorithm to find solution path for logistics regression problems
  # with mixtures of l1 and l2 penalty
  #
  # Args      :
  #     x     :  design matrix of size n*p
  #     y     :  observation matrix of size n*1
  # lambda    :  a parameter to control the strength of penalty
  #              The lager lambda is, the stronger the penalty is.
  #     s     :  a parameter to control the intial step-size for armijo rule
  # Outputs   :  
  #   time    : running time
  # hatbeta   : the estimated parameter
  # iteration : the total iteration in this run
  # fvalue    : the object function value at point hatbeta
  # ------------------------- program information ------------------------------
  # author: Yutong Dai <rothdyt@gmail.com>
  # version: 1.0
  # last update: 2017.1.5 21:44
  # ------------------------- input inspection ---------------------------------
  if (class(x) != "matrix" | class(y) != "matrix"){
    stop("both input x and input y should be in the matrix form")
  }
  # -------------------------------- sub-functions -----------------------------
  softT <- function(k,h,lambda){
    if (lambda < abs(k)){
      z <- ifelse(k>0,(k-lambda)/h,(k+lambda)/h)
    }else{
      z <- 0
    }
    return(z)  
  }
  prob<-function(x,beta,itc){
    p<-1/(1+exp(-(itc+x%*%beta)))
    return(p)
  }
  unit_vector <- function(dim,location){
    e <- rep(0,dim)
    e[location] <- 1
    return(e)
  }
  gradient <- function(x,y,beta,itc,j){
    n <- nrow(x)
    prob_all <- apply(x, MARGIN =1, FUN=prob, beta, itc)
    if (j == 0){
      sum_temp1 <- sum(y-prob_all)
      g_j <- (-0.5/n) * sum_temp1
    }else{
      xy_j <- y * x[,j]
      sum_temp1 <- sum(xy_j - x[,j] * prob_all)
      g_j <- (-0.5/n) * sum_temp1
    }
    return(g_j)
  }
  hessian <- function(x,y,beta,itc,j){
    n <- nrow(x)
    prob_all <- apply(x, MARGIN =1, FUN=prob, beta, itc)
    if (j == 0) {
      sum_temp2 <- sum((1/prob_all-1) * prob_all^2)
      h_j <- sum_temp2 * 0.5 / n
    }else{
      sum_temp2 <- sum((x[,j]^2*(1/prob_all-1)) * prob_all^2)
      h_j <- sum_temp2 * 0.5 / n
    }
    return(h_j)
  }
  direction <- function(beta_j,j,h_j,g_j,lambda){
    if (j == 0){
      d_j <- -g_j/h_j
    }else{
      k_j <- h_j * beta_j - g_j
      z_j <- softT(k=k_j,h=h_j,lambda)
      d_j <- z_j - beta_j
    }
    return(d_j)
  }
  gap <- function(s,epsilon,sigma,gamma,j,h_j,d_j,g_j,beta_j,lambda){
    if (j == 0){
      delta_j <- gamma * h_j * d_j^2 + g_j * d_j 
    }else{
      delta_j <- gamma * h_j * d_j^2 + g_j * d_j + lambda * (abs(beta_j+d_j)-
                                                               abs(beta_j))
    }
    return(delta_j)
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
  epsilon <- 0.1 ; sigma <- 0.2 ; gamma <- 0.5
  op <- 1 ; it <- 0
  fvalue <- vector()
  # ---------------------------- Initialization --------------------------------
  itc_current <- 0 ; beta_current <- rep(0,p)
  itc_update <- itc_current ; beta_update <- beta_current
  f_current <- fval(x,y,beta_current,itc_current,lambda)
  # --------------------------- cyclic coordinate decent -----------------------
  timestart <- Sys.time()
  while (it < iteration){
    beta_previous_loop <- beta_current
    for (j in seq_len(p+1)){
      j <- j-1
      g_j <- gradient(x,y,beta_current,itc_current,j)
      h_j <- hessian(x,y,beta_current,itc_current,j)
      bb <- ifelse(j==0,itc_current,beta_current[j])
      d_j <- direction(bb,j,h_j,g_j,lambda)
      delta_j <- gap(s,epsilon,sigma,gamma,j,h_j,d_j,g_j,bb,lambda)
      k <- 0
      op_armijo <- 1
      beta_armijo <- c(itc_current,beta_current)
      while ( op_armijo == 1) {
        beta_armijo <- c(itc_current,beta_current) + s * epsilon^k * d_j *
                                                    unit_vector((p+1),j+1)
        f_armijo <- fval(x,y,beta_armijo[-1],beta_armijo[1],lambda)
        f_compare <- f_current + s * epsilon^k * sigma * delta_j
        if ( f_armijo <= f_compare){
          op_armijo <- 2
        }else{
          k <- k + 1
        }
      }
      if (j == 0){
        itc_update <- itc_current + d_j * s * epsilon^k 
      }else{
        beta_update[j] <- beta_current[j] + d_j * s * epsilon^k 
      }
      beta_current <- beta_update
      itc_current <- itc_update
      f_current <- f_armijo
      it <- it + 1
      fvalue[it] <- f_current
      if (it >= iteration) break
    }
  }
  timeend <- Sys.time()
  results <- list()
  results$hatbeta <- c(itc_update,beta_update/sigmax)
  results$object_value <- fval(x_old,y,beta_update,itc_update,lambda)
  results$fvalue <- c(fval(x_old,y,beta=rep(0,p),itc=0,lambda),fvalue)
  results$time <- timeend - timestart
  return(results)
}