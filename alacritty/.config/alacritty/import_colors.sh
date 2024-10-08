#!/bin/bash

# Define input and output files
xresources_file="$HOME/.Xresources"
colors_yml_file="$HOME/.config/alacritty/alacritty.yml"

# Extract color values
color_values=()
for i in {0..15}; do
    color_values[i]=$(grep -Po "(?<=\*color${i}: ).*" "$xresources_file")
done

# Remove content under 'colors:' tag and replace it with the new color values
# sed -i '/^colors:/,/^[^[:space:]]/!b;//!d' "$colors_yml_file"

# Remove content within colors block and replace it with the new color values
sed -i '/# colors start/,/# colors end/{//!d}' $colors_yml_file

temp_file=$(mktemp)

cat << EOF >> "$temp_file"
colors:
  primary:
    background: '${color_values[0]}'
    foreground: '${color_values[7]}'

  normal:
    black:   '${color_values[0]}'
    red:     '${color_values[1]}'
    green:   '${color_values[2]}'
    yellow:  '${color_values[3]}'
    blue:    '${color_values[4]}'
    magenta: '${color_values[5]}'
    cyan:    '${color_values[6]}'
    white:   '${color_values[7]}'

  bright:
    black:   '${color_values[8]}'
    red:     '${color_values[9]}'
    green:   '${color_values[10]}'
    yellow:  '${color_values[11]}'
    blue:    '${color_values[12]}'
    magenta: '${color_values[13]}'
    cyan:    '${color_values[14]}'
    white:   '${color_values[15]}'
EOF

sed -i '/# colors start/r '"$temp_file" $colors_yml_file
echo "Color values have been updated in $colors_yml_file."

rm "$temp_file"
