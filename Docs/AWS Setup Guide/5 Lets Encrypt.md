# Step 5: Let's Encrypt (Optional)
This guide is to get SSL Certification, which means that the data is encrypted when being sent between the browser and the server. More information about SSL Certification can be found [here](https://www.instantssl.com/ssl.html).

According to [this source](https://certbot.eff.org/lets-encrypt/ubuntutyakkety-other), use this to install the needed support software:

	sudo apt-get update
	sudo apt-get install software-properties-common
	sudo add-apt-repository ppa:certbot/certbot
	sudo apt-get update
	sudo apt-get install certbot 

Then run the following to obtain the certificate. Note that you should use your own domain name instead of "apolinaro.com":

	sudo certbot certonly --webroot -w /srv/shiny-server -d apolinaro.com

To setup auto-renewal, enter the following:

	sudo certbot renew --dry-run

## References
[About Let's Encrypt](https://letsencrypt.org/getting-started/)
[AWS Encrypt Guide](https://www.r-bloggers.com/shiny-https-securing-shiny-open-source-with-ssl/)
