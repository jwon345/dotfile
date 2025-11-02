#!/bin/bash

DIRECTION="$1"

# Try focusing window in the desired direction
ORIG_WIN=$(yabai -m query --windows --window | jq '.id')
yabai -m window --focus "$DIRECTION"
sleep 0.1
NEW_WIN=$(yabai -m query --windows --window | jq '.id')

# If no window focus change, try focusing the adjacent display
if [ "$ORIG_WIN" = "$NEW_WIN" ]; then
  yabai -m display --focus "$DIRECTION"
  sleep 0.1

  # Focus the first window on that display (if any)
  TARGET_WIN=$(yabai -m query --windows --space | jq '.[0].id')
  if [ "$TARGET_WIN" != "null" ]; then
    yabai -m window --focus "$TARGET_WIN"
  fi
fi
