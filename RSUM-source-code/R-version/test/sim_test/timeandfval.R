timeandfval <- function(cor,lambda){
  # --- load data ----
  oldresults_data_path <- paste("results/n1000p100",cor,"lambda1e",log10(lambda),".Rdata",sep="")
  load(oldresults_data_path)
  source("test/sim_test/ubforlogit_random_new.R")
  # --- load function -----
  rm(r3)
  data_path <- paste("test/sim_test/sim_n1000p100",cor,".Rdata",sep="")
  load(data_path)
  r3 <- list()
  for (i in seq_len(10)){
    r3[[i]]<- ubforlogit_random_new (x, y, lambda)
    print(paste("finish",i,"round"))
  }
  r3_time <- rep(0,10)
  for (i in seq_len(10)){
    r3_time[i]<- r3[[i]]$time
  }
  r3.time <- as.difftime(mean(r3_time),units="mins")
  r3_objval <- rep(0,10)
  for (i in seq_len(10)){
    r3_objval[i]<- min(r3[[i]]$fvalue_normalized)
  }
  r3.object_value_norm <- mean(r3_objval)
  r4_time <- rep(0,10)
  for (i in seq_len(10)){
    r4_time[i]<- r4[[i]]$time
  }
  r4.time <- as.difftime(mean(r4_time),units="mins")
  r4_objval <- rep(0,10)
  for (i in seq_len(10)){
    r4_objval[i]<- min(r4[[i]]$fvalue_normalized)
  }
  r4.object_value_norm <- mean(r4_objval)
  time <- c(r1$time,r2$time,r3.time,r4.time)
  fval <- c(min(r1$fvalue_normalized),min(r2$fvalue_normalized),
            r3.object_value_norm,r4.object_value_norm)
  # ---- save results
  savepath <- paste("results/n1000p100time/p_round_check/",cor,"lambda1e",
                    log10(lambda),".Rdata",sep="")
  results <- list(r1=r1,r2=r2,r3=r3,r4=r4,time,fval)
  save(results,file=savepath)
  print(paste("resutlts have been saved in",savepath))
}