#! /bin/bash
# 命令调用脚本

source ~/.profile

sk() {
    case $SCREEN_MODE in
        ONE) killall screenkey || screenkey -p fixed -g 66%x8%+17%-5% & ;;
        TWO) killall screenkey || screenkey -p fixed -g 50%x8%+25%-11% & ;;
    esac
}

st_geometry() {
    x=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    [ "$x" -lt 1920 ] && echo "+10+30" || echo "+1930+355"
}

case $1 in
    pcmanfm) pcmanfm ;;
    rofi) ~/.dotfiles/tag-polybar/config/polybar/cuts/scripts/launcher.sh ;;
    lock) multilockscreen ;;
    browser) brave-browser-beta ;;
    pavucontrol) pavucontrol ;;
    postman) postman ;;
    tim) /opt/apps/com.qq.tim.spark/files/run.sh ;;
    qq) icalingua ;;
    clipboard) clipmenu ;;
    notebook) jupyter notebook ;;
    wechat) /opt/apps/com.qq.weixin.deepin/files/run.sh ;;
    term) alacritty ;;
    flameshot) flameshot gui ;;
    screenkey) sk ;;
    surf) /usr/local/bin/surf $2 >> /dev/null 2>&1 & ;;
    clock) ~/scripts/lib/clockst -c float -g 60x15$(st_geometry) -e tty-clock -csDC 7 & ;;
    ast) st ;;
    music) listen1 ;;
    virt) virt-manager ;;
esac
