#!/bin/bash

# Define workspace number and wallpaper paths
wallpaper_path="$HOME/.config/wpg/wallpapers"
declare -A wallpapers
wallpapers=(
  [1]=clouds.jpg
  [2]=portal.png
  # Add more wallpapers for each workspace as needed
)

# Get current workspace number
workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' | tr -d '\n')

wallpaper_name="${wallpapers[$workspace]}"

# Set wallpaper and generate color scheme for the current workspace
wpg -s "$wallpaper_name"
# Or set color scheme only 
# wpg -ns colorscheme.jpg

# Replace existing color definitions in .Xresources
$HOME/.config/wpg/write_xresources.sh

# Reload Xresources
xrdb -load ~/.Xresources

# Apply the color scheme to i3 and other applications
# i3
#xrdb -merge ~/.cache/wal/colors.Xresources
#i3-msg reload

# alacritty
$HOME/.config/alacritty/import_colors.sh

# xpad
#$HOME/.config/xpad/import_colors.sh

# Add commands to reload other applications as needed
