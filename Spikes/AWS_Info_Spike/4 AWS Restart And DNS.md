# Step 4: AWS Server Restart & DNS Setup
The purpose of this guide is to walk you through the steps of restarting an AWS server and to setup a DNS for the app.

## Restart The Server
You can either reboot the server using the terminal or through AWS itself.

### Rebooting From Terminal
When logged into the server, enter the following command:

	sudo reboot

### Rebooting From AWS
Log into your AWS account and navigate to EC2.
![Services > EC2](./img/EC2MenuFind.png "Finding EC2 From the Homepage")

Go to where AWS lists instances and right click the server instance. Select "Reboot".
![Locate Instances on the sidebar](./img/RebootServer.png "Reboot Server")


## Setting Up A Domain Name (Optional)
Setting up a domain name is very simple. All it involves is buying a spot in a Domain Name Server (DNS) and giving it an IP adress to run on. Some of the biggest DNS vendors includes Amazon and GoDaddy.

Once you bought your DNS, setup its configuration similar to the one below:

![Forward To ServerIP:Port#, Permanent Forward Type, Forward With Masking](./img/DNSConfig.png "Sample DNS Configuration")

When restarting your AWS server, be sure to update the Forward To field to your current IP and the port number.
