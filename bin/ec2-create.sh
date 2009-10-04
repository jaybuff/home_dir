#!/bin/bash
# make sure that ssh access is available:
# ec2-authorize default -P tcp -t 22

# 32 bit Ubuntu 9.04 Jaunty server from http://alestic.com/
AMI_ID=ami-ed46a784
KEYPAIR=jaybuffkey
echo "Booting AMI $AMI_ID"
INSTANCE_ID=`ec2-run-instances $AMI_ID -g webserver -g default -k $KEYPAIR |grep ^INSTANCE |awk '{print $2}'`
echo -ne "Started $INSTANCE_ID  Getting host name"

until [[ "$EC2_HOSTNAME" =~ 'amazonaws.com'  ]]; do 
    echo -ne "."
    EC2_HOSTNAME=`ec2-describe-instances $INSTANCE_ID |grep ^INSTANCE |awk '{ print $4 }'`
done
echo
echo $EC2_HOSTNAME

~/bin/wait-for-ssh.sh $EC2_HOSTNAME
~/bin/create-remote-acct.sh $EC2_HOSTNAME
~/bin/movein.sh $EC2_HOSTNAME
