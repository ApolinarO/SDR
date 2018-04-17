# Cost Analysis: AWS vs ShinyApps io

It worth to note that users don't need to download more than 1 or two files at a time so 1GB of ram is enough for most tasks. Note that there are ~720 hours in a month when looking at monthly allowances.

It is much easier to setup a web application on _ShinyApps_.io when compared to AWS. Using _ShinyApps_.io, you can publish you app with the click of a button in RStudio. On AWS, you would need to commit the changes onto Github and then update the local repository located on the server.

## AWS

The free tier allows for a t2.micro which is limited to 1GB memory, 8GB storage, and a single processing unit w/ 2.4 GHz. The free tier allows it to be free for up to to 12 months and allots for 750 hours per month. The current cost of the micro unit is $0.012/hour, $0.288/day, $2.02/week, $8.64/month, and $105/year.

There is anoption to pay for costs up front for 3 years, which brings the 3-year price from $306 to $137. Another option would be to use a t2 nano instance which allows for 512MB of ram and is half the cost.

### Additional AWS Costs

For each server, there is a monthly charge of $0.10/GB of storage being used. Considering that NHANES is less than 4GB, the cost amounts to about $4.80/year. There's also a charge of $0.09/GB of bandwidth with a free GB of transfer allotted per month. Assuming the app were to get 1GB-worths of traffic per day for the year, that would amount to about $32/year in costs.

## ShinyApps io

The free version allows for 25 active hours per month with a storage size of 1GB.

For the paid tiers, when you go voer your alloted hours, you are charged for them. The starter tier is $9/month or $100/year and  allows for up to 5GB of ram and at least 4GB of memory. The basic tier is $39/month or $468/year and has 8GB of memory with 500 active hours per month.

## References
AWS
* [Cost Estimation](http://calculator.s3.amazonaws.com/index.html)
* [T2 Micro Instance Details](https://aws.amazon.com/marketplace/pp/B01JBL2M0O?ref=cns_1clkPro)
* [Server Size Options](https://aws.amazon.com/marketplace/pp/B00JV9TBA6?qid=1522823767432&sr=0-4&ref_=srh_res_product_title)
* [Bandwidth Costs](https://aws.amazon.com/ec2/pricing/on-demand/)
* [Storage Costs](https://aws.amazon.com/marketplace/pp/B01JBL2M0O?qid=1523391228967&sr=0-3&ref_=srh_res_product_title)

_ShinyApps_.io
* [Cost Comparisons](http://www.shinyapps.io/)
* [Instance Sizes](http://docs.rstudio.com/shinyapps.io/applications.html)
