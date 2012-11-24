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
# Autoload zsh modules when they are referenced
# zmodload -a zsh/stat stat
# zmodload -a zsh/zpty zpty
# zmodload -a zsh/zprof zprof
# zmodload -ap zsh/mapfile mapfile

# prompt adam2
# prompt gentoo

zle -N predict-on
zle -N predict-off
zle -N dot

source ~/.zsh/bindkeys
source ~/.zsh/zstyles

local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts

# Ниже даны опции, относящиеся к функциям zsh,
# которыми собственно и определяется мощь этой оболочки
# Shell functions
# setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
# freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
# fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
# for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
# typeset -U path cdpath fpath manpath

