#!/bin/bash 

for file in .bash_completion .bash_profile .bashrc bin .gitconfig .gitignore .git-prompt.sh .inputrc .mutt .muttrc .perltidyrc .pgp .procmailrc .pystartup .vagrant.d .vim .vimrc; do
	echo  ln -s $(readlink -f $(dirname $0))/$file ~/$file
done
