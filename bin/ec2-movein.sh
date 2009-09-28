#!/bin/bash

MY_HOST=$1

if [ "$MY_HOST" == "" ]; then 
    echo "Usage $0 <hostname>"
    exit 1
fi

echo "Creating account for $USER on $MY_HOST and adding to /etc/sudoers"
SSH_OPTIONS="-o StrictHostKeyChecking=no"
ssh root@$MY_HOST $SSH_OPTIONS "adduser $USER --disabled-password --gecos 1 && echo '$USER ALL=NOPASSWD: ALL' >> /etc/sudoers"

echo "Setting up ssh"
cat ~/.ssh/*.pub | ssh root@$MY_HOST $SSH_OPTIONS "sudo -u $USER mkdir ~$USER/.ssh/ && cat - >> ~$USER/.ssh/authorized_keys"
scp ~/.ssh/id_dsa $MY_HOST:~/.ssh/

echo "Setting up first login script"
scp ~/bin/first-login.sh $MY_HOST:~/
ssh $MY_HOST 'echo "~/first-login.sh && rm ~/first-login.sh" >> .bashrc'

echo "ssh'ing to $MY_HOST and running move in script"
exec ssh $MY_HOST
