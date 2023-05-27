#!/bin/bash

#### i3 related
pip3 install --user i3ipc # more powerful window control
####


# Playerctl music manager
sudo apt install -y playerctl

# Polybar status bar (integrates with playerctl)
# sudo apt install -y polybar

#### Wallpaper management
sudo apt install feh
pip3 install --user wpgtk
pip3 install --user pywal
#sudo apt install -y nitrogen
####

# conky (tray/status window)
sudo apt install conky

# dunst (notification manager)
sudo apt install dunst

# config files needed
# ~/.config/i3/config
    # scripts for workspace wallpapers
    # feh,wpg
# ~/.Xresources
# ~/.config/picom/picom.conf
