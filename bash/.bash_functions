# list of functions:
# ai <option> <prompt>
# stowthis <file> <category>
# timer <#minutes>m
# qn <foo>
# superlink <option> <file>
# unnamed: restart pulseaudio & alsa

#### Shell GPT ####
# Use Shell_GPT without quotes
function ai () {
    if [[ "${1:0:1}" == "-" || "${1:0:1}" == "—" ]]; then
        sgpt $1 "${*:2}"
    else
        sgpt "$*"
    fi
}
#### Shell GPT ####


#### Stow ####
# `stowthis <file> <package>` moves <file> to the <package> stow directory and creates the symlink
# Why use this over 'stow --adopt'? Because I can 'stowthis' for files in different directories and they go to the same package.
stowthis() {
	#check argument formatting
	if [ "$#" -ne 2 ]; then
		echo "Usage: stowthis <file> <parent>"
		return 1
	fi
	#name of the file to stow
	local filename=$1
	#name of the parent package it's moving to
	local parent=$2
	#check if file exists
	if [ ! -f "$filename" ]; then
		echo "$filename does not exist"
		return 1
	fi
	#check if file is already symlinked
	if [ -L "$filename" ]; then
        echo "$filename is already a symlink for $(readlink "$filename")"
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

# `stownote <note>` appends a note to the target file for reminders about things that might not be configured for automatic environment setup
# `stownote` for verbose usage
stownote() {
  if [ $# -eq 0 ]
  then
    echo "Enter a note to append to .dotfiles/Sources/quick-add.list"
    read -p ">> " note
  else
    note="$*"
  fi
  echo "$note" >> ~/.dotfiles/Sources/quick-add.list
}
#### Stow ####


#### Timer ####
# Start a minimal timer with 'timer [# of minutes]m'
timer() {
  termdown "$1" --blink --no-seconds --no-figlet
}
#### Timer ####

#### Quicknotes ####
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
#### Quicknotes ####


# `superlink <option> <file>` creates symlinks and writes sourcefile metadata for document management
# superlink() {
#   # Usage help
#   if [[ $# -eq 1 || $# -gt 3 || $1 == -* && $# -lt 2 ]]; then
#     echo "Usage: superlink [-option] [thing1] [thing2]"
#     return 1
#   fi
#   # Default backup location
#   BACKUP_DIR=~/backup
#   # Extract option if given
#   local option=""
#   if [[ $1 == -* ]]; then
#     option=$1
#     shift
#   fi
#   # Execute commands based on option
#   case $option in
#     -b|-backup)
#       # Backup option
#       cp $1 $BACKUP_DIR
#       superlink $BACKUP_DIR/$(basename $1) $1
#       ;;
#     -d|-details)
#       # Details option
#       local attrs=$(getfattr --only-values -n symlink-$(date +%s) $1 2> /dev/null)
#       if [[ -z $attrs ]]; then
#         echo "No sourcefile metadata for $1, so it's probably not a source file"
#       else
#         echo "Source links: $attrs"
#       fi
#       if [[ -L $1 ]]; then
#         echo $(readlink $1)
#       else
#         echo "$1 is not a symlink to another file"
#       fi
#       ;;
#     -cm|-clearmetadata)
#       # Clear metadata option
#       attr_keys=$(getfattr -d $1 2> /dev/null | awk -F= '{print $1}')
#       for key in $attr_keys
#       do
#         if [[ $key == symlink-* ]]; then
#           setfattr -x $key $1
#         fi
#       done
#       ;;
#     -s|-status)
#       # Status option
#       local attrs=$(getfattr --only-values -n symlink-$(date +%s) $1 2> /dev/null)
#       if [[ -n $attrs ]]; then
#         for attr in $attrs
#         do
#           if [[ -e $attr && -L $attr && $(readlink $attr) == $1 ]]; then
#             echo "$attr: exists, is a symlink, linked to source"
#           else
#             echo "$attr: does not exist or is not linked to source"
#           fi
#         done
#       else
#         echo "No sourcefile metadata for $1"
#       fi
#       ;;
#     *)
#       # Default: create a symlink
#       ln -s $1 $2
#       setfattr -n "symlink-$(date +%s)" -v "$2" $1
#       ;;
#   esac
# }


#### Restart audio drivers and show status of services
# pulseaudio -k && sudo alsa force-reload
# systemctl --user status pulseaudio.service
# sudo systemctl status alsa-state.service
####



