#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# Keyboard layout
setxkbmap no -option ctrl:nocaps &

# Screen resolution
xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x0 --rotate normal &

# Compositor
picom --config $HOME/.config/picom/picom.conf &

# Statusbar
slstatus &

# wallpaper
$HOME/./.fehbg &

# Hotkey daemon
sxhkd &

# Updates
packageupdates &

# Systray
nm-applet &
blueman-applet &

# Restart loop
while true; do
    dwm >/dev/null 2>&1
done

# Execute dwm
exec dwm

