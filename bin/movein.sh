#!/bin/bash

# clone the home_dir repo on git hub and scp it to my home dir 
# on a remote system
# 
# once you're own the remote host you can do 
# alias config="git --git-dir=$HOME/.config.git/ --work-tree=$HOME"
# config pull origin master
# to get updates (you'll need to install git first)
# see http://www.silassewell.com/blog/2009/03/08/profile-management-with-git-and-github/

DEST_HOST=$1

if [ "$DEST_HOST" == "" ]; then
    echo "Usage $0 <hostname>"
    exit 1
fi

HOMEDIR_TMPDIR=`mktemp -d /tmp/homedirXXXXXX`
git clone git@github.com:jaybuff/home_dir.git $HOMEDIR_TMPDIR
mv $HOMEDIR_TMPDIR/.git $HOMEDIR_TMPDIR/.config.git
shopt -s dotglob
# this is probably a new host, so don't check the host key 
# so scp won't prompt (useful in scripts)
scp -p -r -o StrictHostKeyChecking=no $HOMEDIR_TMPDIR/* $DEST_HOST:~/
rm -rf $HOMEDIR_TMPDIR
