#!/bin/bash

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6
sudo apt-get install build-essential python3.6-dev

wget https://bootstrap.pypa.io/get-pip.py
sudo python3.6 get-pip.py

sudo apt install python3.6-venv

mkdir Yummy-Recipes
cd Yummy-Recipes

python3.6 -m venv venv
git clone https://github.com/HarithJ/Yummy-Recipes-Ch3.git
source venv/bin/activate
cd Yummy-Recipes-Ch3

pip install -r requirements.txt

pip install uwsgi

uwsgi --socket 0.0.0.0:5000 --wsgi-file run.py --callable app --processes 4 --threads 2
