#! /bin/bash
# DWM自启动脚本

settings() {
    [ $1 ] && sleep $1
    xset s 600
    xset -b
    syndaemon -i 1 -t -K -R -d
    xss-lock -- multilockscreen -l &
    # ~/scripts/set-screen.sh &
}

daemons() {
    [ $1 ] && sleep $1
    dunst &
    mate-power-manager &
    fcitx5 &
    clipmenud &
    blueman-applet &
    optimus-manager-qt &
    #pactl info &
    nm-applet &
    ~/scripts/tap-to-click.sh &
    ~/scripts/dwm-status.sh &
    #~/scripts/wallpaper.sh &
    #/usr/lib/gsd-xsettings &
    #~/scripts/wine-notify.sh &
    ~/scripts/wallpaper-wrap.sh &
    sleep 3 && picom --config ~/.config/picom/picom.conf &
    sleep 10 && qv2ray &
}

every10s() {
    [ $1 ] && sleep $1
    while true
    do
        # ~/scripts/set-screen.sh check &
        ~/scripts/dwm-status.sh &
        sleep 2
    done
}

every1000s() {
    [ $1 ] && sleep $1
    while true
    do
        source ~/.profile
        xset -b
        xmodmap ~/.Xmodmap
        # fetchmail -k
        notify-send "$(date '+%Y-%m-%d')" "$(curl 'wttr.in/HanZhong?format=3')\n$(curl 'wttr.in/WuHan?format=3')" &
        # mailcount=`ls ~/Mail/inbox/new | wc -w`
        # [ "$mailcount" -gt 0 ] && notify-send "💬 NEW MAIL: ${mailcount}" -u low
        sleep 1000
        # [ "$WALLPAPER_MODE" = "PIC" ] && ~/.scripts/wallpaper.sh &
    done
}

every10s 5 &
daemons 3 &
every1000s 30 &
settings 1 &
