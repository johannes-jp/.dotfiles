alias python='python3'
# lists manually installed apt pkgs, excluding installer pkgs
alias userapts="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"


# Other filepaths
wallpapers='/usr/share/backgrounds'

# Config files
xresourcesfile='/home/johannes/.Xresources'
i3file='/home/johannes/.config/i3/config'
picomfile='/home/johannes/.config/picom/picom.conf'
conkyfile='/home/johannes/.conkyrc'
alacrittyfile='/home/johannes/.config/alacritty/alacritty.yml'
bashfile='/home/johannes/.bashrc'
aliasfile='/home/johannes/.bash_aliases'

# Config filepaths
alias xresourcespath='cd "$(dirname $xresourcesfile)"'
alias i3path='cd "$(dirname $i3file)"'
alias i3pathtest='cd "$(dirname $i3file)"'
alias picompath='cd "$(dirname $picomfile)"'
alias alacrittypath='cd "$(dirname $alacrittyfile)"'

# Edit configs
alias xresourcesedit='edit_file "$xresourcesfile"'
alias i3edit='edit_file "$i3file"'
alias {picomedit,compositoredit}='edit_file "$picomfile"'
alias conkyedit='edit_file "$conkyfile"'
alias bashedit='edit_file "$bashfile"'
alias aliasedit='edit_file "$aliasfile"'
alias alacrittyedit='edit_file "$alacrittyfile"'

# Edit in new Code window
alias vscode='code -n'

# Refresh functions
alias {refreshbash,bashrefresh}='source ~/.bashrc'

# Functions
function edit_file() {
  local file_path="$1"
  local editor="${2:-micro}"
  "$editor" "$file_path"
}


