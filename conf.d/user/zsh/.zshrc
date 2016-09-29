if [ `uname -s` = "Linux" ]; then
    eval `dircolors -b`
fi
umask 0077

# history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

#straightforward way to switch between oh-my-zsh and my own
USE_OH_MY_ZSH=1

source ~/common_settings
source ~/.zsh/variables

if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
else
    if [[ $USE_OH_MY_ZSH == 1 ]]
    then
        ZSH=$HOME/.oh-my-zsh
        ZSH_THEME="clean"
        plugins=(dircycle fasd nyan urltools vagrant zsh-syntax-highlighting sudo fzf-marks docker docker-compose emacs)
        source $ZSH/oh-my-zsh.sh
    else
        source ~/.zsh/promptdefs
    fi

    source ~/.zsh/setopts

    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
    source ~/.zsh/aliases
    source ~/.zsh/functions
    source ~/.zsh/zstyles
    source ~/.zsh/custom
    source ~/.zsh/bindkeys
fi
