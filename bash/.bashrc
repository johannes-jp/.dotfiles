# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

#set default i3-sensible-terminal
#export TERMINAL=/usr/bin/alacritty
#export TERM=alacritty
#export VIMINIT='source $HOME/.vimrc'
########  Connections  ########
# (where else .bashrc looks)  #
###############################

# Paths
PATH=$PATH:~/.local/bin:~/.local/share/gem/ruby/3.0.0/bin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# . "$HOME/.cargo/env"
# source /home/johannes/src/alacritty/extra/completions/alacritty.bash

## Sources [
# Aliases, Functions, Profiles & Environment Variables
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi
if [ -f ~/.bash_functions ]; then . ~/.bash_functions; fi
if [ -f ~/.env ]; then . ~/.env; fi
## Sources ]

# Shell-GPT integration [
_sgpt_bash() {
    READLINE_LINE=$(sgpt --shell <<< "$READLINE_LINE")
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-l": _sgpt_bash'
# Shell-GPT integration ]

########  Connections  ########

#############  Window  ##############
## (what the container looks like) ##
#####################################

#### Title
# Initialize the recent_commands array
declare -a recent_commands
export HISTORY_LIMIT=1

function settitle() {
    # Store the current command in the array
    recent_commands=("$BASH_COMMAND" "${recent_commands[@]:0:$((HISTORY_LIMIT - 1))}")
    
    # Set the terminal title based on the current command
    local title
    local last_command="${recent_commands[0]}"
    if [[ "$last_command" == *vim* ]] || [[ "$last_command" == *nano* ]] || [[ "$last_command" == *micro* ]] || [[ "$last_command" == *edit* ]]; then
        title="$last_command"
    else
        if [ "$PWD" == "$HOME" ]; then
            title="home"
        else
            title="${PWD/$HOME/\~}"
        fi
    fi
    # Print the terminal title
    echo -ne "\033]0;$title\007"
}

# Set PROMPT_COMMAND
PROMPT_COMMAND=settitle


# update the values of LINES and COLUMNS ifn when window size changes
shopt -s checkwinsize

# TODO expand truncated lines when window grows 
#############  Window  ##############


###### Filesystem & Navigation ######
########## (how you move) ###########
#####################################

###### Filesystem & Navigation ######


####### Syntax ######
## (what you type) ##
#####################

# '**' (globstar) to also select within subdirectories
shopt -s globstar

# enable programmable completion features if not already enabled in /etc/bash.bashrc and /etc/profile
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## Aliases (where commands named 'foo' go) ##
# see also .bash_aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# Add an "alert" alias for long running commands. Usage: sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
## Aliases /
## Functions (where commands named 'foo()' go)
# see also .bash_functions
## Functions /
###### Syntax ######


####  Formatting & Information  ####
#########  (what you see)  #########
####################################

## Bash history ##
# avoid duplicates
# HISTCONTROL=ignoredups:erasedups

# when the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# history length
HISTSIZE=100000
HISTFILESIZE=100000

# append each command to a separate shared history file (for testing)
# HISTFILE_SHARED=$HOME/.bash_history_shared
# PROMPT_COMMAND='history -a; history -w $HISTFILE_SHARED; $PROMPT_COMMAND'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# hide cd and username in custom 'micro terminal'
if [[ $ALACRITTY_MICRO_TERMINAL == "1" ]]; then
    PS1=">"
fi

## Color ##
set a fancy prompt
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

# color prompt from xresources (tput setaf #)
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[$(tput bold; tput setaf 2)\]\u@\h\[$(tput bold; tput setaf 4)\]\w\[$(tput sgr0)\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi


unset color_prompt force_color_prompt
# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

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

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
# (cat ~/.cache/wal/sequences &)
# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences
# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh
#### Color / ####
#### Formatting & Information ####


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

