montefval <- function(lst){
  patch <- function(lst){
    ncols <- max(sapply(lst,length))
    nrows <- length(lst)
    val <- matrix(ncol=ncols,nrow=nrows)
    for (i in seq_len(nrows)){
      vector <- rep(0,ncols)
      vector[1:length(lst[[i]])] <- lst[[i]]
      val[i,] <- vector
    }
    return(val)
  }
  numofzero <- function(vector){
    sum(vector == 0)
  }
  mymatrix <- patch(lst)
  n<-apply(mymatrix,2,FUN=numofzero)
  apply(mymatrix,2,sum)/(nrow(mymatrix)-n)
}

