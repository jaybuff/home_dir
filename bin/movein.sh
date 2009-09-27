#!/bin/bash

sudo apt-get update -y
sudo apt-get install git git-core -y
ssh -o StrictHostKeyChecking=no github.com # avoid pesky knownhosts check 
git clone git@github.com:jaybuff/home_dir.git ~/config.git
rm -rf ~/.ssh .bashrc # will be built from the git repo
mv ~/config.git/.git ~/.config.git
shopt -s dotglob
mv -i ~/config.git/* ~/
rmdir ~/config.git
