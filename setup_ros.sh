echo 'export BROWSER="/usr/bin/firefox"' >> ~/.bashrc
source ~/.bashrc

sudo apt install gh
gh auth login
gh repo clone daniel-houghton/scara

