#!/bin/bash
# make sure that ssh access is available:
# ec2-authorize default -P tcp -t 22

set -x -e 

# server Ubuntu 10.04 Lucid Canonical, ubuntu us-east-1
AMI_ID=ami-2d4aa444 
KEYPAIR=jaybuffkey
echo "Booting AMI $AMI_ID"
INSTANCE_ID=`ec2-run-instances $AMI_ID -g webserver -g default -k $KEYPAIR |grep ^INSTANCE |awk '{print $2}'`
echo "Started $INSTANCE_ID  Getting host name\n"

DIR=`dirname $0`
EC2_HOSTNAME=`$DIR/ec2-hostname-from-instance-id.sh $INSTANCE_ID`
$DIR/wait-for-ssh.sh $EC2_HOSTNAME
$DIR/create-remote-acct.sh ubuntu@$EC2_HOSTNAME
$DIR/movein.sh ubuntu@$EC2_HOSTNAME

echo "Created $EC2_HOSTNAME"
