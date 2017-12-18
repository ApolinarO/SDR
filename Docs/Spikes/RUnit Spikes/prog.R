# This is a ssimple test library with simple functions to test

if(!require(pracma)){
  install.packages("pracma")
}
library("pracma")

round2 = function(x, n=0)
{
  # Rounds a number to a decimal place
  #
  # Args:
  #  x: the number to round
  #  n: decimal places to round to
  #
  # Returns: the number rounded to n-decimal places
  
  posneg = sign(x)
  z = abs(x) * 10^n
  z = z + 0.5
  z = trunc(z)
  z = z / 10^n
  return(z*posneg)
}

fraction.to.string = function(num, den)
{
  # Turns a fraction into a string or whole number
  #
  # Args:
  #  num: numerator
  #  den: denominator
  #
  # Returns: simplified fraction or a whole number as a string
  
  frac = c(num, den) 
  frac = frac/gcd(frac[1], frac[2]) # Simplifies the fraction
  frac = c(abs(frac[1])*sign(prod(frac)), abs(frac[2])) # Moves ± sign to numerator
  
  return(c(paste0(frac, collapse="/"), frac[1])[(frac[2]==1)+1]) # '2/1' vs '2'
}

print("I'm just a simple function call. Don't mind me.")