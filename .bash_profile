# According to the bash man page, .bash_profile is executed for login shells,
# while .bashrc is executed for interactive non-login shells.  I want it for
# both.
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
