#!/bin/bash

DIRECTION="$1"

# Get current window info
WIN=$(yabai -m query --windows --window)
FRAME=$(echo "$WIN" | jq '.frame')
WIN_ID=$(echo "$WIN" | jq '.id')

# Get display info
DISP=$(yabai -m query --displays --display)
DISP_FRAME=$(echo "$DISP" | jq '.frame')

# Extract values
win_x=$(echo "$FRAME" | jq '.x')
win_y=$(echo "$FRAME" | jq '.y')
win_w=$(echo "$FRAME" | jq '.w')
win_h=$(echo "$FRAME" | jq '.h')

disp_x=$(echo "$DISP_FRAME" | jq '.x')
disp_y=$(echo "$DISP_FRAME" | jq '.y')
disp_w=$(echo "$DISP_FRAME" | jq '.w')
disp_h=$(echo "$DISP_FRAME" | jq '.h')

# Set default state
at_edge=false

# Check if window is at edge of display
case "$DIRECTION" in
  west)
    [[ "$win_x" -le "$disp_x" ]] && at_edge=true
    ;;
  east)
    win_right=$((win_x + win_w))
    disp_right=$((disp_x + disp_w))
    [[ "$win_right" -ge "$disp_right" ]] && at_edge=true
    ;;
  north)
    [[ "$win_y" -le "$disp_y" ]] && at_edge=true
    ;;
  south)
    win_bottom=$((win_y + win_h))
    disp_bottom=$((disp_y + disp_h))
    [[ "$win_bottom" -ge "$disp_bottom" ]] && at_edge=true
    ;;
esac

if $at_edge; then
  # Move to display in the same direction
  yabai -m window --display "$DIRECTION"
  sleep 0.1
  yabai -m window --focus
else
  # Swap inside layout
  yabai -m window --swap "$DIRECTION"
fi
