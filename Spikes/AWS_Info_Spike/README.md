# Server Admin Guides

The following guide is meant to help you get started in maintaining the project. It will cover the topics in the following order:

1. Github setup and cloning the project
2. RShiny on the local machine
	(Optional): Setting up the project on _ShinyApps_.io
3. AWS Server Setup & RShiny Configuration
4. AWS Server restart
	(Optional): DNS Setup


## Notes
- 1 Completed
- 2 Current
- 3 TO DO
- 4 Completed

## Connecting To The Server

Make sure that you downloaded the .pem file containing the key. Launch your terminal and follow the instructions that are listed when right clicking the instance and selecting connect.

The command to ssh into the server looks something like the following

	ssh -i 'path/to/thekey.pem' ubuntu@ec2-ip-of-server,us-east-2.compute.amazonaws.com

An example command below

	ssh -i '~/Documents/AWSKey/apolinaro_mac.pem' ubuntu@ec2-18-188-72-92.us-east-2.compute.amazonaws.com

