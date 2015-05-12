if [ -f ~/.git-prompt.sh ]; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    source ~/.git-prompt.sh
    export PROMPT_COMMAND='__git_ps1 "\t \u@\H:\w" " \\n$ "'
else
    export PS1='\t \u@\H:\w\n$ '
fi

# source host profiles
host=`/bin/hostname`
profile="$HOME/.login_profiles/$host"
if [ -f "$profile" ]; then
    source $profile
fi

shopt -s checkwinsize

alias cx="chmod +x"

export TERM=linux
export COLORFGBG="white;black"
export EDITOR=vim

# only do this on a mac
if [ `uname` == "Darwin" ]; then

    # look for binaries installed by mac ports after other dirs
    export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/sbin

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
else
    # if I do sudo yum install opt-oracle-jdk-1.7.0-45.x86_64 in rhel 6.5
    # i need to set this to use the jdk it installs:
    export JAVA_HOME=/opt/oracle-jdk-1.7.0_45
fi

alias json="python -m json.tool"

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

for completion in ~/.bash_completion/*; do
  source $completion
done
