#
# ~/.bash_profile
#

[[ -f ~/.config/bash/.bashrc ]] && . ~/.config/bash/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
