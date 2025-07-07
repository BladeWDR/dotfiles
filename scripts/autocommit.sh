#!/bin/bash

NOTES_PATH="$HOME/git/work-notes"
HOSTNAME=$(hostname)

cd "$NOTES_PATH"

GIT_STATUS=$(git status --porcelain=v1)

if [[ ! -z $GIT_STATUS ]]; then
   git pull --rebase
   git add --all
   git commit -m "AUTOCOMMIT - $HOSTNAME" 
   git push
fi
