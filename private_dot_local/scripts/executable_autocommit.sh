#!/bin/bash

notify(){
   if command -v notify-send &>/dev/null; then
      notify-send "Autocommit.sh" "$1"
      echo "$1"
   elif command -v wsl-notify-send &>/dev/null; then
      wsl-notify-send --app-name "Autocommit.sh" "$1"
   else
      echo "$1"
   fi
}

if [[ -z "$1" ]]; then
   NOTES_PATH="$(pwd)"
elif [[ -d "$1" ]]; then
  NOTES_PATH="$1" 
else
   notify "ERROR: unable to determine notes path."
fi

DATESTAMP="$(date '+%Y-%m-%d %k:%M')"
cd "$NOTES_PATH" || exit

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    notify "Not a Git repository: $NOTES_PATH"
    exit 1
fi

GIT_STATUS=$(git status --porcelain=v1)

if [[ -n $GIT_STATUS ]]; then
   git pull --rebase --quiet
   git add --all
   git commit -m "AUTOCOMMIT - $DATESTAMP - $HOSTNAME" 
   git push
   notify "$1 automatically committed."
fi
