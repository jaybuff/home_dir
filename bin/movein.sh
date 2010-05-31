#!/bin/bash

# clone the home_dir repo on git hub and scp it to my home dir 
# on a remote system
# 
# once you're own the remote host you can do 
# alias config="git --git-dir=$HOME/.config.git/ --work-tree=$HOME"
# config pull origin master
# to get updates (you'll need to install git first)
# see http://www.silassewell.com/blog/2009/03/08/profile-management-with-git-and-github/

# die on error
# echo commands as they're run
set -x -e

# this is probably a new host, so don't check the host key so ssh won't prompt
SSH_CMD="ssh -o StrictHostKeyChecking=no"

DEST_HOST=$1

if [ "$DEST_HOST" == "" ]; then
    echo "Usage $0 <hostname>"
    exit 1
fi

HOMEDIR_TMPDIR=`mktemp -d /tmp/homedirXXXXXX`
git clone git@github.com:jaybuff/home_dir.git $HOMEDIR_TMPDIR
mv $HOMEDIR_TMPDIR/.git $HOMEDIR_TMPDIR/.config.git
pushd $HOMEDIR_TMPDIR && tar -cf - ./ | $SSH_CMD $DEST_HOST "sudo -u $USER tar -xf - -C ~$USER && popd
rm -rf $HOMEDIR_TMPDIR
