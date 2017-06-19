cvlogit_new<-function(x,y,nlambda=100,K=10){
  # ------------------------- function document --------------------------------
  # using CD algorithm to find solution path for penalized logistic regression
  # problem as well as a sutiable peanlty strength parameter.
  #
  # Args:
  #       x: design matrix of size n*p
  #       y: observation matrix of size n*1
  # nlambda: number of models will be fitted. Default nlambda=100
  #       K: a parameter indicates K-fold cv will be used in choosing the 
  #          best lambda to minimize the prediction error
  # ----------------------------- sub-functions --------------------------------
  cost <- function(y, yhat) sum(y != yhat) / length(y) 
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
  source("R/ubforlogit.R")
  # ------------------------- data preprocess ----------------------------------
  n <- nrow(x) ; p <- ncol(x)
  x_lam <- scale(x)*sqrt(n)/sqrt(n - 1)
  crossprod.xy<-t(x_lam)%*%y
  lammax<- max(abs(crossprod.xy)) / n
  lammin<-0.001*lammax
  lambda<-exp(seq(log(lammax),log(lammin),length=nlambda))
  if (!exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE))
    runif(1)
  seed <- get(".Random.seed", envir = .GlobalEnv, inherits = FALSE)
  if ((K > n) || (K <= 1))
    stop("'K' outside allowable range")
  K.o <- K
  K <- round(K)
  kvals <- unique(round(n/(1L:floor(n/2))))
  temp <- abs(kvals - K)
  if (!any(temp == 0))
    K <- kvals[temp == min(temp)][1L]
  if (K != K.o)
    warning(gettextf("'K' has been set to %f", K), domain = NA)
  f <- ceiling(n/K)
  s <- sample(rep(1L:K, f), n)
  ms <- max(s)
  # ------------------------- Algorithms ---------------------------------------
  timestart <- Sys.time();
  MSEP <- matrix(nrow=nlambda, ncol=1)
  SIGMA <- matrix(nrow=nlambda, ncol=1)
  itc_warm <- 0; beta_warm <- rep(0,p)
  for (t in seq_len(nlambda)){
    mse<-0
    mse_all <- rep(0,K)
    for (i in seq_len(ms)) {
      i_out <- seq_len(n)[(s == i)]
      i_in <- seq_len(n)[(s != i)]
      x_i <- x[i_in,,drop=FALSE]
      y_i <- y[i_in,,drop=FALSE]

      # ========================= solve the model =========================
      n_i <- nrow(x_i)
      p_i <- ncol(x_i)
      x_i <- scale(x_i)*sqrt(n_i)/sqrt(n_i - 1)  
      mean_x_i <- apply(x_i, 2, mean)
      sigmax_i <- apply(x_i, 2, sd) * sqrt((n_i - 1)/n_i)
      op_i <-1; fvalue_i <- vector()
      # ---------------- Initialization -------------------
      itc_current <- itc_warm ; beta_current <- beta_warm
      itc_update <- itc_current ; beta_update <- beta_current
      # -------------- beginning --------------------------
      while (op_i == 1){
        beta_previous_loop <- beta_current
        for (j in seq_len(p_i)){
          hatyj <- x_i[,-j,drop=F] %*% beta_current[-j] + itc_current
          xstar_j <- x_i[,j] / (2 * sqrt(2))
          a_j <- exp(hatyj + x_i[,j] * beta_current[j])
          ystar_j <- sqrt(2) * y_i - sqrt(2) * (a_j / (1 + a_j)) + 
            xstar_j * beta_current[j]
          z_j <- (1 / n_i) * sum(xstar_j * ystar_j)
          beta_update[j] <- 8 * softT(z_j,lambda[t])
          beta_current <- beta_update
        }
        a_update <- exp(itc_update + x_i %*% beta_update)
        itc_temp <- sum(a_update / (1 + a_update) - y_i)
        itc_update <- itc_current - 4 * itc_temp / n_i
        itc_current <- itc_update 
        if (max(abs(beta_update - beta_previous_loop)) < 1e-5) op_i <- 2
      }
      beta_i <- c(itc_update,beta_update/sigmax_i)
      # ============================= finish ===================================
      p_i <- cbind(as.matrix(rep(1,length(i_out))),x[i_out,,drop=FALSE])%*%beta_i
      yhat_i <- 1 / (1 + exp(-p_i))
      yhat_i[which(yhat_i<=0.5)]<-0
      yhat_i[which(yhat_i>0.5)]<-1
      mse_i <- cost(y[i_out], yhat_i)
      mse_all[i] <- mse_i
      mse <- mse+mse_i
    }
    itc_warm <- itc_update ; beta_warm <- beta_update
    MSEP[t,] <- mse/K
    SIGMA[t,] <- sd(mse_all) * sqrt((K - 1)/K)
    print(paste("finsh",t,"round"))
  }
  index<-which.min(MSEP)
  timeend<-Sys.time()
  info_best<-ubforlogit(x,y,lambda[index])
  runningtime<-timeend-timestart
  r<-list(MSEP=MSEP, nlambda=as.matrix(lambda),
          best_lambda=lambda[index], nsigma=SIGMA)
  result<-list( Kfolds = K, MSEP=MSEP, nlambda=as.matrix(lambda), 
                nsigma=SIGMA,
                best_lambda=lambda[index],  
                best_beta=info_best$hatbeta,
                minfval=info_best$object_value, time=runningtime)
  return(result)
}

