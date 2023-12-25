#!/bin/bash
#
release_file=/etc/os-release

sudo apt update
sudo apt install software-properties-common python3-launchpadlib git -y
sudo apt-add-repository ppa:ansible/ansible -y -n 

# If the system this is running on is not Ubuntu, try to change the apt repository to one that will work.
# e.g the Jammy repository for most recent Debian releases.
if grep -q "Ubuntu" $release_file
then
    sudo apt update
else
    source /etc/os-release
    sudo sed -i "s/$VERSION_CODENAME/jammy/" /etc/apt/sources.list.d/ansible-ubuntu-ansible-"$VERSION_CODENAME".list
fi

sudo apt update
sudo apt install ansible -y
