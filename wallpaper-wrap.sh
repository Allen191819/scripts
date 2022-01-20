#!/usr/bin/sh
killall -9 xwinwrap

wp=$(cat $HOME/scripts/wallpaper-save.sh)

#xwinwrap -g 1920x1080+1080+420 -un -fdt -ni -b -nf -ov -- $HOME/.dotfiles/tag-scripts/scripts/wallpaper-live.sh WID $wp &
xwinwrap -g 1920x1080+0+0 -un -fdt -ni -b -nf -ov -- $HOME/scripts/wallpaper-live.sh WID $wp &
#xwinwrap -g 1920x1080+1920+0 -un -fdt -ni -b -nf -ov -- $HOME/.dotfiles/tag-scripts/scripts/wallpaper-live.sh WID $wp &
#xwinwrap -g 1920x1080+3840+0 -un -fdt -ni -b -nf -ov -- $HOME/scripts/wallpaper-live.sh WID $wp &
