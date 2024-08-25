#!/usr/bin/env bash

LOGFILE="/tmp/init.log"

# Redirect stdout and stderr to both the screen and the log file
exec > >(tee -a "$LOGFILE") 2>&1

# source the release file so I can get the VERSION_CODENAME variable.
. /etc/os-release

# apps I want on every system, including servers.
# Keep this to the VERY basics, as most things will be installed by the ansible playbook.
BASICS=(
        software-properties-gtk
        python3-launchpadlib
        git
        zsh
        zsh-autosuggestions
        zsh-syntax-highlighting
        tmux
        direnv
        curl
)

# desktop apps that can be installed via apt
DESKTOP_APPS_APT=(
    i3
    pulseaudio
    pavucontrol
    brightnessctl
    pcscd
)

# Install dependencies.
sudo apt update
sudo apt install -y "${BASICS[@]}"

# Check to see if the ansible repo already exists, if it does not, then add it.
if [ -f "/etc/apt/sources.list.d/ansible-ubuntu-ansible-$VERSION_CODENAME.list" ]; then
    echo "Repository already exists, skipping."
else
    sudo apt-add-repository ppa:ansible/ansible -y -n
fi

sudo apt update && sudo apt install ansible -y

# Use a glob pattern to directly find directories matching python3.*
# Need to remove the EXTERNALLY-MANAGED file so that Ansible doesn't cough up a lung trying to use pip.
for dir in /usr/lib/python3.*; do
   sudo rm "$dir/EXTERNALLY-MANAGED"
done

ANSIBLE_PATH=$(which ansible)

if [ -f "$ANSIBLE_PATH" ]; then
    echo "######################################################"
    echo "Running ansible playbook."
    echo "######################################################"
    ansible-galaxy install -r staging/meta/requirements.yml --roles-path ./staging/roles
    ansible-playbook -K ./staging/staging.yml
else
    echo "Error: Ansible not found."
    echo "Something has gone horribly wrong."
    exit 1
fi

# Install Homebrew.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

read -p "Does this machine have a GUI?" DESKTOP_APPS_CHOICE

if [ $DESKTOP_APPS_CHOICE == "Y" ] || [ $DESKTOP_APPS_CHOICE == "y" ]; then
   sudo apt install -y "${DESKTOP_APPS_APT[@]}"
fi

read -p "Would you like to install Neovim?" NVIM_CHOICE

if [ $NVIM_CHOICE == "Y" ] || [ $NVIM_CHOICE == "y" ]; then
   # Test to make sure that the homebrew binary is available.
   if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
       /home/linuxbrew/.linuxbrew/bin/brew install neovim
   fi
fi

echo "######################################################"
echo "Script complete."
echo "Remember to run ./install <config name> to actually create the symlinks."
echo "######################################################"
