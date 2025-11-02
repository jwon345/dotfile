#!/bin/bash

TARGET_SPACE="$1"
APP_WINDOW="$(yabai -m query --windows --window | jq -r '.id')"

# Count existing spaces
SPACE_COUNT="$(yabai -m query --spaces | jq length)"

# If target space doesn't exist, create it
if [ "$TARGET_SPACE" -gt "$SPACE_COUNT" ]; then
  yabai -m space --create
fi

# Move the window to the space
yabai -m window "$APP_WINDOW" --space "$TARGET_SPACE"

# Optional: focus that space
yabai -m space --focus "$TARGET_SPACE"

