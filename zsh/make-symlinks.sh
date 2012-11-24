#!/bin/sh

CURRENT_DIR=`pwd`
echo "Making symlinks to zsh config repository ($CURRENT_DIR --> $HOME)"

ln -s $CURRENT_DIR/.zsh $HOME/.zsh
ln -s $CURRENT_DIR/.zshrc $HOME/.zshrc

