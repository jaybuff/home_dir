#!/bin/bash
# make sure that ssh access is available:
# ec2-authorize default -P tcp -t 22

# 32 bit Ubuntu 9.04 Jaunty server from http://alestic.com/
AMI_ID=ami-ed46a784
KEYPAIR=jaybuffkey
PRIVATE_KEY=~/.ssh/jaybuffkey.pem
echo "Booting AMI $AMI_ID"
INSTANCE_ID=`ec2-run-instances $AMI_ID -g webserver -g default -k $KEYPAIR |grep ^INSTANCE |awk '{print $2}'`
echo -ne "Started $INSTANCE_ID  Getting host name"

until [[ "$EC2_HOSTNAME" =~ 'amazonaws.com'  ]]; do 
    echo -ne "."
    EC2_HOSTNAME=`ec2-describe-instances $INSTANCE_ID |grep ^INSTANCE |awk '{ print $4 }'`
done
echo
echo $EC2_HOSTNAME

echo -ne "Waiting for ssh to become available"
until [[ `echo "" |nc -w 1 $EC2_HOSTNAME 22` ]]; do 
    echo -ne "."
done
echo

echo "Creating account for $USER and adding to /etc/sudoers"
SSH_OPTIONS="-i $PRIVATE_KEY -o StrictHostKeyChecking=no"
ssh root@$EC2_HOSTNAME $SSH_OPTIONS "adduser $USER --disabled-password --gecos 1 && echo '$USER ALL=NOPASSWD: ALL' >> /etc/sudoers"

echo "Setting up ssh"
cat ~/.ssh/*.pub | ssh root@$EC2_HOSTNAME $SSH_OPTIONS "sudo -u $USER mkdir ~$USER/.ssh/ && cat - >> ~$USER/.ssh/authorized_keys"
scp ~/.ssh/id_dsa $EC2_HOSTNAME:~/.ssh/

echo "Setting up move in script"
scp ~/bin/movein.sh $EC2_HOSTNAME:~/
ssh $EC2_HOSTNAME 'echo "~/movein.sh && rm ~/movein.sh" >> .bashrc'

echo "ssh'ing to $EC2_HOSTNAME and running move in script"
exec ssh $EC2_HOSTNAME
