#!/bin/bash

# poll port 22 on a host until it becomes available
# this is useful for waiting for a host to become available while it's booting

# this script is originally from
# http://github.com/jaybuff/home_dir/blob/master/bin/wait-for-ssh.sh

set -x -e

DEST_HOST=$1

if [ "$DEST_HOST" == "" ]; then
    echo "Usage $0 <hostname>"
    exit 1
fi

echo -ne "Waiting for ssh to become available"
until [[ `echo "" |nc -w 1 $DEST_HOST 22` ]]; do 
    echo -ne "."
done
echo
