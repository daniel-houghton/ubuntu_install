sudo systemctl disable systemd-networkd-wait-online.service
sudo apt update && sudo apt upgrade -y
sudo apt install ubuntu-desktop -y
sudo apt update && install spice-vdagent spice-webdavd -y

sudo apt update
sudo apt install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo 'deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list
rm packages.microsoft.gpg

sudo apt update
sudo apt install code
sudo apt purge libreoffice*
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
sudo apt purge libreoffice* thunderbird* rhythmbox* shotwell* totem*
sudo apt autoremove
rm -r Documents Downloads Music Pictures Public Templates Videos

sudo reboot
