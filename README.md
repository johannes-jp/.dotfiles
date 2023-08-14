# linux configuration
- dot files, install scripts, and other turnkey tools 
- convention:
    - lowercase directories can be stowed
    - uppercase directories store:
        - manual configurations
        - stows needing special access
        - references & imports

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

