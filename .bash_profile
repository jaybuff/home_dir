# According to the bash man page, .bash_profile is executed for login shells,
# while .bashrc is executed for interactive non-login shells.  I want it for
# both.
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

##
# Your previous /Users/jaybuff/.bash_profile file was backed up as /Users/jaybuff/.bash_profile.macports-saved_2009-10-08_at_17:38:30
##

# MacPorts Installer addition on 2009-10-08_at_17:38:30: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.


##
# Your previous /Users/jaybuff/.bash_profile file was backed up as /Users/jaybuff/.bash_profile.macports-saved_2009-10-08_at_17:48:50
##

# MacPorts Installer addition on 2009-10-08_at_17:48:50: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.

