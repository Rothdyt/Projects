library(rpart)
library (tree)
rm(list = ls())
NIPPV <- read.table("NIPPV.txt")
NIPPV.s=cbind(NIPPV[,1],scale(NIPPV[,2:8]),NIPPV[,9])
set.seed(12)
x=sample(1:144,28)
NIPPV.test=NIPPV.s[x,]
NIPPV.train=NIPPV.s[-x,]
NIPPV.train=as.data.frame(NIPPV.train)
NIPPV.test=as.data.frame(NIPPV.test)
NIPPV.train=as.data.frame(NIPPV.train)
NIPPV.train[,9][NIPPV.train[,9]>0.5]="Y"
NIPPV.train[,9][NIPPV.train[,9]<0.5]="N"
fix(NIPPV.train)
NIPPV.tree1<- tree(NIPPV.train$`Curative_effect`~., data=NIPPV.train, method="class")
plot(NIPPV.tree1)
text(NIPPV.tree1,pretty =0)

set.seed (2)
cv.N =cv.tree(NIPPV.tree1 ,FUN=prune.misclass )
par(mfrow =c(1,2))
plot(cv.N$size ,cv.N$dev ,type="b")
plot(cv.N$k ,cv.N$dev ,type="b")


prune.N =prune.misclass(NIPPV.tree1,best =5)
summary(prune.N)
plot(prune.N)
text(prune.N,pretty =0)

tree.pred= (predict(prune.N,NIPPV.test,type="class" ))
table(tree.pred,NIPPV.test$??????)


