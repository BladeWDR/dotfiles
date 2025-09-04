#!/bin/bash

POWERSHELL_EXE="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"

notify(){
    if [ -x "$POWERSHELL_EXE" ]; then
      title="Autocommit.sh"
      message="$1"
      "$POWERSHELL_EXE" -NoProfile -Command "
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        \$notification = New-Object System.Windows.Forms.NotifyIcon
        \$notification.Icon = [System.Drawing.SystemIcons]::Information
        \$notification.BalloonTipTitle = '$title'
        \$notification.BalloonTipText = '$message'
        \$notification.Visible = \$true
        \$notification.ShowBalloonTip(5000)
        Start-Sleep -Seconds 6
        \$notification.Dispose()
      "
      echo "$1"
   elif command -v notify-send &>/dev/null; then
      notify-send "Autocommit.sh" "$1"
      echo "$1"
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
else
   notify "No changes to commit."
fi
