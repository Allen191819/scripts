#! /bin/bash
: <<!
  设置屏幕分辨率的脚本
  one: INNER
  two: OUT - INNER
  check: 检测显示器连接状态是否变化 -> 调用two
!

INNER_SCREEN=eDP-1-1
OUT1_SCREEN=HDMI-0
OUT2_SCREEN=HDMI-1-1
CONNECT_SCREEN=$(xrandr | grep HDMI | grep ' connected ' | awk '{print $1}')
DISCONNECT_SCREEN=$(xrandr | grep HDMI | grep ' disconnected ' | awk '{print $1}')

_post() {
    ~/scripts/edit-profile.sh SCREEN_MODE $1
    ~/scripts/wallpaper.sh
}
two() {
    [ ! "$CONNECT_SCREEN" ] && one && return;
    xrandr --output $INNER_SCREEN   --mode 1920x1080 --pos 1920x0 --rate 120  --scale 1x1 \
           --output $CONNECT_SCREEN --mode 1920x1080 --pos 0x0    --rate 144  --scale 1x1 --primary \
           --output $DISCONNECT_SCREEN --off
    _post TWO
}
one() {
    xrandr --output $INNER_SCREEN --mode 1920x1080   --pos 0x0    --rate 144  --scale 1x1  --primary  \
           --output $OUT1_SCREEN --off \
           --output $OUt2_SCREEN --off
    _post ONE
}

check() {
    source ~/.profile
    [ "$AUTOSCREEN" = "OFF" ] && return
    [ "$CONNECT_SCREEN" ] && [ "$SCREEN_MODE" == "ONE" ] && two;
    [ ! "$CONNECT_SCREEN" ] && [ "$SCREEN_MODE" != "ONE" ] && two;
}
toggle_auto() {
    source ~/.profile
    [ "$AUTOSCREEN" = "OFF" ] && ~/scripts/edit-profile.sh AUTOSCREEN ON || ~/scripts/edit-profile.sh AUTOSCREEN OFF
    ~/scripts/dwm-status.sh
}

case $1 in
    one) one ;;
    two) two ;;
    check) check ;;
    toggle_auto) toggle_auto ;;
    *) two ;;
esac


