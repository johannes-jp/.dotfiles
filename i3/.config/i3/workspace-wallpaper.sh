#!/bin/bash

# Define workspace number and wallpaper paths
declare -A wallpapers
wallpapers=(
  [1]="/usr/share/backgrounds/clouds.jpg"
  [2]="/usr/share/backgrounds/portal.png"
  # Add more wallpapers for each workspace as needed
)

# Get current workspace number
workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' | tr -d '\n')

wallpaper_path="${wallpapers[$workspace]}"

# Set wallpaper and generate color scheme for the current workspace
feh --bg-scale "$wallpaper_path"
wal -i "$wallpaper_path"

# Remove existing color definitions
sed -i '/^! BEGIN GENERATED COLORS/,/^! END GENERATED COLORS/d' ~/.Xresources

# Append new color definitions
echo "! BEGIN GENERATED COLORS" >> ~/.Xresources
cat ~/.cache/wal/colors.Xresources >> ~/.Xresources
echo "! END GENERATED COLORS" >> ~/.Xresources

# Reload Xresources
xrdb -load ~/.Xresources

# Apply the color scheme to i3, polybar, and other applications
i3-msg reload
polybar-msg cmd restart
# Add commands to reload other applications as needed

# Apply colors to i3
xrdb -merge ~/.cache/wal/colors.Xresources
i3-msg reload
