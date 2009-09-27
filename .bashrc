export PATH=$PATH:/usr/local/bin:/sw/bin:/opt/local/bin:/opt/subversion/bin:/usr/local/share/coverity/prevent/bin/:/usr/local/git/bin/

export EDITOR=vim

# Setup Amazon EC2 Command-Line Tools
export EC2_HOME=~/.ec2
if test -d $EC2_HOME; then 
    export PATH=$PATH:$EC2_HOME/bin
    export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
    export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
fi

alias config='git --git-dir=/Users/jaybuff/.config.git/ --work-tree=/Users/jaybuff'
