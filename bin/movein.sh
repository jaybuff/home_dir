sudo apt-get update -y
sudo apt-get install git git-core -y
ssh -o StrictHostKeyChecking=no github.com # avoid pesky knownhosts check
git clone git@github.com:jaybuff/home_dir.git ~/config.git
mv ~/config.git/.git ~/.config.git
shopt -s dotglob
rm -rf ~/.bashrc 
mv ~/.ssh ~/.ssh.bck && mv ~/config.git/* ~/
mv ~/.ssh.bck/id_dsa ~/.ssh/
rm -rf ~/.ssh.bck
rmdir ~/config.git
