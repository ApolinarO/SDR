# Server Admin Guides
The following guide is meant to help you get started in maintaining the project. It will cover the topics in the following order:

1. Get Project From Github
2. RShiny Setup
	(Optional): Deploying A Project To ShinyApps IO
3. AWS Server Setup & Shiny Server Configuration
	(TO DO): install the shiny app
4. AWS Server Maintenance & DNS Setup
	(Optional): DNS Setup

## Author(s)
- Apolinar Ortega



# AWS Notes.md
## Server Configuration File
/etc/shiny-server/shiny-sever.conf

_Default Port_: 3838
_Default Server Folder_: /srv/shiny-server
_Degault Log Folder_: /var/log/shiny-server/

## Create symlink to server
sudo ln -s path/to/file /srv/shiny-server/name
-sf to update symlink

## SCP Transfer
scp -i pibkey.pem files ubuntu...:~

## Update Server From Github
rm -rf ./sdr
git clone https://github.com/apolinaro/sdr


## References
- (Shiny Servers Setup)[http://docs.rstudio.com/shiny-server/]
- (AWS Shiny Tutorial)[https://www.r-bloggers.com/installing-rstudio-shiny-server-on-aws/]