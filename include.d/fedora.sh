#!/usr/bin/env bash
# Fedora installation helper script.
# I tend to build these from the server installer for a cleaner system
# So there's quite a few packages missing.

set -eou pipefail

# vars

SCRIPTROOT="$HOME/$USER/dotfiles"

# Various packages
declare -a pkgs=(
    "direnv"
    "tmux"
    "wdisplays"
    "fastfetch"
    "discord"
    "telegram"
    "thunderbird"
    "lazygit"
    "fastfetch"
    "pavucontrol"
    "librewolf"
    "syncthing"
    "mullvad-vpn"
    "ranger"
    "neovim"
    "jq"
    "libreoffice"
    "w3m"
    "perl-Config-IniFiles"
    "perl-Data-Dumper"
    "perl-Getopt-Long"
    "lzop"
    "mbuffer"
    "mhash"
    "gdm"
    "pv"
    "bind9-next-utils"
    "python3-pip"
    "make"
    "automake"
    "gcc"
    "gcc-c++"
    "kernel-devel"
    "tar"
    "unzip"
)

declare -a grppkgs=(
    "multimedia"
    "sound-and-video"
    "swaywm"
)

dnfopts='--assumeyes --setopt=localpkg_gpgcheck=0 --setopt=gpgcheck=1'

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
sudo dnf "$dnfopts" install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Enable COPR repo for lazygit
sudo dnf "$dnfopts" copr enable atim/lazygit -y

# Add Mullvad VPN repository for their desktop client.
sudo dnf "$dnfopts" config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo

# All group installs
sudo dnf "$dnfopts" group install "${grppkgs[@]}"

# Install all the listed packages
sudo dnf "$dnfopts" install "${pkgs[@]} "

# Use my staging Ansible playbook to install Starship prompt

cd "$SCRIPTROOT"

pythonpath=$(which python3)

if [[ ! -z "$pythonpath" ]]; then
    pythonpath -m venv .venv

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

# Start GDM (This should launch the graphical environment.)
if ! systemctl is-active --quiet gdm; then
    sudo systemctl start gdm
fi
