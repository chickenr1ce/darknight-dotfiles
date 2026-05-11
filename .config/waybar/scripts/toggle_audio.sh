#!/bin/bash

# --- LOGGING SETUP ---
#LOG_FILE="$HOME/audio_toggle.log"
#exec > >(tee -a "$LOG_FILE") 2>&1  # Redirect stdout and stderr to log file
#set -x                             # Print each command before executing
#date "+%Y-%m-%d %H:%M:%S"          # Add a timestamp to the log

# 1. Get IDs for your target sinks
# Added 'head -n 1' to ensure we only get ONE ID if grep finds multiple
PEBBLE_ID=$(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep "Pebble V3" | sed 's/[^0-9]*\([0-9]\+\).*/\1/' | head -n 1)
JADE_ID=$(wpctl status | grep -A 15 "Sinks:" | grep "JadeAudio" | sed 's/[^0-9]*\([0-9]\+\).*/\1/' | head -n 1)
DONGLE_ID=$(wpctl status | grep -A 15 "Sinks:" | grep "AB13X" | sed 's/[^0-9]*\([0-9]\+\).*/\1/' | head -n 1)

# 2. Get the current active Sink ID
CURRENT_ID=$(wpctl status | grep -A 15 "Sinks:" | grep "*" | sed 's/[^0-9]*\([0-9]\+\).*/\1/' | head -n 1)

# Log the found IDs for debugging
echo "DEBUG: Pebble ID=$PEBBLE_ID, Jade ID=$JADE_ID, DONGLE ID=$DONGLE_ID, Current=$CURRENT_ID"

# 3. Toggle Logic
if [ "$CURRENT_ID" == "$JADE_ID" ]; then
    echo "Action: Switching to Dongle ($DONGLE_ID)"
    wpctl set-default "$DONGLE_ID"
    notify-send "Audio Switched" "Output: AB13X Dongle"
elif [ "$CURRENT_ID" == "$DONGLE_ID" ]; then
    echo "Action: Switching to Pebble ($PEBBLE_ID))"
    wpctl set-default "$PEBBLE_ID)"
    notify-send "Audio Switched" "Output: Creative Pebble V3"

else
    echo "Action: Switching to Jade Audio ($JADE_ID)"
    wpctl set-default "$JADE_ID"
    notify-send "Audio Switched" "Output: JadeAudio JIEZI"
fi

#set +x # Turn off command printing
#echo "------------------------------------"