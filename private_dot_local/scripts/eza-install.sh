#!/usr/bin/env bash

declare -a dnfopts=(
    "--assumeyes"
    "--setopt=localpkg_gpgcheck=0"
    "--setopt=gpgcheck=1"
)

declare -a dependencies=( 
    "jq"
    "curl"
    "tar"
    "wget"
    )

declare -i DEPENDS_UNMET=0

for d in "${dependencies[@]}";
do
    if ! command -v $d 2>&1 >/dev/null; then
        echo "$d is not installed"
        let DEPENDS_UNMET++
    fi
done

if [[ $DEPENDS_UNMET -ne 0 ]]; then
    echo 'Missing dependencies.'
    exit 1
fi

RELEASES_JSON=$(curl https://api.github.com/repos/eza-community/eza/releases)

if [[ -z "$RELEASES_JSON" ]]; then
    echo "Unable to parse eza releases json."
    exit 1
fi

RELEASE_TAG=$(echo "$RELEASES_JSON" | jq -r '.[0].tag_name')
RELEASE_VER_NAME=$(echo "$RELEASES_JSON" | jq -r '.[0].name')

DOWNLOAD_URL="https://github.com/eza-community/eza/releases/download/$RELEASE_TAG/eza_x86_64-unknown-linux-gnu.tar.gz"
OUTPUT_FILE="/tmp/eza-$RELEASE_TAG.tar.gz"

wget -O "$OUTPUT_FILE" "$DOWNLOAD_URL"

tar -xzvf $OUTPUT_FILE -C /tmp

mv /tmp/eza /usr/local/bin/eza
