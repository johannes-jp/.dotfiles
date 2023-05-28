current_wallpaper="$(grep 'file=' ~/.config/nitrogen/bg-saved.cfg | sed 's/file=//')"
wal -i "$current_wallpaper"
cat ~/.cache/wal/colors.Xresources >> ~/.Xresources
xrdb -load ~/.Xresources