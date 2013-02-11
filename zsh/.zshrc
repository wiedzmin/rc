if [ `uname -s` = "Linux" ]; then
    eval `dircolors -b`
fi
umask 0077

#straightforward way to switch between oh-my-zsh and my own
USE_OH_MY_ZSH=1

if [[ $USE_OH_MY_ZSH == 1 ]] ; then
    ZSH=$HOME/.oh-my-zsh
    ZSH_THEME="agnoster"
    plugins=(git mercurial)
    source $ZSH/oh-my-zsh.sh
else
    source ~/.zsh/constants
fi

# history
HISTFILE=~/.histfile
HISTSIZE=10240 # Чucлo koмaнg, coxpaняeмыx в сеансе
SAVEHIST=10240 # Число команд, сохраняемых в HISTFILE

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
