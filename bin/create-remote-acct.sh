#!/bin/bash

# this script lives on github at http://github.com/jaybuff/home_dir/blob/master/bin/create-remote-acct.sh
#
# I use it like this:
# bin/create-remote-acct.sh ubuntu@ec2-75-101-196-155.compute-1.amazonaws.com


set -x -e 

DEST_HOST=$1

if [ "$DEST_HOST" == "" ]; then 
    echo "Usage $0 <hostname>"
    exit 1
fi

echo "Creating account for $USER on $DEST_HOST and adding to /etc/sudoers"
SSH_OPTIONS="-o StrictHostKeyChecking=no"
ssh $DEST_HOST $SSH_OPTIONS "sudo adduser $USER --disabled-password --gecos 1 --no-create-home && echo '$USER ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
