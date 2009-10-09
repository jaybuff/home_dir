#!/bin/bash

# this script is originally from
# http://github.com/jaybuff/home_dir/blob/master/bin/ec2-hostname-from-instance-id.sh 

INSTANCE_ID=$1

if [ "$INSTANCE_ID" == "" ]; then
    echo "Usage $0 <instance id>"
    exit 1
fi

until [[ "$EC2_HOSTNAME" =~ 'amazonaws.com'  ]]; do 
    EC2_HOSTNAME=`ec2-describe-instances $INSTANCE_ID |grep ^INSTANCE |awk '{ print $4 }'`
done
echo $EC2_HOSTNAME
