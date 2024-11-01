
edit_and_reload_sxhkdrc(){
    vim $HOME/.config/sxhkd/sxhkdrc

    killall sxhkd
    sleep 1
    sxhkd &
    notify-send "sxhkd" "Reloaded sxhkdrc"
}
