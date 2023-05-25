#!/bin/bash

# Generate Micro color scheme from Xresources

input_file="micro_color_links.txt"
output_file=~/.config/micro/colorschemes/xresources.micro

echo "Generating Micro color scheme from Xresources"

# Header
cat > "$output_file" <<EOL
# Micro color scheme generated from Xresources

EOL

# Parse Xresources colors
colors=$(xrdb -query -all | grep -E '^(\*.color[0-9]*):' | sed -e 's/:/ /' -e 's/\*\.//' -e 's/color\([0-9]\{1,\}\)/color\1/g' -e 's/#//' | awk '{printf("%s=\"#%s\"\n", $1, $2);}')

# Replace colors in Micro config and output to the output file
while read -r line; do
    key=$(echo "$line" | awk '{print $2}')
    color=$(echo "$colors" | grep -E "$key " | awk -F'=' '{print $2}')
    echo "color-link $line" | sed "s/$key/$color/g" >> "$output_file"
done < "$input_file"

echo "Color scheme saved to $output_file"
