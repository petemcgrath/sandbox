#!/usr/bin/env bash

# Base Box
sudo apt-get update -y

# # Ruby 2.3.3
which ruby-install &> /dev/null
if [ $? -ne 0 ]; then
  echo "Installing Ruby 2.3.3"
  cd $HOME
  wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz
  tar -xzvf ruby-install-0.6.1.tar.gz
  cd ruby-install-0.6.1/
  sudo make install
  sudo ruby-install --system ruby 2.3.3
  rm -rf ruby-install-0.6.0
  rm ruby-install-0.6.0.tar.gz
fi

# # Git
which git &>/dev/null
if [ $? -eq 0 ]; then
  echo "Installing git"
  sudo apt-get install git -y
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.ci commit
  git config --global alias.st status
  git config --global push.default simple
fi

# # Node.js
# ######################
#  Doesn't work
which nodejs &>/dev/null
if [ $? -ne 0 ]; then
  echo "Installing nodejs"
  sudo apt-get install nodejs
fi

# # PostgreSQL
which psql &>/dev/null
if [ $? -ne 0 ]; then
  echo "Installing postgresql 9.3"
  sudo apt-get install -y build-essential libpq-dev postgresql postgresql-contrib
  sudo -u postgres createuser --superuser vagrant
  # no password required
  sudo sh -c 'echo "local all postgres trust\nlocal all all trust\nhost all all 127.0.0.1/32 trust" > /etc/postgresql/9.3/main/pg_hba.conf'
  sudo service postgresql restart
fi

# # Bundler
which bundle &>/dev/null
if [ $? -ne 0 ]; then
  echo "Installing bundler"
  sudo gem install bundler
fi

# # Heroku Toolbelt
which heroku &>/dev/null
if [ $? -ne 0 ]; then
  echo "Installing heroku toolbelt"
  wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi

# # GraphicsMagick
sudo apt-get install -y graphicsmagick

# # Environment
################
# Doesn't work
grep RACK_ENV ~/.bash_profile
if [ $? -ne 0 ]; then
  echo "export PORT='6666'" >> ~/.bash_profile
  echo "export RACK_ENV='development'" >> ~/.bash_profile

  # Helpful aliases
  echo "alias run='rails server -b 0.0.0.0 -p 6666'" >> ~/.bash_profile

  # Helpful start directory
  echo "cd /vagrant" >> ~/.bash_profile

  source ~/.bash_profile
fi

# # Add test domains /etc/hosts
grep sandbox /etc/hosts
if [ $? -ne 0 ]; then
  # echo "127.0.1.1 sandbox sandbox" | sudo tee -a /etc/hosts
fi

# # Rails
# cd /vagrant
# bundle
# rake db:create
# rake db:migrate
# rake db:test:prepare
# rake
