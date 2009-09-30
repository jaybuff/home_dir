#!/bin/bash

# clone the home_dir repo on git hub and scp them all to my home dir 
# on a remote system

DEST_HOST=$1

if [ "$DEST_HOST" == "" ]; then
    echo "Usage $0 <hostname>"
    exit 1
fi

HOMEDIR_TMPDIR=`mktemp -d /tmp/homedirXXXXXX`
git clone git@github.com:jaybuff/home_dir.git $HOMEDIR_TMPDIR
shopt -s dotglob
scp -p -r -o StrictHostKeyChecking=no $HOMEDIR_TMPDIR/* $DEST_HOST:~/
rm -rf $HOMEDIR_TMPDIR
