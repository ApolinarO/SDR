#  loading Packages  #
library("RUnit")

#  Creating Data for Testing  #
x1.1 <- rep(1,100)
x2.1 <- rep(2,100)
x3.1 <- rep(3,100)
x4.1 <- rep("Yes",100)
x5.1 <- rep(NA,100)
x6.1 <- rep(TRUE,100)
x7.1 <- c(rep(1,10),rep(NA,10),rep(TRUE,10),rep(FALSE,10),rep("Char",10),rep(1,50))
df.1 <- data.frame(x1.1,x2.1,x3.1,x4.1,x5.1,x6.1,x7.1)

x1.2 <- rep(1,100)
x2.2 <- rep(2,100)
x3.2 <- rep(3,100)
x4.2 <- rep("Char",100)
x5.2 <- rep(NA,100)
x6.2 <- rep(FALSE,100)
x7.2 <- c(rep(9,10),rep(3,10),rep(TRUE,10),rep(FALSE,10),rep("A",10),rep(999,20),rep(000,20),rep(1,10))
df.2 <- data.frame(x1.2,x2.2,x3.2,x4.2,x5.2,x6.2,x7.2)

#  Column Subsetting  #
df.col.sub.name.1 <-df.1$x1.1
df.col.sub.name.1 
df.col.sub.ind.1 <- df.1[,1]
df.col.sub.ind.1

df.col.sub.name.2 <-df.1$X1.1
df.col.sub.name.2
df.col.sub.ind.2 <- df.1[,9]

#  Column Merging  #

cm.1 <- cbind(df.col.sub.name.1,df.col.sub.ind.1)
head(cm.1)

#  Row subsetting  #
rs.1 <- df.1[1:45,]
rs.1
rs.2 <- df.1[df.1[,7]=="Char",]
rs.2
rs.3 <- df.2[df.2[,7]==999,]
rs.3


#  Data Frame Stacking and Merging  #

#  RUnit test  #

x1.3 <- rep(1,5)
x2.3 <- rep(4,5)
x3.3 <- rep("Char",5)
x4.3 <- rep(TRUE,5)
df.3 <- data.frame(x1.3,x2.3,x3.3,x4.3)
df.3
df.3.1 <- data.frame(x1.3,x2.3)
df.3.2 <- data.frame(df.3[,2:4])
df.3.3 <- data.frame(x2.3)


test.1 <- function() {
  checkEquals(cbind(x1.3,x2.3),df.3.1)
  checkEquals(cbind(x2.3,x3.3,x4.3),df.3.2)
  checkEquals(cbind(x1.3,x2.3),df.3.3)
  checkException(cbind("xx"))
}

















