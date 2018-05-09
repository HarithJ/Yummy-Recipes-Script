# Yummy-Recipes-Script
This contains script which is there to automate the installing of necessary dependecies inorder for it to run [Yummy-Recipes](https://github.com/HarithJ/Yummy-Recipes-Ch3) webapp.

This script is tested on Ubuntu 16.04.

### Instructions to run it
Clone this repo:

```git clone https://github.com/HarithJ/Yummy-Recipes-Script/edit/master/README.md```

And cd into the folder:

```cd Yummy-Recipes-Script```

Than run the script, with an argument which is an ip address on which you are running the app on or domain name:

```source webapp.sh [ip address/domain name]```


### Running it on AWS
1. Create an EC2 instance, with AMI as `Ubuntu Server 16.04`.
2. In security group, allow TCP port 5000.
3. Launch the instance.
4. Log into your instance.
5. Clone this repo:

```git clone https://github.com/HarithJ/Yummy-Recipes-Script/edit/master/README.md```

6. Than run the script, with an argument which is an ip address on which you are running the app on or domain name:

```source webapp.sh [ip address/domain name]```
