library(shiny)
library(DT)
library(ISLR)
library(testthat)
library(RSelenium)

setwd("/home/tony/SD/SDR/Docs/Spikes/Selenium_Spike/")

remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445L, browserName = "firefox'")
runApp("shinytestapp1", port = 4444, launch.browser = 'T')

