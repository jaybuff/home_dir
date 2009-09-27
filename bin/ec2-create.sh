#!/bin/bash
# make sure that ssh access is available:
# ec2-authorize default -P tcp -t 22

# 32 bit Ubuntu 9.04 Jaunty server from http://alestic.com/
AMI_ID=ami-ed46a784
KEYPAIR=jaybuffkey
PRIVATE_KEY=~/.ssh/jaybuffkey.pem
echo "Booting AMI $AMI_ID"
NEW_INSTANCE_ID=`ec2-run-instances $AMI_ID -g webserver -g default -k $KEYPAIR |grep ^INSTANCE |awk '{print $2}'`
echo -ne "Started $NEW_INSTANCE_ID  Getting host name"

until [[ "$HOSTNAME" =~ 'amazonaws.com'  ]]; do 
    echo -ne "."
    HOSTNAME=`ec2-describe-instances $NEW_INSTANCE_ID |grep ^INSTANCE |awk '{ print $4 }'`
done
echo
echo $HOSTNAME

echo -ne "Waiting for ssh to become available"
until [[ `echo "" |nc -w 1 $HOSTNAME 22` ]]; do 
    echo -ne "."
done
echo

echo "Creating account for $USER and putting pub keys in authorized_keys"
SSH_OPTIONS="-i $PRIVATE_KEY -o StrictHostKeyChecking=no"
ssh root@$HOSTNAME $SSH_OPTIONS "adduser $USER --disabled-password --gecos 1 && sudo -u $USER - mkdir $HOME/.ssh/"
cat ~/.ssh/*.pub | ssh root@$HOSTNAME $SSH_OPTIONS "cat - >> ~$USER/.ssh/authorized_keys"
