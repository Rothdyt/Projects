psepju <- function(x,y,lambda,ncore,cr=0.01){
  # -------------------------------- sub-functions -----------------------------
  softT <- function(m,t,lambda){
    if (lambda < abs(m)){
      z <- ifelse(m < 0 ,(- m - lambda) / (2 * t), (- m + lambda) / (2 * t))
    }else{
      z <- 0
    }
    return(z)  
  }
  prob<-function(x,beta,itc){
    p <- 1 / (1 + exp(-(itc + x %*% beta)))
    return(p)
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
  fval <- function(x,y,beta,itc,lambda){
    n <- nrow(x)
    sum_temp2 <- sum(y*(itc + x %*% beta) - log(1+exp(itc+x %*% beta)))
    f <- (-sum_temp2)*0.5/n + lambda*sum(abs(beta))
    return(f)
  }
  # ------------------------- input inspection ---------------------------------
  if (class(x) != "matrix" | class(y) != "matrix"){
    stop("both input x and input y should be in the matrix form")
  }
  # ------------------------- data preprocess ----------------------------------
  n <- nrow(x)
  p <- ncol(x)
  # ------------------------------ Algorithms ----------------------------------
  # ------------------------------ Parameters ----------------------------------
  op <- 1 ; it <- 0 ; Gmax = 0.25 
  c <- (p  / (2 * p - 1)) * sqrt(p) * Gmax ;  c <- c * (1 + cr)
  t <- 0.125 + c
  fvalue <- vector() ; prob.sample <- rep(1,p+1)
  # ---------------------------- Initialization --------------------------------
  itc_current <- 0 ; beta_current <- rep(0,p)
  itc_update <- itc_current ; beta_update <- beta_current
  fvalue[1] <- fval(x,y,beta_current,itc_current,lambda)
  # --------------------------- cyclic coordinate decent -----------------------
  timestart <- Sys.time()
  while (op == 1){
    indexset <- sample.int((p+1),size=ncore,prob =prob.sample)
    for (j in indexset){
      j <- j-1
      g_j <- gradient(x,y,beta_current,itc_current,j)
      if (j == 0){
        m_j <- g_j - 2 * t * itc_current
        itc_update <- (- m_j ) / (2 * t)
      }else{
        m_j <- g_j - 2 * t * beta_current[j]
        beta_update[j] <- softT(m_j,t,lambda)
      }
    }
    it <- it + 1
    beta_current <- beta_update
    itc_current <- itc_update
    fvalue[it+1] <-  fval(x,y,beta_current,itc_current,lambda)
    if ( abs(fvalue[it] - fvalue[it+1]) < 1e-6)  {
       op <- 2 
    }
    print(fvalue[it+1])
  }
  timeend <- Sys.time()
  results <- list()
  results$hatbeta <- c(itc_update,beta_update)
  results$fvalseq <- fvalue
  results$object_value <- min(fvalue)
  results$iteration <- it
  results$time <- difftime(timeend,timestart,units = "mins")
  return(results)
}