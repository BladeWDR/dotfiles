#!/usr/bin/env bash
# Fedora installation helper script.
# I tend to build these from the server installer for a cleaner system
# So there's quite a few packages missing.

set -eou pipefail

# vars

SCRIPTROOT="$HOME/dotfiles"

# Various packages
declare -a pkgs=(
    "alacritty"
    "automake"
    "bind9-next-utils"
    "cifs-utils"
    "direnv"
    "discord"
    "fastfetch"
    "firefox"
    "fzf"
    "gcc"
    "gcc-c++"
    "gdm"
    "google-chrome-stable"
    "jq"
    "kernel-devel"
    "lazygit"
    "libreoffice"
    "librewolf"
    "lzop"
    "make"
    "mbuffer"
    "mhash"
    "neovim"
    "nfs-utils"
    "pavucontrol"
    "perl-Capture-Tiny"
    "perl-Config-IniFiles"
    "perl-Data-Dumper"
    "perl-Getopt-Long"
    "pv"
    "python3-pip"
    "ranger"
    "syncthing"
    "tar"
    "telegram"
    "thunderbird"
    "tmux"
    "unzip"
    "w3m"
    "wdisplays"
    "zsh"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

declare -a grppkgs=(
    "multimedia"
    "sound-and-video"
    "swaywm"
)

declare -a dnfopts=(
    "--assumeyes"
    "--setopt=localpkg_gpgcheck=0"
    "--setopt=gpgcheck=1"
)

# Update the system
sudo dnf --assumeyes upgrade

if [[ -f /var/run/reboot-required ]]; then
    echo "##### WARNING: a previous update requires a reboot."
    echo "It may be advisable to reboot your system before proceeding."
    read -p "Y/N?" input
    if [[ $input != "y" ]] && [[ $input != "Y" ]]; then
       exit 
    fi
fi

# Install RPM Fusion Repo (For non-free codecs, H264 hardware acceleration support, etc).
sudo dnf "${dnfopts[@]}" install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Enable COPR repo for lazygit
sudo dnf "${dnfopts[@]}" copr enable atim/lazygit -y

# Enable Google Chrome repository
sudo dnf "${dnfopts[@]}" install fedora-workstation-repositories
sudo dnf "${dnfopts[@]}" config-manager setopt google-chrome.enabled=1

# Add Librewolf repository
curl -fsSL https://repo.librewolf.net/librewolf.repo | sudo tee /etc/yum.repos.d/librewolf.repo

# All group installs
sudo dnf "${dnfopts[@]}" group install "${grppkgs[@]}"

# Install all the listed packages
sudo dnf "${dnfopts[@]}" install "${pkgs[@]}"

# Use my staging Ansible playbook to install Starship prompt

cd "$SCRIPTROOT"

pythonpath=$(which python3)

if [[ ! -z "$pythonpath" ]]; then
    "$pythonpath" -m venv .venv

    source ".venv/bin/activate"

    pip3 install ansible

    ansible-galaxy install -r staging/meta/requirements.yml --roles-path ./staging/roles
    ansible-playbook -K ./staging/staging.yml -t starship
else
    echo "NOTICE: Not running Ansible install tasks because Python cannot be found."
fi

# Set the graphical target as default
sudo systemctl set-default graphical.target

# Set GTK to prefer dark themes.
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Prevent dings and dongs from random system events.
dconf write /org/gnome/desktop/sound/event-sounds "false"

# set default shell to zsh
zshpath=$(which zsh)
sudo chsh -s "$zshpath" "$USER"

# Enable and start the syncthing service.
if ! systemctl is-active --quiet "syncthing@$USER.service"; then
    sudo systemctl enable "syncthing@$USER.service" && sudo systemctl start "syncthing@$USER.service"
fi

# Start GDM (This should launch the graphical environment.)
if ! systemctl is-active --quiet gdm; then
    sudo systemctl start gdm
fi
