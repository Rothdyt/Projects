aubforlogit <- function(x,y,lambda){
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
  fval <- function(x,y,beta,itc,lambda){
    n <- nrow(x)
    sum_temp3 <- sum(y*(itc + x %*% beta) - log(1+exp(itc+x %*% beta)))
    f <- (-sum_temp3)*0.5/n + lambda*sum(abs(beta))
    return(f)
  }
  getroot <- function(p,gamma,mu){
    root <- c(0,0)
    root[1] <- (mu - gamma + sqrt((mu - gamma)^2 + 4 * p^2 * gamma)) / (2 * p^2)
    root[2] <- (mu - gamma - sqrt((mu - gamma)^2 + 4 * p^2 * gamma)) / (2 * p^2)
    r <- root[which(root <= 1/p & root >0 )]
    return(r)
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
  it <- 0 ; op <-1 ; mu <- 0.5 ; 
  gamma <- 0.5 ; gamma_new <- gamma ; psample <- rep(1,p)/p
  #check_point<-c(0,0) 
  fvalue <- vector()
  # ---------------------------- Initialization --------------------------------
  itc_current <- 0 ; beta_current <- rep(0,p) ; z <- beta_current ; z0 <- 0
  itc_update <- itc_current ; beta_update <- beta_current
  z_new <- z ; z0_new <- z0
  # --------------------------- cyclic coordinate decent -----------------------
  timestart <- Sys.time()
  while (op == 1){
    j <- sample(p,1,replace=T,prob = psample)
    alpha <- getroot(p=p,gamma=gamma,mu=mu)
    gamma_new <- (1 - alpha) * gamma + alpha * mu
    theta <- alpha * mu / gamma_new
    xi <- (1 / (alpha * gamma + gamma_new)) * (alpha * gamma * z + 
                                                 gamma_new * beta_current)
    xi0 <- 1 / (alpha * gamma + gamma_new) * (alpha * gamma * z0 + 
                                                  gamma_new * itc_current)
    z_new[-j] <- (1 - theta) * z[-j] + theta * xi[-j]
    y_tilde <- xi0 + x %*% xi
    tmp <- apply(y_tilde, MARGIN=1, FUN=function(x) exp(x) / (1 + exp(x)))
    x_j_star <- sqrt((p * alpha) / 8) * x[,j,drop=F]
    y_star <- sqrt(2 /  (p * alpha)) * y - sqrt(2 /  (p * alpha)) * tmp + 
        sqrt((p * alpha) / 8) * x[,j] * ((1 - theta) * z[j] + theta * xi[j])
    z_j_tilde <- (1 / n) * t(y_star) %*% x_j_star
    z_new[j] <- 8 * softT(z_j_tilde,lambda) / (p * alpha)
    beta_update <- xi + p * alpha * (z_new - z) + mu / p * (z - xi)
    if (max(abs(beta_update - beta_current)) < 1e-12){
      if (it > p) op <-2
    }
    it <- it + 1
    if (it > 100 * p^2) op <-2
    z0_new <- (4 / (n * p * alpha)) * sum((y - tmp)) + 
      ((1 - theta) * z0 + theta * xi0)
    itc_update <- xi0 + p * alpha * (z0_new - z0) + mu / p * (z0 - xi0)
    itc_current <- itc_update
    beta_current <- beta_update
    fvalue[it] <- fval(x,y,beta_update,itc_update,lambda)
    gamma <- gamma_new ; z <- z_new ; z0 <- z0_new
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