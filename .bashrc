# Setup Amazon EC2 Command-Line Tools
export AWS_ELB_HOME=~/.ec2
export EC2_HOME=~/.ec2
if test -d $EC2_HOME; then
    export PATH=$PATH:$EC2_HOME/bin
    export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
    export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
fi

# set a variable that can be used in the prompt string to show that an error occurs.
export PROMPT_COMMAND='a=$?; if [ $a -ne 0 ] ; then export ERROR_MSG="[EXIT $a] "; else ERROR_MSG=""; fi'
export PS1="\t \u@\H:\w\n\$ERROR_MSG\$ "

# source host profiles
host=`/bin/hostname`
profile="$HOME/.login_profiles/$host"
if [ -f "$profile" ]; then
    source $profile
fi

export PATH=$PATH:/usr/local/bin:$HOME/bin

shopt -s checkwinsize

alias cx="chmod +x"

export TERM=linux
export COLORFGBG="white;black"
export EDITOR=vim

# only do this on a mac
if [ `uname` == "Darwin" ]; then

    # look for binaries installed by mac ports after other dirs
    export PATH=$PATH:/opt/local/bin:/opt/local/sbin
    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

    # sudo port install bash-completion
    if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    fi

    # to get docs from macports stuff
    export MANPATH=/opt/local/share/man:$MANPATH

    # so I can launch VLC from the command line
    if [ -f /Applications/VLC.app/Contents/MacOS/VLC ]; then
        alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
    fi
fi

alias json="python -m json.tool"
alias gerrit="ssh gerrit -p 29418 gerrit"
