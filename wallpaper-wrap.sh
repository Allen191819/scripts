#!/usr/bin/bash

source ~/.profile

killall mpv >>/dev/null 2>&1
killall xwinwrap >>/dev/null 2>&1

sleep 0.2
[ "$1" ] && rand=$1 || while :; do
	source ~/.profile
	rand=$((RANDOM % 4 + 1))
	[ "$WALLPAPER_RAND" != $rand ] && break
done

mp4_1=~/Pictures/LivePaper/$rand/wallpaper_one.mp4
mp4_2=~/Pictures/LivePaper/$rand/wallpaper_two.mp4
xwinwrap -g 1920x1080+0+0 -un -fdt -ni -b -nf -ov -- $HOME/scripts/wallpaper-live.sh WID $mp4_1 >>/dev/null 2>&1 &

case $SCREEN_MODE in
TWO) xwinwrap -g 1920x1080+1920+0 -un -fdt -ni -b -nf -ov -- $HOME/scripts/wallpaper-live.sh WID $mp4_2 >>/dev/null 2>&1 & ;;
esac
~/scripts/edit-profile.sh WALLPAPER_RAND $rand
