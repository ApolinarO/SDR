# Default CRAN repo to use
options(repos=structure(c(CRAN="http://cran.uk.r-project.org")))

# Installs packages if needed
if(!require(shiny)) install.packages("shiny")
if(!require(rsconnect)) install.packages("rsconnect")
library(rsconnect)

# Deploys app to server
deployApp(appDir="deploy", appName="CORE_TEST", contentCategory="application", lint=T, launch.browser=T, upload=T)