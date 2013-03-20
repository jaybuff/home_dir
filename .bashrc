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

#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUPSTREAM="auto"
#export GIT_PS1_SHOWCOLORHINTS=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    export PS1='\t \u@\H:\w$(__git_ps1 " (%s)")\n$ERROR_MSG$ '
fi

# source host profiles
host=`/bin/hostname`
profile="$HOME/.login_profiles/$host"
if [ -f "$profile" ]; then
    source $profile
fi

export PATH=/usr/local/csi/bin:$PATH:/usr/local/bin:$HOME/bin

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

function cd() {
    builtin cd $* &&
    if [ -d ".git" ]; then
        # it'd be nice if i did git fetch first so this would say how far behind
        # origin I am
        git status
    fi
}

# Colorise less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# http://blog.sanctum.geek.nz/better-bash-history/
shopt -s histappend
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTTIMEFORMAT='%F %T '

# fix spelling errors for cd, only in interactive shell
shopt -s cdspell

if [ -f ~/.pystartup ]; then
    export PYTHONSTARTUP=~/.pystartup
fi

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

if [ -f ~/.vagrant.d/bash-completion ]; then
    source ~/.vagrant.d/bash-completion
fi

export NOSE_WITH_OPENSTACK=1
export NOSE_OPENSTACK_COLOR=1
export NOSE_OPENSTACK_RED=0.05
export NOSE_OPENSTACK_YELLOW=0.025
export NOSE_OPENSTACK_SHOW_ELAPSED=1
export NOSE_OPENSTACK_STDOUT=1

export PUNGI_CACHEDIR=~/pungi-cache

function vagrant() {
    RUNDIR=~/.vagrant.d/vm-rundir
    [[ -d $RUNDIR ]] || mkdir -p $RUNDIR
    cd $RUNDIR
    [[ -f Vagrantfile ]] || touch Vagrantfile
    `which vagrant` $*
    RC=$?
    cd - > /dev/null
    return $RC
}

function nova() {
    test -z $ospasswd && echo -n "OS Password: " && read -s ospasswd
    OS_PASSWORD=$ospasswd `which nova` --insecure $*
}

function keystone() {
    # only prepend --insecure if the user specified args
    declare args
    if [ $# -ne 0 ]; then
        args="--insecure "
    fi
    args+=$*

    command keystone $args
}
