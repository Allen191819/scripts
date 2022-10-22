#! /bin/bash
# DWM自启动脚本

settings() {
	[ $1 ] && sleep $1
	xset s 600
	xset -b
	syndaemon -i 1 -t -K -R -d
	source ~/.xinitrc
	udiskie &
	xss-lock -- betterlockscreen -l &
	wmname LG3D
}

daemons() {
	[ $1 ] && sleep $1
	~/scripts/set-screen.sh &
	~/scripts/tap-to-click.sh &
	dunst &
	mate-power-manager &
	blueman-applet &
	optimus-manager-qt &
	nm-applet &
	clipmenud &
	conky &
    numlockx &
	~/scripts/set-screen.sh check &
    sleep 1 && ~/scripts/wallpaper.sh &
	sleep 1 && picom --config ~/.config/picom/picom.conf --experimental-backends &
	sleep 2 && clash &
	sleep 2 && fcitx5 &
}

every2s() {
	[ $1 ] && sleep $1
	while true; do
		~/scripts/dwm-status.sh &
		sleep 2
	done
}

every300s() {
	[ $1 ] && sleep $1
	while true; do
		BTC=$(curl -g 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT' | jq -r '.price' | awk '{printf "%d", $1 }')
		ETH=$(curl -g 'https://api.binance.com/api/v3/ticker/price?symbol=ETHUSDT' | jq -r '.price' | awk '{printf "%d", $1 }')
		BNB=$(curl -g 'https://api.binance.com/api/v3/ticker/price?symbol=BNBUSDT' | jq -r '.price' | awk '{printf "%d", $1 }')
		[ "$BTC" -gt 0 ] && ~/scripts/edit-profile.sh BTC $BTC
		[ "$ETH" -gt 0 ] && ~/scripts/edit-profile.sh ETH $ETH
		[ "$BNB" -gt 0 ] && ~/scripts/edit-profile.sh BNB $BNB
		~/scripts/set-screen.sh check &
		~/scripts/dwm-status.sh &
		sleep 600
	done
}

every1000s() {
	[ $1 ] && sleep $1
	while true; do
		source ~/.profile
		xset -b &
		#sleep 5 && notify-send "$(date '+%Y-%m-%d')" "$(curl 'wttr.in/HanZhong?format=3')\n$(curl 'wttr.in/WuHan?format=3')" &
		fetchmail -a &
		mailcount=$(ls ~/Mail/inbox/new | wc -w)
		[ "$mailcount" -gt 0 ] && notify-send "📧 NEW MAIL: ${mailcount}" -u low &
		sleep 1000
        ~/scripts/wallpaper.sh
	done
}

daemons 1 &
settings 1 &
every2s 2 &
every300s 1 &
every1000s 30 &
