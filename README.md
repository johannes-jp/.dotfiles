# linux configuration
- dot files, install scripts, and other turnkey tools 
- by convention lowercase directories can be stowed
	- such directories outside of the base directory may require special attention to stow properly

## files
- dot files
- wallpapers
- apt list /etc/apt/sources.list
- apt list (manual) /etc/apt/sources.list.d
	- Sources/apt-sources requires `sudo stow -t / -d ~/.dotfiles/Sources apt-sources` or manual copying (safer)
- pip list
- sources.list
- sources.list.d

## scripts
- install applications
- consolidate sources
	- fix installer-status.gz access
- consolidate history
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

