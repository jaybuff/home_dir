#!/bin/bash
# make sure that ssh access is available:
# ec2-authorize default -P tcp -t 22

set -x -e 

# server Ubuntu 10.04 Lucid Canonical, ubuntu us-east-1
AMI_ID=ami-2d4aa444 
# 64 bit
#AMI_ID=ami-fd4aa494 

# EBS boot 32 bit
#AMI_ID=ami-714ba518
KEYPAIR=jaybuffkey
echo "Booting AMI $AMI_ID"
INSTANCE_ID=`ec2-run-instances $AMI_ID -g webserver -g default -k $KEYPAIR -z us-east-1d "$@" |grep ^INSTANCE |awk '{print $2}'`
echo "Started $INSTANCE_ID  Getting host name\n"

DIR=`dirname $0`
EC2_HOSTNAME=`$DIR/ec2-hostname-from-instance-id.sh $INSTANCE_ID`

echo "Removing $EC2_HOSTNAME from ~/.ssh/known_hosts"
TMPFILE=`mktemp /tmp/known_hosts.XXXXXX` || exit 1
grep -v ^$EC2_HOSTNAME ~/.ssh/known_hosts > $TMPFILE
mv $TMPFILE ~/.ssh/known_hosts

VOL_ID=vol-3e557257
echo "Attaching volume $VOL_ID"
ec2-attach-volume $VOL_ID -i $INSTANCE_ID -d /dev/sdh

$DIR/wait-for-ssh.sh $EC2_HOSTNAME

# sleep just sec to be sure
sleep 3;

$DIR/create-remote-acct.sh ubuntu@$EC2_HOSTNAME

ssh ubuntu@$EC2_HOSTNAME "sudo mkdir -p ~$USER && sudo mount /dev/sdh1 ~$USER"
ssh $EC2_HOSTNAME sudo deluser ubuntu

echo "Created $EC2_HOSTNAME"
