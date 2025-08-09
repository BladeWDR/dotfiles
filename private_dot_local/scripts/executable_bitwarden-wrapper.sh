#!/usr/bin/env bash

EMAIL="scott@ssb-tech.net"

# Check login status
STATUS=$(bw status | jq -r '.status')

if [ "$STATUS" = "unauthenticated" ]; then
  echo "Not logged in. Logging in..."
  # Login and unlock vault
  export BW_SESSION="$(bw login "$EMAIL" --raw)"
elif [ "$STATUS" = "locked" ]; then
  echo "Vault is locked. Unlocking..."
  export BW_SESSION="$(bw unlock --raw)"
else
  export BW_SESSION="$(bw unlock --raw)"
fi

# Check if an item ID or name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <item-id-or-name>"
  exit 1
fi

# Get the password and copy to clipboard
bw get password "$1" | wl-copy

echo "Password for '$1' copied to clipboard."
