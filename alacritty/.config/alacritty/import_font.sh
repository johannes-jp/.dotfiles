#!/bin/bash

# Define input and output files
font_yml_file="$HOME/.config/alacritty/alacritty.yml"

# Remove content within font block and replace it with the new font values
sed -i '/# font start/,/# font end/{//!d}' $font_yml_file

temp_file=$(mktemp)

cat << EOF >> "$temp_file"
font:
  normal:
    family: monospace 
  size: 11.0
EOF

sed -i '/# font start/r '"$temp_file" $font_yml_file
echo "Font values have been updated in $font_yml_file."

rm "$temp_file"
