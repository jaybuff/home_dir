# Setup Amazon EC2 Command-Line Tools
export AWS_ELB_HOME=~/.ec2
export EC2_HOME=~/.ec2
if test -d $EC2_HOME; then 
    export PATH=$PATH:$EC2_HOME/bin
    export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
    export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
fi


# PROMPT
if [ "$PS1" != "" ]
then
    PS1="\h \t \W \$ "
      setenv ()  { export $1="$2"; }
    unsetenv ()  { unset $*; }
fi

# set a variable that can be used in the prompt string to show that an error occurs.
export PROMPT_COMMAND='a=$?; if [ $a -ne 0 ] ; then export ERROR_MSG="[EXIT $a] "; else ERROR_MSG=""; fi'

# set prompt to include the yroot if we're in one
# put the user, hostname and directory in a format that can be copied to SCP
# and include the ERROR_MSG variable that gets set in PROMPT_COMMAND
if [ "x$YROOT_NAME" != "x" ]; then
    export PS1="[\u@\H =>$YROOT_NAME<= \W]\n\$ERROR_MSG \t \\$ "
else
    export PS1="\u@\H:\w\n\$ERROR_MSG \t \$ "
fi

# source host profiles
PROFILES="$HOME/.login_profiles"
host=`/bin/hostname`
profile="$PROFILES/$host"
if [ -f "$profile" ]
then
    source $profile
fi


# use a different perltidyrc based on what directory you're in
if test -x /home/y/bin/perltidy-config-dirtree; then
    alias perltidy=perltidy-config-dirtree
fi

if test -d /home/y; then
    export PATH=$PATH:/home/y/bin
fi
export PATH=$PATH:/usr/local/bin:$HOME/bin

shopt -s checkwinsize

alias cx="chmod +x"
alias homedir="git --git-dir=$HOME/.config.git/ --work-tree=$HOME"
alias bugs="ybug ns cse-open -Tbbrief"

export TERM=linux
export COLORFGBG="white;black"
export EDITOR=vim

export TWED_EDITOR=vim
export S=svn+ssh://svn.corp.yahoo.com/

# only do this on a mac
if [ `uname` == "Darwin" ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

    # sudo port install bash-completion
    if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    fi

    # to get docs from macports stuff
    export MANPATH=/opt/local/share/man:$MANPATH

    # so I can launch VLC from the command line
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
fi

