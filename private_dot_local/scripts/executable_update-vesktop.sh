#!/usr/bin/env bash

# Tired of doing this by hand, stick 'er in a cron job.

declare -a MISSING_PKGS

if ! command -v jq 2>&1 >/dev/null; then
    MISSING_PKGS+=("jq")
fi
if ! command -v notify-send 2>&1 >/dev/null; then
    MISSING_PKGS+=("notify-send")
fi

if [[ ${#MISSING_PKGS[@]} -gt 0 ]]; then
    echo "The following packages are missing:"
    for pkg in "${MISSING_PKGS[@]}"; do
        echo "$pkg"
    done
    exit 1
fi

RELEASES_JSON=$(curl https://api.github.com/repos/vencord/vesktop/releases)

if [[ -z "$RELEASES_JSON" ]]; then
    notify-send "Unable to parse vesktop releases json."
    exit 1
fi

RELEASE_TAG=$(echo "$RELEASES_JSON" | jq -r '.[0].tag_name')
RELEASE_VER_NAME=$(echo "$RELEASES_JSON" | jq -r '.[0].name')

VESKTOP_VER=$(vesktop --version | sed -n 4,4p | awk '{print $2}')

if [[ -n $VESKTOP_VER ]] && [ "$VESKTOP_VER" == "$RELEASE_TAG" ]; then
    notify-send "Vesktop appears to be up to date."
    exit 0
elif [[ -z "$VESKTOP_VER" ]]; then
    notify-send "Vesktop doesn't seem to be installed."
    exit 0
fi

DOWNLOAD_URL="https://github.com/Vencord/Vesktop/releases/download/$RELEASE_TAG/vesktop-$RELEASE_VER_NAME.x86_64.rpm"
OUTPUT_FILE="/tmp/vesktop-$RELEASE_TAG.rpm"

echo "Downloading $DOWNLOAD_URL"
notify-send "Downloading Vesktop Update."
wget -O "$OUTPUT_FILE" "$DOWNLOAD_URL"

dnf install -y "$OUTPUT_FILE"
SUCCESS=$?

if $SUCCESS -ne 0; then
    notify-send "Vesktop failed to install."
else
    notify-send "Installed Vesktop update succesfully."
    if [[ -f "$OUTPUT_FILE" ]]; then
        rm "$OUTPUT_FILE"
    fi
fi
