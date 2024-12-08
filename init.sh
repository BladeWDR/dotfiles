#!/usr/bin/env bash

LOGFILE="/tmp/init.log"
INCLUDEDIR="./include.d"

# Redirect stdout and stderr to both the screen and the log file
exec > >(tee -a "$LOGFILE") 2>&1

# source the release file so I can get the variables therein.
. /etc/os-release

if ["$NAME" = "Ubuntu"]; then
    source "$INCLUDEDIR/ubuntu.sh"
elif ["$NAME" = "Fedora Linux"]; then
    source "$INCLUDEDIR/fedora.sh"
else
    echo "Distro not supported."
    exit 1
fi

echo "######################################################"
echo "Script complete."
echo "Remember to run ./install <config name> to actually create the symlinks."
echo "######################################################"
