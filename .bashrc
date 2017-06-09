#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}

# Migrate history file to XDG-compliant location
oldhistfile="$HISTFILE"
HISTFILE="${XDG_DATA_HOME}/bash/history"
[ -e "$oldhistfile" ] && mkdir -p $(dirname "$HISTFILE") && mv "$oldhistfile" "$HISTFILE"

HISTFILESIZE=2500
export EDITOR="vim"
export VISUAL="$EDITOR"

if [ -f ~/.bash_aliases ]; then
    mkdir -p "$XDG_CONFIG_HOME/bash"
    mv ~/.bash_aliases "$XDG_CONFIG_HOME/bash/aliases"
fi
if [ -f "$XDG_CONFIG_HOME/bash/aliases" ]; then
    . "$XDG_CONFIG_HOME/bash/aliases"
fi

[ -n "`which ix 2>/dev/null`" ] || alias ix="curl -F 'f:1=<-' ix.io"
password(){ len=${1:-16};ct=${2:-1};tr -cd "[:alnum:]"</dev/urandom|fold -w"$len"|head -n"$ct";}

if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi
if [ -d "$HOME/sources/android/sdk/platform-tools" ] ; then
    export PATH="$PATH:$HOME/sources/android/sdk/platform-tools"
fi

eval $(dircolors ~/.dircolors)

[ -x "$HOME/.bashrc.local" ] && . $HOME/.bashrc.local

