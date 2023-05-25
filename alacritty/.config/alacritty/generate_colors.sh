#!/bin/bash

# Load Xresources colors
xrdb -query -all | grep -E '^(.*\.(background|foreground)|\*.color[0-9]*):' | sed -e 's/^/    /' -e 's/:/:\ /' -e 's/^    \*/    color/' -e 's/^    \*\.//' -e "s/#/\'#/" -e "s/$/\',/" > /tmp/colors.tmp
echo "# Alacritty colors generated from Xresources" > ~/.config/alacritty/colors.yml
echo "colors:" >> ~/.config/alacritty/colors.yml
echo "  primary:" >> ~/.config/alacritty/colors.yml
grep 'background\|foreground' /tmp/colors.tmp >> ~/.config/alacritty/colors.yml
echo "  normal:" >> ~/.config/alacritty/colors.yml
grep 'color[0-7]' /tmp/colors.tmp | sed -e 's/color\([0-9]\):/    black:  /' -e 's/color10:/    green:   /' -e 's/color11:/    yellow:  /' -e 's/color12:/    blue:    /' -e 's/color13:/    magenta: /' -e 's/color14:/    cyan:    /' -e 's/color15:/    white:   /' >> ~/.config/alacritty/colors.yml
echo "  bright:" >> ~/.config/alacritty/colors.yml
grep 'color[89]\|color1[0-5]' /tmp/colors.tmp | sed -e 's/color8:/    black:   /' -e 's/color9:/    red:     /' -e 's/color10:/    green:   /' -e 's/color11:/    yellow:  /' -e 's/color12:/    blue:    /' -e 's/color13:/    magenta: /' -e 's/color14:/    cyan:    /' -e 's/color15:/    white:   /' >> ~/.config/alacritty/colors.yml
rm /tmp/colors.tmp
