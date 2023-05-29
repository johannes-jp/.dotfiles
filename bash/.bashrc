# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Additional paths
PATH=$PATH:~/.local/bin

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#### Bash history ####
# avoid duplicates
HISTCONTROL=ignoredups:erasedups
# when the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# after each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# history length
HISTSIZE=100000
HISTFILESIZE=100000
####

#### Window (what the container looks like) ####
# TODO move 'set window title from last command' here
# update the values of LINES and COLUMNS ifn when window size changes
shopt -s checkwinsize
# TODO expand truncated lines when window grows 
####

#### Filesystem & Navigation (how you move) ####
#### Filesystem & Navigation ####

#### Formatting & Information (what you see) ####
#### Formatting & Information ####

#### Syntax (what you type) ####
# '**' (globstar) to also select within subdirectories
shopt -s globstar
# TODO move to Formatting & Information
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
## Aliases (where commands named 'foo' go)
# TODO add comm -23 command for listing user apt packages
## Aliases
## Functions (where commands named 'foo()' go)
# TODO make a bash_functions file 

# 'stowthis <file>' moves <file> to the stow directory and creates the symlink
stowthis() {
	#check argument formatting
	if [ "$#" -ne 2 ]; then
		echo "Usage: stowthis <file> <parent>"
		return 1
	fi
	#name of the file to stow
	local filename=$1
	#name of the parent directory it's moving to
	local parent=$2
	#check if file exists
	if [ ! -f "$filename" ]; then
		echo "File does not exist: $filename"
		return 1
	fi
	#check if file is already symlinked
	if [ -L "$filename" ]; then
		echo "File is already a symlink: $filename"
		return 1
	fi
	#get file directory and parent directory name
	local dir=$(realpath $(dirname "$filename"))
	local relative_dir=${dir#$HOME}
	#create a stow directory
	mkdir -p ~/.dotfiles/"$parent$relative_dir"
	#move file to stow directory
	mv "$filename" ~/.dotfiles/"$parent$relative_dir"/
	#stow the new file
	(cd ~/.dotfiles && stow "$parent")
}

# `superlink <option> <file>` creates symlinks and writes sourcefile metadata for document management


## Functions
#### Syntax ####

#### Color TODO move to Formatting & Information ####
# set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
# toggle color prompt
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#### Color ####


# TODO move to Syntax
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# TODO move to Syntax
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#### Connections (where else .bashrc looks) ####
# file for additional aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
#
## Paths
## Paths
#### Connections ####

# TODO move to Syntax
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

. "$HOME/.cargo/env"
# source /home/johannes/src/alacritty/extra/completions/alacritty.bash


# TODO Move to Formatting
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
(cat ~/.cache/wal/sequences &)
# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences
# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

# TODO Move to connections
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


############## User Functions #######################

#### Dynamically set window title based on last command
# TODO move to 'Window' section
function settitle() {
    recent_commands=("$BASH_COMMAND" "${recent_commands[@]:0:$((HISTORY_LIMIT - 1))}")
	window_title=$(printf "%s | " "${recent_commands[@]}" | awk -F'|' '{for(i=NF; i>1; i--) printf "%s | ", $i; print $1}')
    echo -ne "\033]0;${window_title}\007"
}
export HISTORY_LIMIT=1
# Initialize the recent_commands array
declare -a recent_commands
# Set the trap
trap 'settitle' DEBUG
####

# TODO move to Functions
#### `qn foo` to save a quick note in ~/quicknotes, consolidated by date
## version 1 writes the note with bash, but line wrapping is a problem
# function qn {
#     read -r -p "note: " note
#     if [ -z "$note" ]
#     then
#         echo "Usage: qn <note>"
#     else
#         note_dir=~/notes/quicknotes
#         mkdir -p "$note_dir"
#         note_file="${note_dir}/$(date +%Y-%m-%d).md"
#         if [ -e "$note_file" ]
#         then
#             # If the file exists, append a separator line and the note
#             echo -e "---\n$note" >> "$note_file"
#         else
#             # If the file doesn't exist, create it with the note contents
#             echo "$note" > "$note_file"
#         fi
#     fi
# }
##
## version 2 opens an editor that needs to be saved and closed
function qn {
    note_dir=~/notes/quicknotes
    mkdir -p "$note_dir"
    note_file="${note_dir}/$(date +%Y-%m-%d).md"
    
    # If the file exists, append a separator line and start editing
    if [ -e "$note_file" ]
    then
        echo -e "---" >> "$note_file"
    fi

    # Open the file with 'micro' editor
    micro "$note_file"
}
##
####

# TODO move to Formatting
#### Hide cd and username in micro terminal
if [[ $ALACRITTY_MICRO_TERMINAL == "1" ]]; then
    PS1=">"
fi
####
# Use Shell_GPT without quotes
function ai () {
    if [[ "${1:0:1}" == "-" || "${1:0:1}" == "—" ]]; then
        sgpt $1 "${*:2}"
    else
        sgpt "$*"
    fi
}
####

# TODO move to Functions
#### Timer ####
# Start a minimal timer with 'timer [# of minutes]m'
timer() {
  termdown "$1" --blink --no-seconds --no-figlet
}
#### Timer ####


#### Restart audio drivers and show status of services
# pulseaudio -k && sudo alsa force-reload
# systemctl --user status pulseaudio.service
# sudo systemctl status alsa-state.service
####
