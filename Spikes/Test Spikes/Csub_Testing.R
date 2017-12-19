library(RUnit)

csub.test <- function(a) {
  # Creating 20x10 test Data Frame #
    x1 <- rep(1,20)
    x2 <- rep(2,20)
    x3 <- rep(3,20)
    x4 <- c(rep(1,5),rep(2,5),rep(3,5),rep(4,5))
    x5 <- rep(NA,20)
    x6 <- rep(TRUE,20)
    x7 <- rep("Char",20)
    x8 <- c(TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE)
    x9 <- rep(6,20)
    x10 <- rep(8,20)
  df.1 <- data.frame(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10)
  # work #
  df.csub <- df.1[,a]
  return(df.csub)
}

csub.test(7)==rep("Char",20)

csub.testing <- function() {
checkEquals(csub.test(1),rep(1,20))
checkEquals(csub.test(2),rep(2,20))
checkEquals(csub.test(3),rep(3,20))
checkEquals(csub.test(4),c(rep(1,5),rep(2,5),rep(3,5),rep(4,5)))
checkEquals(csub.test(5),rep(NA,20))
checkEquals(csub.test(7),rep("Char",20))
checkEquals(csub.test(8),c(TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE))
checkEquals(csub.test(9),rep(6,20))
checkEquals(csub.test(10),rep(8,20))
checkEquals(csub.test(6),rep(TRUE,20))

checkEquals(csub.test("x1"),rep(1,20))
checkEquals(csub.test("x2"),rep(2,20))
checkEquals(csub.test("x3"),rep(3,20))
checkEquals(csub.test("x4"),c(rep(1,5),rep(2,5),rep(3,5),rep(4,5)))
checkEquals(csub.test("x5"),rep(NA,20))
checkEquals(csub.test("x6"),rep(TRUE,20))
checkEquals(csub.test("x7"),rep("Char",20))
checkEquals(csub.test("x8"),c(TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE))
checkEquals(csub.test("x9"),rep(6,20))
checkEquals(csub.test("x10"),rep(8,20))
}

csub.testing()


