# ----- rdsmlock() ------
rm(list=ls())
s_lock <- function(n) {
  require(Rdsm)
  for (i in 1:n) {
    rdsmlock("totlock")
    tot[1,1] <- tot[1,1] + 1
    rdsmunlock("totlock")
  }
}

library(Rdsm)
library(parallel)
c2 <- makeCluster(2)
mgrinit(c2)
mgrmakevar(c2,"tot",1,1)
mgrmakelock(c2,"totlock")
tot[1,1] <- 0
clusterExport(c2,"s_lock")
clusterEvalQ(c2,s_lock(1000))
tot[1,1] 

# ------ 1-barr() ------
rm(list=ls())
maxburst <- function(x,k,mas,rslts){
  require (Rdsm)
  require (zoo)
  # determine this thread ¡¯ s chunk of x
  n <- length(x)
  myidxs <- getidxs (n-k+1)
  myfirst <- myidxs [1]
  mylast <- myidxs[length(myidxs)] 
  mas[1,myfirst:mylast] <- 
    rollmean (x[myfirst:(mylast+k-1)],k)
  # make sure all threads have written to mas
  barr ()
  # one thread must do wrapup , say thread 1
  if (myinfo$id == 1) {
    rslts[1,1] <- which.max(mas[,])
    rslts[1,2] <- mas[1,rslts[1,1]]
  }
}

library(Rdsm)
library(parallel)
c2 <- makeCluster(2)
mgrinit(c2)
mgrmakevar(c2,"mas",1,9)
mgrmakevar(c2,"rslts",1,2)
x <<- c(5,7,6,20,4,14,11,12,15,17)
clusterExport(c2,"maxburst")
clusterExport(c2,"x")
clusterEvalQ(c2,maxburst(x,2,mas,rslts))
rslts[,] 

# ------2-barr()-------
rm(list=ls())
findlinks <- function(adj, lnks, counts){
  require(parallel)
  nr <- nrow(adj)
  myidxs <- getidxs(nr)
  myout <- apply(adj[myidxs,],1,function(onerow) which(onerow == 1))
  tmp <- matrix(nrow=0,ncol=2)
  my1strow <- myidxs[1]
  for (idx in myidxs){
    tmp <- rbind(tmp,convert1row(idx,myout[[idx-my1strow+1]]))
  }
  nmyedges <- Reduce(sum,lapply(myout,length)) # numbers of edges found by this thread 
  me <- myinfo$id
  counts[1,me] <- nmyedges # make sure all threads have written to counts
  barr()
  # thread 1 do the warpup -- determine where in lnks the portion of thread 1 ends
  if (me == 1) counts[1,] <- cumsum(counts[1,])
  barr()
  mystart <- if (me == 1) 1 else counts[1,me-1] + 1
  myend <- mystart + nmyedges - 1
  lnks[mystart:myend,] <- tmp
  0
}
convert1row <- function(rownum, colswith1s){ 
  if (is.null(colswith1s)) return(NULL)
  cbind(rownum, colswith1s ) # use recycling 
}

require (Rdsm)
library(parallel)
cls <- makeCluster(2)
mgrinit (cls)
mgrmakevar(cls,"x",6,6)
mgrmakevar(cls,"lnks",36,2)
mgrmakevar(cls,"counts",1,length(cls))
x[,] <- matrix(sample(0:1,36,replace=T),ncol=6) 
clusterExport(cls,"findlinks")
clusterExport(cls,"convert1row") 
clusterEvalQ(cls,findlinks(x,lnks,counts)) 
print(lnks[1:counts[1,length(cls )],])

# ------ all ----------

library(Rdsm)
mykmeans <- function(x,k,ni,cntrds,sums,lck,cinit=NULL){
  # x : data matrix x ; shared
  # k: number of clusters
  # ni : number of iterations
  # cntrds: centroids matrix; row i is centroid i; shared, k by ncol(x)
  # cinit : optional initial values for centroids; by by ncol(x)
  # sums : scratch matrix ; sums[j,] contains count, sum for cluster j;
  #        shared, k by 1+ncol(x)
  # lck : lock variable; shared
  
  require(parallel)
  require(pdist)
  nx <- nrow(x)
  myidxs <- getidxs(nx)
  myx <- x[myidxs,]
  if (is.null(cinit)){
    if (myinfo$id == 1)
      cntrds[,] <<- x[sample(1:nx,k,replace=F),]
    barr()
  }else cntrds[,] <<- cinit
  mysum <- function(idxs,myx){
    c(length(idxs),colSums(myx[idxs,,drop=F]))
  }
  for (i in 1:ni){
    if (myinfo$id == 1){
      sums[] <- 0
    }
    barr()
    dsts <- matrix(pdist(myx,cntrds[,])@dist,ncol=nrow(myx))
    nrst <- apply(dsts,2,which.min)
    tmp <- tapply(1:nrow(myx),nrst,mysum,myx)
    rdsmlock(lck)
    for (j in as.integer(names(tmp))){
      sum[j,1] <- sums[j,] + tmp[[j]]
    }
    rdsmunlock(lck)
    barr()
    if (myinfo$id == 1){
      for (j in 1:k){
        if (sums[j,1]>0){
          cntrds[j,] <<- sums[j,-1] / sums[j,1]
        }else cntrds[j] <<- x[sample(1:nx,1),]
      }
    }
  }
  0
}
require(parallel)
cls <- makeCluster(4)
mgrinit(cls)
mgrmakevar(cls,"x",6,2)
mgrmakevar(cls,"cntrds",2,2)
mgrmakevar(cls,"sums",2,3)
mgrmakelock(cls,"lck")
x[,] <- matrix(sample(1:20,12),ncol=2)
clusterExport(cls,"mykmeans")
clusterEvalQ(cls,mykmeans(x,3,10,cntrds,sums,lck))
