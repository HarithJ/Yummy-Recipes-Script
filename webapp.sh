#!/bin/bash

# setup the environment for Yummy recipes
setup () {
  printf '=================================== Setting up the environment ============================================ \n'

  sudo add-apt-repository ppa:deadsnakes/ppa
  sudo apt-get update
  sudo apt-get install python3.6
  sudo apt-get install build-essential python3.6-dev nginx

  wget https://bootstrap.pypa.io/get-pip.py
  sudo python3.6 get-pip.py

  sudo apt install python3.6-venv
}

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get the project and set it up
project () {
  printf '=================================== Setting up the Project ============================================ \n'

  cd $HOME
  mkdir Yummy-Recipes
  cd Yummy-Recipes

  python3.6 -m venv venv
  git clone https://github.com/HarithJ/Yummy-Recipes-Ch3.git
  source venv/bin/activate
  cd Yummy-Recipes-Ch3

  pip install -r requirements.txt
}

setupUwsgiServer () {
  printf '=================================== Setting up uwsgi server ============================================ \n'

  pip install uwsgi

  cp $scriptDir/uwsgi.ini $PWD
  sudo cp $scriptDir/yummy-recipes.service /etc/systemd/system/

  sudo systemctl start yummy-recipes
  sudo systemctl enable yummy-recipes
}

setupNginxServer () {
  printf '=================================== Setting up Nginx server ============================================ \n'

  sudo cp $scriptDir/yummy-recipes /etc/nginx/sites-available/
  sudo ln -s /etc/nginx/sites-available/yummy-recipes /etc/nginx/sites-enabled
  sudo nginx -t
  sudo systemctl restart nginx

  sudo ufw allow 'Nginx Full'
}

createNginxSettingFile () {
  sudo cat > $scriptDir/yummy-recipes <<EOF
server {
    listen 80;
    server_name ${1};

    location / {
        include uwsgi_params;
        uwsgi_pass unix:/home/ubuntu/Yummy-Recipes/Yummy-Recipes-Ch3/yummy-recipes.sock;
    }
}
EOF
}

run () {
  setup
  project
  setupUwsgiServer
  setupNginxServer
}

run
