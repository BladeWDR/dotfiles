#!/bin/bash

NOTES_PATH="$(pwd)"
DATESTAMP="$(date '+%Y-%m-%d %k:%M')"
cd "$NOTES_PATH"

GIT_STATUS=$(git status --porcelain=v1)

if [[ ! -z $GIT_STATUS ]]; then
   git pull --rebase
   git add --all
   git commit -m "AUTOCOMMIT - $DATESTAMP - $HOSTNAME" 
   git push
fi
