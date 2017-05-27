rm(list = ls())
NIPPV <- read.table("NIPPV.txt")
NIPPV.s=cbind(NIPPV[,1],scale(NIPPV[,2:8]),NIPPV[,9])
set.seed(12)
x=sample(1:144,28)
NIPPV.test=NIPPV.s[x,]
NIPPV.train=NIPPV.s[-x,]
NIPPV.train=as.data.frame(NIPPV.train)
NIPPV.test=as.data.frame(NIPPV.test)
X=NIPPV.train[,1:8]
Y=NIPPV.train[,9]
library(glmnet)
N.glm <- glmnet(x=as.matrix(X),y=as.matrix(Y),family="binomial")
plot(N.glm,xvar="lambda",label=TRUE)
###CV
X=NIPPV.train[,1:8]
Y=NIPPV.train[,9]
X=as.matrix(X)
Y=as.matrix(Y)
set.seed(1000)
reslut.cv=cv.glmnet(X,Y,family="binomial")
plot(cv.glmnet(X,Y))
reslut.cv$lambda.1se
N.final=reslut.cv$glmnet

Npre=predict(reslut.cv$glmnet.fit,newx=NIPPV.test,s=reslut.cv$lambda.1se,type="response")
N.pr=rep(0,28)
N.pr[pre$fit>0.5]=1
table(N.pr,NIPPV.test$V9)
pre1=predict(N.glm,newdata=NIPPV.train,s=reslut.cv$lambda.1se,type="response")
N.pr1=rep(0,116)
N.pr1[pre1$fit>0.5]=1
table(N.pr1,NIPPV.train$V9)



result1=result+lamd*sum(abs(N.coef))
result.train=rep("N",116)
result.train[result>0.5]="Y"


real.train=rep("N",116)
real.train[NIPPV.train[,9]>0.5]="Y"



X1=NIPPV.test[,1:8]
Y1=NIPPV.test[,9]
X1=as.matrix(X1)
Y1=as.matrix(Y1)

result2=X1%*%N.coef[2:9,]+N.coef[1,]
result2=result2+lamd*sum(abs(N.coef))
result.test=rep("N",28)
result.test[result2>0.5]="Y"


real.test=rep("N",28)
real.test[NIPPV.test[,9]>0.5]="Y"
table(result.test,real.test)
