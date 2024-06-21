#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar (remember that TOP is the NAME of the bar!)
polybar -c ~/.config/polybar/config.ini top &
