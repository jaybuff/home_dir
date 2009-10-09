#!/bin/bash
# make sure that ssh access is available:
# ec2-authorize default -P tcp -t 22

# 32 bit Ubuntu 9.04 Jaunty server from http://alestic.com/
AMI_ID=ami-ed46a784
KEYPAIR=jaybuffkey
echo "Booting AMI $AMI_ID"
INSTANCE_ID=`ec2-run-instances $AMI_ID -g webserver -g default -k $KEYPAIR |grep ^INSTANCE |awk '{print $2}'`
echo -ne "Started $INSTANCE_ID  Getting host name"

DIR=`dirname $0`
EC2_HOSTNAME=`$DIR/ec2-hostname-from-instance-id.sh $INSTANCE_ID`
$DIR/wait-for-ssh.sh $EC2_HOSTNAME
$DIR/create-remote-acct.sh $EC2_HOSTNAME

ssh root@$EC2_HOSTNAME sudo -u $USER mkdir ~$USER/.ssh/
cat ~/.ssh/*.pub | ssh root@$EC2_HOSTNAME "cat - >> ~$USER/.ssh/authorized_keys"
$DIR/movein.sh $EC2_HOSTNAME
