# linux configuration
- dot files, install scripts, and other turnkey tools 
- by convention lowercase directories can be stowed, others may need special attention

## files
- dot files
- wallpapers
- apt list /etc/apt/sources.list
- apt list (manual) /etc/apt/sources.list.d
	- Sources/apt-sources requires `sudo stow -t / -d ~/.dotfiles/Sources apt-sources` or manual copying (safer)
- pip list
- snap list
- other files & documents not related to system config should use the backup_link.sh script to be symlinked (`ln -s`) to a backup folder and have that symlink saved in the file's xattr metadata 

## scripts
- install applications
- install interface components
- consolidate sources
- consolidate history
- manage quicknotes
- push files

## VM
- guest additions
- machine settings
- shared obsidian folder

## applications
### system
- i3wm
- picom
- alacritty
- dunst
- micro
- conky
- playerctl
- i3ipc
- feh
- wpgtk
- pywal

### packages
- python3
- python3-pip
- github cli
- jupyter
- langchain
- nodejs
- npm
- flowise
- shell_gpt

### user
- obsidian
- brave
- firefox
- chrome
- vs code
- 1password
- spotify
- signal
- slack
- discord
- vlc

