#! /bin/bash
# dwm状态栏刷新脚本

source ~/.profile

s2d_reset="^d^"
s2d_fg="^c"
s2d_bg="^b"
color00="#2D1B46^"
color01="#223344^"
color02="#4E5173^"
color03="#333344^"
color04="#111199^"
color05="#442266^"
color06="#335566^"
color07="#334466^"
color08="#553388^"
color09="#CCCCCC^"

cpu_color="$s2d_fg$color00$s2d_bg$color06"
d_cpu_color="$s2d_fg$color09$s2d_bg$color06"
mem_color="$s2d_fg$color05$s2d_bg$color07"
d_mem_color="$s2d_fg$color09$s2d_bg$color07"
mail_color="$s2d_fg$color03$s2d_bg$color02"
light_color="$s2d_fg$color00$s2d_bg$color06"
time_color="$s2d_fg$color00$s2d_bg$color06"
vol_color="$s2d_fg$color08$s2d_bg$color07"
bat_color="$s2d_fg$color00$s2d_bg$color02"
others_color="$s2d_fg$color04$s2d_bg$color06"
download_color="$s2d_fg$color00$s2d_bg$color02"
upload_color="$s2d_fg$color00$s2d_bg$color02"
docker_color="$s2d_fg$color08$s2d_bg$color07"

print_cpu() {
	cpu_icon=""
	cpu_text=$(top -n 1 -b | sed -n '3p' | awk '{printf "%02d", 100 - $8}')

	if [ "$cpu_text" -ge 90 ]; then
		light="━━━━━━━━━━"
		dark=""
	elif [ "$cpu_text" -ge 80 ]; then
		light="━━━━━━━━━"
		dark="━"
	elif [ "$cpu_text" -ge 70 ]; then
		light="━━━━━━━━"
		dark="━━"
	elif [ "$cpu_text" -ge 60 ]; then
		light="━━━━━━━"
		dark="━━━"
	elif [ "$cpu_text" -ge 50 ]; then
		light="━━━━━━"
		dark="━━━━"
	elif [ "$cpu_text" -ge 40 ]; then
		light="━━━━━"
		dark="━━━━━"
	elif [ "$cpu_text" -ge 30 ]; then
		light="━━━━"
		dark="━━━━━━"
	elif [ "$cpu_text" -ge 20 ]; then
		light="━━━"
		dark="━━━━━━━"
	elif [ "$cpu_text" -ge 10 ]; then
		light="━━"
		dark="━━━━━━━━"
	elif [ "$cpu_text" -ge 0 ]; then
		light="━"
		dark="━━━━━━━━━"
	else
		light=""
		dark="━━━━━━━━━━"
	fi

	cpu_text=$cpu_text%

	text1=" $cpu_icon $light"
	text2="$dark"
	text3=" $cpu_text "

	color1=$cpu_color
	color2=$d_cpu_color

	printf "%s%s%s" "$color1" "$text1" "$s2d_reset"
	printf "%s%s%s" "$color2" "$text2" "$s2d_reset"
	printf "%s%s%s" "$color1" "$text3" "$s2d_reset"
}

print_mem() {
	available=$(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}')
	total=$(grep -m1 'MemTotal:' /proc/meminfo | awk '{print $2}')
	mem_icon=""
	mem_text=$(echo $((($total - $available) * 100 / $total)) | awk '{printf "%02d", $1}')

	if [ "$mem_text" -ge 90 ]; then
		light="━━━━━━━━━━"
		dark=""
	elif [ "$mem_text" -ge 80 ]; then
		light="━━━━━━━━━"
		dark="━"
	elif [ "$mem_text" -ge 70 ]; then
		light="━━━━━━━━"
		dark="━━"
	elif [ "$mem_text" -ge 60 ]; then
		light="━━━━━━━"
		dark="━━━"
	elif [ "$mem_text" -ge 50 ]; then
		light="━━━━━━"
		dark="━━━━"
	elif [ "$mem_text" -ge 40 ]; then
		light="━━━━━"
		dark="━━━━━"
	elif [ "$mem_text" -ge 30 ]; then
		light="━━━━"
		dark="━━━━━━"
	elif [ "$mem_text" -ge 20 ]; then
		light="━━━"
		dark="━━━━━━━"
	elif [ "$mem_text" -ge 10 ]; then
		light="━━"
		dark="━━━━━━━━"
	elif [ "$mem_text" -ge 0 ]; then
		light="━"
		dark="━━━━━━━━━"
	else
		light=""
		dark="━━━━━━━━━━"
	fi

	mem_text=$mem_text%

	text1=" $mem_icon $light"
	text2="$dark"
	text3=" $mem_text "

	color1=$mem_color
	color2=$d_mem_color

	printf "%s%s%s" "$color1" "$text1" "$s2d_reset"
	printf "%s%s%s" "$color2" "$text2" "$s2d_reset"
	printf "%s%s%s" "$color1" "$text3" "$s2d_reset"
}

print_coins() {
	text=" ﴑ:$BTC ﲹ:$ETH  :$BNB "
	color=$coin_color
	printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_mail() {
	mail_text="$(ls ~/Mail/inbox/new | wc -w)"
	if [ "$mail_text" -gt 0 ]; then
		mail_icon=""

		text=" $mail_icon $mail_text "
		color=$mail_color
		printf "%s%s%s" "$color" "$text" "$s2d_reset"
	fi
}

print_time() {
	time_text="$(date '+%D %H:%M')"
	case "$(date '+%I')" in
	"01") time_icon="" ;;
	"02") time_icon="" ;;
	"03") time_icon="" ;;
	"04") time_icon="" ;;
	"05") time_icon="" ;;
	"06") time_icon="" ;;
	"07") time_icon="" ;;
	"08") time_icon="" ;;
	"09") time_icon="" ;;
	"10") time_icon="" ;;
	"11") time_icon="" ;;
	"12") time_icon="" ;;
	esac

	text=" $time_icon $time_text "
	color=$time_color
	printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_vol() {
	volunmuted=$(pamixer --get-mute)

	vol_text=$(pamixer --get-volume)
	if [ "$volunmuted" = true ]; then
		vol_text="--"
		vol_icon="婢"
	elif [ "$vol_text" -eq 0 ]; then
		vol_text="--"
		vol_icon="婢"
	elif [ "$vol_text" -lt 10 ]; then
		vol_icon="奄"
		vol_text=0$vol_text
	elif [ "$vol_text" -le 20 ]; then
		vol_icon="奄"
	elif [ "$vol_text" -le 60 ]; then
		vol_icon="奔"
	else vol_icon="墳"; fi
	vol_text=$vol_text%

	text=" $vol_icon $vol_text "
	color=$vol_color
	printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_bat() {
	bat_text=$(expr $(acpi -b | sed 2d | awk '{print $4}' | grep -Eo "[0-9]+"))
	[ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ] && charge_icon=""
	if [ "$bat_text" -ge 95 ]; then
		charge_icon=""
		bat_icon=""
	elif [ "$bat_text" -ge 90 ]; then
		bat_icon=""
	elif [ "$bat_text" -ge 80 ]; then
		bat_icon=""
	elif [ "$bat_text" -ge 70 ]; then
		bat_icon=""
	elif [ "$bat_text" -ge 60 ]; then
		bat_icon=""
	elif [ "$bat_text" -ge 50 ]; then
		bat_icon=""
	elif [ "$bat_text" -ge 40 ]; then
		bat_icon=""
	elif [ "$bat_text" -ge 30 ]; then
		bat_icon=""
	elif [ "$bat_text" -ge 20 ]; then
		bat_icon=""
	elif [ "$bat_text" -ge 10 ]; then
		bat_icon=""
	else bat_icon=""; fi

	bat_text=$bat_text%
	bat_icon=$charge_icon$bat_icon

	text=" $bat_icon $bat_text "
	color=$bat_color
	printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_light() {

	light_text=$(light -G)
	light_text=${light_text%.*}
	if [ "$light_text" -eq 0 ]; then
		light_icon=""
	elif [ "$light_text" -lt 10 ]; then
		light_icon=""
		light_text=0$light_text
	elif [ "$light_text" -le 20 ]; then
		light_icon=""
	elif [ "$light_text" -le 30 ]; then
		light_icon=""
	elif [ "$light_text" -le 40 ]; then
		light_icon=""
	elif [ "$light_text" -le 50 ]; then
		light_icon=""
	elif [ "$light_text" -le 60 ]; then
		light_icon=""
	elif [ "$light_text" -le 70 ]; then
		light_icon=""
	elif [ "$light_text" -le 80 ]; then
		light_icon=""
	elif [ "$light_text" -le 90 ]; then
		light_icon=""
	else light_icon=""; fi

	light_text=$light_text%
	text=" $light_icon $light_text "
	color=$light_color
	printf "%s%s%s" "$color" "$text" "$s2d_reset"

}

print_others() {
	if [ "$(ps -ef | grep clash | wc -l)" -eq 2 ]; then
		vpn_icon=" "
		if [ "$vpn_icon" ]; then
			text=" $vpn_icon "
			color=$others_color
			printf "%s%s%s" "$color" "$text" "$s2d_reset"
		fi
	fi
}

print_docker() {
    docker_num=$(($(docker ps | wc -l)-1))
    docker_icon=" "
    text=" $docker_icon $docker_num "
    color=$docker_color
    printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_down_traffic() {
	icon=' '
	RECIEVE1=0
	RECIEVE2=0
	IFACES=$(ip -o link show | awk -F': ' '{print $2}')
	for IFACE in $IFACES; do
		if [ $IFACE == "wlan0" ] || [ $IFACE == "lo" ]; then
			RECIEVE1=$(($(ifconfig $IFACE | grep "RX packets" | awk '{print $5}') + $RECIEVE1))
		fi
	done
	sleep 1
	IFACES=$(ip -o link show | awk -F': ' '{print $2}')
	for IFACE in $IFACES; do
		if [ $IFACE == "wlan0" ] || [ $IFACE == "lo" ]; then
			RECIEVE2=$(($(ifconfig $IFACE | grep "RX packets" | awk '{print $5}') + $RECIEVE2))
		fi
	done
	text=" $icon$(expr $(expr $RECIEVE2 - $RECIEVE1) / 1000)KB/s "
	color=$download_color
	printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_up_traffic() {
	icon=' '
	TRANSMIT1=0
	TRANSMIT2=0
	IFACES=$(ip -o link show | awk -F': ' '{print $2}')
	for IFACE in $IFACES; do
		if [ $IFACE == "wlan0" ] || [ $IFACE == "eno1" ]; then
			TRANSMIT1=$(($(ifconfig $IFACE | grep "TX packets" | awk '{print $5}') + TRANSMIT1))
		fi
	done
	sleep 1
	IFACES=$(ip -o link show | awk -F': ' '{print $2}')
	for IFACE in $IFACES; do
		if [ $IFACE == "wlan0" ] || [ $IFACE == "eno1" ]; then
			TRANSMIT2=$(($(ifconfig $IFACE | grep "TX packets" | awk '{print $5}') + TRANSMIT2))
		fi
	done
	text=" $icon$(expr $(expr $TRANSMIT2 - $TRANSMIT1) / 1000)KB/s "
	color=$upload_color
	printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

xsetroot -name "$(print_coins)$(print_down_traffic)$(print_up_traffic)$(print_docker)$(print_cpu)$(print_mem)$(print_mail)$(print_time)$(print_vol)$(print_light)$(print_bat)$(print_others)"
