#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e

echo 'export BROWSER="/usr/bin/firefox"' >> ~/.bashrc
source ~/.bashrc

sudo apt install gh
gh auth login
gh repo clone daniel-houghton/scara

echo "--- 1. Setting Locale ---"
locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings



echo "--- 1.A Adding Universe ---"
sudo apt install software-properties-common
sudo add-apt-repository universe



echo "--- 2 Installing the ros2-apt-source package ---"
sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb



echo "--- 3. Installing ROS 2 ---"
# Install development tools
sudo apt update && sudo apt install -y ros-dev-tools

sudo apt update
sudo apt upgrade
sudo apt install -y ros-kilted-desktop



echo "--- 4. Setting up Environment ---"
# Add the sourcing command to .bashrc if it's not already there
ROS_SETUP_LINE="export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
source /opt/ros/kilted/setup.bash
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
export ROS_DOMAIN_ID=0
source ~/scara/install/setup.bash
export QT_QPA_PLATFORM=xcb
"
if ! grep -Fq "$ROS_SETUP_LINE" ~/.bashrc; then
    echo "$ROS_SETUP_LINE" >> ~/.bashrc
    echo "Added ROS 2 sourcing to .bashrc"
else
    echo "ROS 2 sourcing already in .bashrc"
fi


# Optional: Source for the current shell
source /opt/ros/kilted/setup.bash

echo "--- ROS2 Desktop Installation Complete! ---"
source ~/.bashrc

echo "---  Installing CycloneDDS ---"
sudo apt update
sudo apt install ros-$ROS_DISTRO-rmw-cyclonedds-cpp
source ~/.bashrc


echo "---  Installing MoveIt ---"
sudo apt update
sudo apt install ros-$ROS_DISTRO-moveit
source ~/.bashrc

echo "---  Installing ros2_control ---"
sudo apt update
sudo apt install ros-$ROS_DISTRO-ros2-control ros-$ROS_DISTRO-ros2-controllers
source ~/.bashrc
