# Step 4: AWS Server Restart and DNS Setup

This spike is to walk you through restarting the AWS server.

## Restart The Server

To restart your server, log into your AWS account and navigate to EC2 or "Launch A Virtual Machine". You should eventualy end up on a page that lists instances. Locate the server you want to restart, right click, and restart it.

Note that the public IP has likely changed. You will now have to update your DNS if you have one. Simple copy the ip address and get the hosting port number for shiny server, which is most likely 3838. Set the DNS to "forward and mask" with a permanent address of "ip:port", where ip is the new ip address and port is 

The publuc IP has likely changed and you will need to update your DNS if you already have one. Set your DNS to "ip:port", where ip is your new IPv4 address and port is the port number for shiny-server, which is most likely 3838. 

## Setting Up A Domain Name (Optional)

Setting up a domain name is very simple. All it involves is buying a spot in a Domain Name Server (DNS) and giving it an IP adress to run on. Some of the biggest DNS vendors includes Amazon and GoDaddy.

Once you bought your DNS, use a configuration similar to the one below for your DNS setup:

![Forward To ServerIP:Port#, Permanent Forward Type, Forward With Masking](./img/DNS\ Configuration.png "Sample DNS Configuration")

When restarting your AWS server, be sure to update the Forward To field to your current IP and the port number.
