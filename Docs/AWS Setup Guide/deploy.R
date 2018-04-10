# Default CRAN repo to use
options(repos=structure(c(CRAN="http://cran.uk.r-project.org")))

# Installs packages if needed
if(!require(shiny)) install.packages("shiny")
if(!require(rsconnect)) install.packages("rsconnect")
library(rsconnect)

# Deploys app to server
deployApp(appDir="./sample_app", appName="sample_app_from_spikes", contentCategory="application", lint=T, launch.browser=T, upload=T)