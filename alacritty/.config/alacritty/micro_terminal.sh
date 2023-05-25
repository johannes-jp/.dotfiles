#!/bin/bash

# Get the PID of the micro_terminal Alacritty instance if it exists
micro_terminal_pid=$(pgrep -a alacritty | grep 'micro_terminal' | awk '{print $1}')

# If the micro_terminal is not already running, start a new instance
if [ -z "$micro_terminal_pid" ]; then
  env ALACRITTY_MICRO_TERMINAL=1 alacritty \
    --class micro_terminal \
    -o window.dimensions.lines=1 \
    -o window.dimensions.columns=80 \
    -o window.padding.x=20 \
    -o window.padding.y=5 \
    -o scrolling.history=0
fi
