#!/usr/bin/bash
killall -9 xwinwrap

sleep 0.2
[ "$1" ] && rand=$1 || while :; do
	source ~/.profile
	rand=$((RANDOM % 4 + 1))
	[ "$WALLPAPER_RAND" != $rand ] && break
done

mp4_1=~/Pictures/LivePaper/$rand/wallpaper_one.mp4
mp4_2=~/Pictures/LivePaper/$rand/wallpaper_two.mp4
xwinwrap -g 1920x1080+0+0 -un -fdt -ni -b -nf -ov -- $HOME/scripts/wallpaper-live.sh WID $mp4_1 &
xwinwrap -g 1920x1080+1920+0 -un -fdt -ni -b -nf -ov -- $HOME/scripts/wallpaper-live.sh WID $mp4_2 &

~/scripts/edit-profile.sh WALLPAPER_RAND $rand
