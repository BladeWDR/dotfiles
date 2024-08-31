#!/usr/bin/env bash
# Use this on my desktop to quickly switch between my speakers and headphones.
# requires pulseaudio and pavucontrol

current=$(pactl get-default-sink)

# Keep this as simple as possible.
# If output is "speakers", switch to headphones.
# else if output is "headphones", switch to speakers.

next=""

if [[ $current == *"goxlr_system"* ]]; then
    while read -r line; do
        sink=$(echo "$line" | awk '{print $2}')
        if [[ $sink == *"Generic_USB_Audio"* ]]; then
            next=$sink
            break
        fi
    done < <(pactl list short sinks)
elif [[ $current == *"Generic_USB_Audio"* ]]; then
    while read -r line; do
        sink=$(echo "$line" | awk '{print $2}')
        if [[ $sink == *"goxlr_system"* ]]; then
            next="$sink"
            break
        fi
    done < <(pactl list short sinks)
else
    echo "Not set to either speakers or headphones. Setting to headphones by default."
    while read -r line; do
        sink=$(echo "$line" | awk '{print $2}')
        if [[ $sink == *"goxlr_system"* ]]; then
            next="$sink"
            break
        fi
    done < <(pactl list short sinks)
fi

if [[ -n "$next" ]]; then
    echo "Setting output to $next"
    pactl set-default-sink "$next"
else
    echo "next is $next"
    echo "No matching sink found"
fi
