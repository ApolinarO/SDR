# Core

## Developer(s)
* Antonio

## About
The purpose of this core is have a platform to build off of for our R Shiny project

## What You Need To Run This
* Bash Shell
    * To run the applications
* R
    * To run the applications
* MySQL Server
    * This is to run the backup and update database commands
    * See the section for running the database comands for more info

## Running Commands
To run the commands, you would need to first start your bash shell. From there, move into the directory that this readme and this makefile is within.

### Deploy Application
    make deploy

This deploys your application to shinyapps.io.

Before running this command, make sure that you have an account at shinyapps.io. Also run the following command in R:

    setAccountInfo("user", "token", "secret")

Note that "user" should be replaced by your username, "token" by your token, and "secret" by your secret. All this can be found on your shinyapps.io account.

### Run Tests
    make run_tests
This command would run unit tests. For now, it runs a simple application.

### Update & Backup Database
    make update_db

This updates your local database from a local .sql file.

    make backup_db

This backs up your database onto a local .sql file. This new file can be used to update your database if there were changes made to it after your database was last updated.

If you never ran the database commands, then you need to perform the following first:
1. Create a connection in you database
2. Create a database called "Test_DB"
3. Run the make update_db command to populate your newly created database

### Misc Commands
    make clean
This command cleans up the directory before it is submitted to Github. For now, all it does is remove the .sql generated from the backup command.

    make hello
This command is called from the R Script called in the run tests command.

