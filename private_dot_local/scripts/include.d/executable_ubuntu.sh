#!/usr/bin/env bash

# apps I want on every system, including servers.
# Keep this to the VERY basics, as most things will be installed by the ansible playbook.
BASICS=(
        software-properties-gtk
        python3-launchpadlib
        python3-pip
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
    qtwayland5
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    sway
    waybar
    j4-dmenu-desktop
)

SCRIPTROOT="$HOME/dotfiles"

# add the current user to the video group so they can use brightnessctl without sudo.
sudo usermod -aG video $USER

# Install dependencies.
sudo apt update
sudo apt install -y "${BASICS[@]}"

cd "$SCRIPTROOT"

pythonpath=$(which python3)

if [[ ! -z "$pythonpath" ]]; then
    "$pythonpath" -m venv .venv

    source ".venv/bin/activate"

    pip3 install ansible

    ansible-galaxy install -r staging/meta/requirements.yml --roles-path ./staging/roles
    echo "######################################################"
    echo "Running ansible playbook."
    echo "######################################################"
    ansible-playbook -K ./staging/staging.yml
else
    echo "NOTICE: Not running Ansible install tasks because Python cannot be found."
fi

# Install Homebrew.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

read -p "Does this machine have a GUI? " DESKTOP_APPS_CHOICE

if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
   /home/linuxbrew/.linuxbrew/bin/brew install fzf
else
    echo "Homebrew does not seem to be installed. Skipping."
fi

if [ $DESKTOP_APPS_CHOICE == "Y" ] || [ $DESKTOP_APPS_CHOICE == "y" ]; then
   sudo apt install -y "${DESKTOP_APPS_APT[@]}"
   # Install greenclip.
   sudo wget -O /usr/local/bin/greenclip "https://github.com/erebe/greenclip/releases/download/v4.2/greenclip"
   sudo chmod +x /usr/local/bin/greenclip
fi

read -p "Would you like to install Neovim? " NVIM_CHOICE

if [ $NVIM_CHOICE == "Y" ] || [ $NVIM_CHOICE == "y" ]; then
   # Test to make sure that the homebrew binary is available.
   if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
       /home/linuxbrew/.linuxbrew/bin/brew install neovim
       /home/linuxbrew/.linuxbrew/bin/brew install yarn
   else
    echo "Homebrew does not seem to be installed. Either install Homebrew or build Neovim from source."
   fi
fi
