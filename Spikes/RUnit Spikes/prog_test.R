
source("prog.R")  # Inports functions from a local R file
library("RUnit")

# Tests regular call
test.frac.to.string <- function(){
  fracs <- fraction.to.string(1, 2)
  checkEquals(fracs, "1/2")
}

# Meant to fail
test.frac.to.string.fail <- function(){
  fracs <- fraction.to.string(1, 2)
  checkEquals(fracs, "1/3")
}

test.frac.to.string.simplify <- function(){
  fracs <- fraction.to.string(2, 6)
  checkEquals(fracs, "1/3")
}

test.frac.to.string.whole.number <- function(){
  fracs <- fraction.to.string(4, 1)
  checkEquals(fracs, "4")
}

test.frac.to.string.whole.number.simplified <- function(){
  fracs <- fraction.to.string(4, 2)
  checkEquals(fracs, "2")
}

# Tests for exceptions thrown
test.frac.to.string.invalid.arguments <- function(){
  checkException(fraction.to.string("1", "2"))
}

test.frac.to.string.valid.arguments <- function(){
  checkException(fraction.to.string(1, 2))
}
