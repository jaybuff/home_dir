#!/bin/bash

# this script lives on github at http://github.com/jaybuff/home_dir/blob/master/bin/create-remote-acct.sh

DEST_HOST=$1

if [ "$DEST_HOST" == "" ]; then 
    echo "Usage $0 <hostname>"
    exit 1
fi

echo "Creating account for $USER on $DEST_HOST and adding to /etc/sudoers"
SSH_OPTIONS="-o StrictHostKeyChecking=no"
ssh root@$DEST_HOST $SSH_OPTIONS "adduser $USER --disabled-password --gecos 1 && echo '$USER ALL=NOPASSWD: ALL' >> /etc/sudoers"
