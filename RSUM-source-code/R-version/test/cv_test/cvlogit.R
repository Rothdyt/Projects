cvlogit<-function(x,y,nlambda=100,K=10,method="UB",iteration){
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
  # methods: Ways to carry out coordinate descent algorithm. 
  #          available option: UB
  source('test/real_test/ubforlogit.R')
  # ----------------------------- sub-functions --------------------------------
  cost<-function(y, yhat) (sum(y != yhat))/length(y)
  # ------------------------- data preprocess ----------------------------------
  n <- nrow(x)
  crossprod.xy<-t(x)%*%y
  lammax<-max(abs(crossprod.xy)) / (2 * n)
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
  #set.seed(1)
  s <- sample(rep(1L:K, f), n)
  ms <- max(s)
  # ------------------------- Algorithms ---------------------------------------
  timestart <- Sys.time();
  MSEP <- matrix(nrow=nlambda, ncol=1)
  SIGMA <- matrix(nrow=nlambda, ncol=1)
  for (t in seq_len(nlambda)){
    mse<-0
    mse_all <- rep(0,K)
    for (i in seq_len(ms)) {
      j_out <- seq_len(n)[(s == i)]
      j_in <- seq_len(n)[(s != i)]
      x_i <- x[j_in,,drop=FALSE]
      y_i <- y[j_in,,drop=FALSE]
      if (method == "UB"){
        beta_i <- ubforlogit(x_i,y_i,lambda[t],iteration)$hatbeta
      }else{
        stop("A Incorrect Method")
      }
      p_i <- cbind(as.matrix(rep(1,length(j_out))),x[j_out,,drop=FALSE])%*%beta_i
      yhat_i <- 1 / (1 + exp(-p_i))
      yhat_i[which(yhat_i<=0.5)]<-0
      yhat_i[which(yhat_i>0.5)]<-1
      mse_i <- cost(y[j_out], yhat_i)
      mse_all[i] <- mse_i
      mse <- mse+mse_i
    }
    MSEP[t,] <- mse/K
    SIGMA[t,] <- sd(mse_all)
    print(paste("finsh",t,"round"))
  }
  index<-which.min(MSEP)
  timeend<-Sys.time()
  info_best<-ubforlogit(x,y,lambda[index],iteration)
  runningtime<-timeend-timestart
  result<-list( Kfolds = K, MSEP=MSEP, nlambda=as.matrix(lambda), nsigma=SIGMA,
                best_lambda=lambda[index], best_beta=info_best$hatbeta, 
                minfval=info_best$object_value, time=runningtime)
  return(result)
}

