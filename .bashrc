#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
YELLOW="\[\e[1;33m\]"
BLUE="\[\e[1;34m\]"
PURPLE="\[\e[1;35m\]"
CYAN="\[\e[1;36m\]"
RESET="\[\e[m\]"

export XCURSOR_SIZE=16
export LIBVIRT_DEFAULT_URI=qemu:///system

# Path
export PATH="$HOME/scripts:$PATH"

# Alias
alias reload='source ~/.bashrc'

alias ..='cd ..'

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'
alias grep='grep --color=auto'

alias mv="mv -iv"

# Git
source "$HOME/.config/bash/git-completion.bash"
alias ga='git add'
alias gst='git status'
alias gc='git commit'
alias gls='git ls-files'
alias grv='git remote -v'
alias cfg="/usr/bin/git --git-dir=$HOME/config/ --work-tree=$HOME"

# Edit configs
alias bashrc='vim ~/.bashrc'
alias xinitrc='vim ~/.xinitrc'
alias profile='vim ~/.bash_profile'

# Jotta
alias jc="jotta-cli"
alias jcs="jotta-cli status"
alias jco="jotta-cli observe"
alias jcls="jotta-cli ls Backup/$HOSTNAME"

#PS1="$GREEN[$YELLOW\u$GREEN@$CYAN\h $GREEN\W]$YELLOW$(parse_git_branch)$RED$(parse_git_dirty)$GREEN\$ $RESET $(git_status)"

#PS1="\e[1;36m\]\$(parse_git_branch)\[\033[31m\]\$(parse_git_dirty)\n\[\033[1;33m\]  \[\e[1;37m\] \w \[\e[1;36m\]$\[\e[1;37m\] "

# Prompt

function parse_git_dirty {
  STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then printf ""; return; else printf " ["; fi
  if echo ${STATUS} | grep -c "renamed:"         &> /dev/null; then printf " >"; else printf ""; fi
  if echo ${STATUS} | grep -c "branch is ahead:" &> /dev/null; then printf " !"; else printf ""; fi
  if echo ${STATUS} | grep -c "new file::"       &> /dev/null; then printf " +"; else printf ""; fi
  if echo ${STATUS} | grep -c "Untracked files:" &> /dev/null; then printf " ?"; else printf ""; fi
  if echo ${STATUS} | grep -c "modified:"        &> /dev/null; then printf " *"; else printf ""; fi
  if echo ${STATUS} | grep -c "deleted:"         &> /dev/null; then printf " -"; else printf ""; fi
  printf " ]"
}

parse_git_branch() {
  # Long form
  git rev-parse --abbrev-ref HEAD 2> /dev/null
 # Short form
  # git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*\/\(.*\)/\1/'
}

git_status() {
    BRANCH=$(parse_git_branch)
    if [[ $? -ne 0 ]]
    then
        echo ""
	return
    else
	echo "$YELLOW($BRANCH$RED$(parse_git_dirty)$YELLOW)"
    fi
}

update_prompt() {
    PS1="$GREEN[$YELLOW\u$GREEN@$CYAN\h $GREEN\w]$(git_status)$GREEN\$ $RESET"
}

PROMPT_COMMAND=update_prompt
