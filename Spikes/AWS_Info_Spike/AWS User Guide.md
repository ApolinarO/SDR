# AWS user Guide

The purpose of this spike is to get basic info about the NHANES data set.

## Connecting To The Server

Make sure that you downloaded the .pem file containing the key. Launch your terminal and follow the instructions that are listed when right clicking the instance and selecting connect.

The command to ssh into the server looks something like the following

	ssh -i 'path/to/thekey.pem' ubuntu@ec2-ip-of-server,us-east-2.compute.amazonaws.com

An example command below

	ssh -i '~/Documents/AWSKey/apolinaro_mac.pem' ubuntu@ec2-18-188-72-92.us-east-2.compute.amazonaws.com


## Restart The Server

To restart your server, log into your AWS account and navigate to EC2 or "Launch A Virtual Machine". You should eventualy end up on a page that lists instances. Locate the server you want to restart, right click, and restart it.

Note that the public IP has likely changed. You will now have to update your DNS if you have one. Simple copy the ip address and get the hosting port number for shiny server, which is most likely 3838. Set the DNS to "forward and mask" with a permanent address of "ip:port", where ip is the new ip address and port is 

The publuc IP has likely changed and you will need to update your DNS if you already have one. Set your DNS to "ip:port", where ip is your new IPv4 address and port is the port number for shiny-server, which is most likely 3838. 

