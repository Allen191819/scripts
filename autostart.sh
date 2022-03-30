#! /bin/bash
# DWM自启动脚本

settings() {
	[ $1 ] && sleep $1
	xset s 600
	xset -b
	syndaemon -i 1 -t -K -R -d
	xss-lock -- multilockscreen -l &
}

daemons() {
	[ $1 ] && sleep $1
	~/scripts/set-screen.sh &
	dunst &
	mate-power-manager &
	blueman-applet &
	optimus-manager-qt &
	nm-applet &
	clipmenud &
    conky &
	~/scripts/tap-to-click.sh &
	sleep 1 && picom --config ~/.config/picom/picom.conf &
	sleep 2 && qv2ray &
	sleep 5 && fcitx5 &
}

every2s() {
	[ $1 ] && sleep $1
	while true; do
		~/scripts/dwm-status.sh &
		sleep 2
	done
}

every1000s() {
	[ $1 ] && sleep $1
	while true; do
		source ~/.profile
		xset -b
		xmodmap ~/.Xmodmap
		hanzhong=$(curl 'wttr.in/HanZhong?format=3')
		wuhan=$(curl 'wttr.in/WuHan?format=3')
		sleep 5 && notify-send "$(date '+%Y-%m-%d')" "$hanzhong\n$wuhan" &
		sleep 1000
		~/scripts/set-screen.sh check &
		~/scripts/wallpaper.sh &
	done
}

daemons 1 &
settings 1 &
every2s 2 &
every1000s 30 &
