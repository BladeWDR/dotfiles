#!/bin/bash

NOTES_PATH="$(pwd)"
DATESTAMP="$(date '+%Y-%m-%d %k:%M')"
cd "$NOTES_PATH"

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Not a Git repository: $NOTES_PATH"
    exit 1
fi

GIT_STATUS=$(git status --porcelain=v1)

if [[ ! -z $GIT_STATUS ]]; then
   git pull --rebase --quiet
   git add --all
   git commit -m "AUTOCOMMIT - $DATESTAMP - $HOSTNAME" 
   git push
fi
