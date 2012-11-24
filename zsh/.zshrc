eval `dircolors -b`
umask 0077

source ~/.zsh/constants
source ~/.zsh/hooks
source ~/.zsh/setopts
source ~/.zsh/aliases
source ~/.zsh/functions

autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -U dot
autoload -U predict-on
autoload run-help
zmodload zsh/complist

zle -N predict-on
zle -N predict-off
zle -N dot

source ~/.zsh/bindkeys
source ~/.zsh/zstyles

local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts
