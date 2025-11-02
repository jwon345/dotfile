#!/bin/bash

# Get the list of windows in the current space
WIN_ID=$(yabai -m query --windows --space | jq '.[0].id')

# Focus the first window if one exists
if [ "$WIN_ID" != "null" ]; then
  yabai -m window --focus "$WIN_ID"
fi
