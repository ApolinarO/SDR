#' Add together two numbers
#'
#' @param x A number
#' @param y A number
#' @return The sum of \code{x} and \code{y}
#' @examples
#' add(1, 1)
#' add(10, 1)
add <- function(x, y) {
  x + y
}
system("ls")
library(roxygen2)
roxygen2::roxygenise()

#- We will use [ROxygen2](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html) to generate documentation.